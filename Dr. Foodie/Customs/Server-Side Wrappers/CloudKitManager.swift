//
//  CloudKitManager.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/15/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import CloudKit

// MARK: Properties
class CloudKitManager {
    private static var DATABASE: CKDatabase {
        return CKContainer.default().publicCloudDatabase
    }
}

// MARK: Action Enums
extension CloudKitManager {
    public enum AccountAction {
        case login, signup, update
    }
    
    public enum QuickAddAction {
        case fetch, update
    }
    
    public enum MealAction {
        case fetch, upload
    }
    
    public enum CategoryAction {
        case fetch, set, remove, upload
    }
}

// MARK: Main Methods
extension CloudKitManager {
    static func account(for user: User, action: AccountAction, completion: @escaping () -> Void) {
        let recordID = CKRecord.ID(recordName: user.id)
        
        switch action {
        case .login:
            DATABASE.fetch(withRecordID: recordID) { (record, error) in
                if let error = error {
                    print(error)
                    account(for: user, action: .signup, completion: completion)
                    return
                }
                
                if let information = record {
                    user.login(firstName: information["firstName"]!, lastName: information["lastName"]!, email: information["email"]!)
                    user.login(sex: information["sex"]!, age: information["age"]!, weight: information["weight"]!, height: information["height"]!)
                    _ = User.authorized(account: user)
                    
                    completion()
                } else {
                    print("no information provided?")
                }
            }
        case .signup:
            let record = CKRecord(recordType: "UserInfo", recordID: recordID)
            
            record["firstName"] = user.firstName
            record["lastName"] = user.lastName
            record["email"] = user.email
            record["id"] = user.id
            record["sex"] = user.sex
            record["age"] = user.age
            record["height"] = user.height
            record["weight"] = user.weight
            
            DATABASE.save(record) { (_, _) in
                completion()
            }
            
            _ = User.authorized(account: user)
        case .update:
            DATABASE.fetch(withRecordID: recordID) { (record, error) in
                if let record = record {
                    record["firstName"] = user.firstName
                    record["lastName"] = user.lastName
                    record["email"] = user.email
                    record["id"] = user.id
                    record["sex"] = user.sex
                    record["age"] = user.age
                    record["height"] = user.height
                    record["weight"] = user.weight

                    modifyOperation(on: [record])
                } else {
                    print(error.debugDescription)
                }
            }
        }
    }
    
    static func quickAdd(action: QuickAddAction, completion: @escaping () -> Void) {
        let recordID = CKRecord.ID(recordName: "QuickAdd.data.\(User.authorized()?.id ?? "")")
        switch action {
        case .fetch:
            DATABASE.fetch(withRecordID: recordID) { (record, error) in
                if let error = error {
                    print(error.localizedDescription)
                }

                if let information = record {
                    let names = information["names"]! as! [String]
                    let photos = information["images"]! as! [CKAsset]

                    var buffer = 0
                    for name in names {
                        QuickAddData.add(container: QuickAddContainer(image: photos[buffer].fileURL!, called: name))
                        buffer += 1
                    }
                }
                
                completion()
            }
        case .update:
            let record = CKRecord(recordType: "QuickAddData", recordID: recordID)
            
            let data = QuickAddData.extract()
            record["names"] = data.names
            record["images"] = data.images as __CKRecordObjCValue
            
            modifyOperation(on: [record])
            completion()
        }
    }
    
    static func meals(action: MealAction, completion: @escaping () -> Void) {
        switch action {
        case .fetch:
            let predicate = NSPredicate(value: true)
            let query = CKQuery(recordType: "ScannedFood", predicate: predicate)
            DATABASE.perform(query, inZoneWith: CKRecordZone.default().zoneID) { (results, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                results!.forEach { (result) in
                    if result.recordID.recordName.contains(User.authorized()?.id ?? "") {
                        do {
                            let names = result["names"] as! [String]
                            let image = result["image"] as! CKAsset
                            let date = result["date"] as! Date
                            let nutrition = try NSKeyedUnarchiver.unarchivedObject(ofClass: NutritionOutput.self, from: result["nutrition"]!)!
                            
                            JournalManager.add(meal: JournalManager.Food(names: names, image: image.fileURL!, time: date, nutritionInformation: nutrition))
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
                
                completion()
            }
        case .upload:
            let id = CKRecord.ID(recordName: "ScannedFood.\(JournalManager.count).\(User.authorized()?.id ?? "")")
            let record = CKRecord(recordType: "ScannedFood", recordID: id)
            
            let data = JournalManager.meals.last!
            record["names"] = data.names
            record["image"] = data.image.cloud()
            record["date"] = data.time as NSDate
            do {
                record["nutrition"] = try NSKeyedArchiver.archivedData(withRootObject: data.nutritionInformation, requiringSecureCoding: false)
            } catch {
                print(error.localizedDescription)
            }
            
            DATABASE.save(record) { (record, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                completion()
            }
        }
    }
    
    static func categories(action: CategoryAction, completion: @escaping ([String]) -> Void) {
        let recordID = CKRecord.ID(recordName: "RestaurantCategories.\(User.authorized()?.id ?? "")")
        let record = CKRecord(recordType: "RestaurantCategories", recordID: recordID)
        
        switch action {
        case .fetch:
            DATABASE.fetch(withRecordID: recordID) { (record, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                completion(record!["names"]! as! [String])
            }
        case .set:
            record["names"] = RestaurantCategories.categories
            
            DATABASE.save(record) { (record, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                
                completion(record!["names"] as! [String])
            }
        case .upload, .remove:
            record["names"] = RestaurantCategories.categories
            
            modifyOperation(on: [record])
        }
    }
}

// MARK: Helper Methods
extension CloudKitManager {
    static func modifyOperation(on records: [CKRecord]) {
        let modify = CKModifyRecordsOperation(recordsToSave: records, recordIDsToDelete: nil)
        modify.savePolicy = .changedKeys
        modify.qualityOfService = .userInitiated
        modify.modifyRecordsCompletionBlock = { savedRecords, deletedRecordIDs, error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        DATABASE.add(modify)
    }
}

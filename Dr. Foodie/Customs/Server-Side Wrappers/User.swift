//
//  User.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/4/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import Foundation
import AuthenticationServices
import CloudKit

class User: NSObject, NSCoding {
    
    // MARK: NSCoding
    required convenience init?(coder: NSCoder) {
        guard
            let id = coder.decodeObject(forKey: "id") as? String,
            let firstName = coder.decodeObject(forKey: "firstName") as? String,
            let lastName = coder.decodeObject(forKey: "lastName") as? String,
            let email = coder.decodeObject(forKey: "email") as? String,
            let sex = coder.decodeObject(forKey: "sex") as? String else {
                return nil
        }
        
        let age = coder.decodeInteger(forKey: "age")
        let weight = coder.decodeInteger(forKey: "weight")
        let height = coder.decodeInteger(forKey: "height")
        
        self.init(firstName: firstName, lastName: lastName, contact: email, key: id, sex: sex, age: age, height: height, weight: weight) {
            
        }
    }

    // MARK: Constructors & Properties
    static let key = "SignedAccount"
    static var zero: User {
        get {
            return User()
        }
    }
    static private var _authorized: User?
    
    private(set) var id: String
    private(set) var firstName: String
    private(set) var lastName: String
    private(set) var email: String
    private(set) var sex: String
    private(set) var age: Int
    private(set) var height: Int
    private(set) var weight: Int
    
    // MARK: Apple
    init(credentials: ASAuthorizationAppleIDCredential, sex: String, age: Int, weight: Int, height: Int, completion: @escaping () -> Void) {
        id = credentials.user
        
        firstName = credentials.fullName?.givenName ?? ""
        lastName = credentials.fullName?.familyName ?? ""
        email = credentials.email ?? ""
        
        self.sex = sex
        self.age = age
        self.height = height
        self.weight = weight
        
        super.init()
        
        sync {
            completion()
        }
    }
    
    // MARK: Individual
    init(
        firstName: String,
        lastName: String,
        contact: String,
        key: String? = nil,
        sex: String,
        age: Int,
        height: Int,
        weight: Int,
        completion: @escaping () -> Void
    ) {
        id = ""
        
        self.firstName = firstName
        self.lastName = lastName
        
        email = contact
        
        self.sex = sex
        self.age = age
        self.height = height
        self.weight = weight
        
        super.init()
        
        id = key ?? createUniqueID()
        
        sync {
            completion()
        }
    }
    
    // MARK: Zero
    override init() {
        firstName = ""
        lastName = ""
        email = ""
        sex = ""
        age = 0
        height = 0
        weight = 0
        
        id = ""
        
        super.init()
    }
}

// MARK: Methods
extension User {
    private func createUniqueID() -> String {
        let code = Int.random(in: 10000..<100000)
        let initials = "\(firstName.first!)\(lastName.first!)"
        let date = Date.today()
        return "\(code).\(initials).\(date)"
    }
    
    private func sync(completion: @escaping () -> Void) {
        let mode: CloudKitManager.AccountAction = email == "" ? .login : .signup
        CloudKitManager.account(for: self, action: mode) {
            if mode == .signup {
                RestaurantCategories.create(with: ["sushi", "pizza", "indian", "deli", "café", "brasserie", "asian", "american"])
            }
            QuickAddData.fetch()
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    public static func authorized(account: User? = nil) -> User? {
        if let _account = account {
            _authorized = _account
            UserDefaults.standard.set(_account.bytes(), forKey: key)
        }
        
        return _authorized
    }
    
    public func login(firstName: String?, lastName: String?, email: String?) {
        self.firstName = firstName ?? self.firstName
        self.lastName = lastName ?? self.lastName
        self.email = email ?? self.email
    }
    
    public func login(sex: String?, age: Int, weight: Int, height: Int) {
        self.sex = sex ?? self.sex
        self.age = age
        self.weight = weight
        self.height = height
    }
    
    public static func updateInformation(firstName: String?, lastName: String?, email: String?) {
        _authorized?.login(firstName: firstName, lastName: lastName, email: email)
        CloudKitManager.account(for: authorized(account: _authorized)!, action: .update) {}
    }
    
    public static func updateInformation(sex: String?, age: Int, weight: Int, height: Int) {
        _authorized?.login(sex: sex, age: age, weight: weight, height: height)
        CloudKitManager.account(for: authorized(account: _authorized)!, action: .update) {}
    }
    
    public static func logout() {
        UserDefaults.standard.set(nil, forKey: key)
    }
}

// MARK: Debug Description
extension User {
    override var debugDescription: String {
        return """
        ID: \(id)
        First Name: \(firstName)
        Last Name: \(lastName)
        Email: \(email)
        Sex: \(sex)
        Age: \(age)
        Height: \(height)
        Weight: \(weight)
        """
    }
}

// MARK: NSSecureCoding
extension User: NSSecureCoding {
    static var supportsSecureCoding: Bool {
        get {
            return true
        }
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(firstName, forKey: "firstName")
        coder.encode(lastName, forKey: "lastName")
        coder.encode(email, forKey: "email")
        coder.encode(sex, forKey: "sex")
        coder.encode(age, forKey: "age")
        coder.encode(weight, forKey: "weight")
        coder.encode(height, forKey: "height")
    }
}

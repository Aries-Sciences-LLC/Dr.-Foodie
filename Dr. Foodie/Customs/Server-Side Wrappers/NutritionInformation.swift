//
//  NutritionInformation.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/18/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import Foundation

// MARK: NutritionOutput
public class NutritionOutput: NSObject, NSCoding, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    
    public func encode(with coder: NSCoder) {
        coder.encode(try! NSKeyedArchiver.archivedData(withRootObject: calories!, requiringSecureCoding: true), forKey: "calories")
        coder.encode(try! NSKeyedArchiver.archivedData(withRootObject: totalFat!, requiringSecureCoding: true), forKey: "totalFat")
        coder.encode(try! NSKeyedArchiver.archivedData(withRootObject: saturatedFat!, requiringSecureCoding: true), forKey: "saturatedFat")
        coder.encode(try! NSKeyedArchiver.archivedData(withRootObject: transFat!, requiringSecureCoding: true), forKey: "transFat")
        coder.encode(try! NSKeyedArchiver.archivedData(withRootObject: polysaturatedFat!, requiringSecureCoding: true), forKey: "polysaturatedFat")
        coder.encode(try! NSKeyedArchiver.archivedData(withRootObject: monounsaturatedFat!, requiringSecureCoding: true), forKey: "monounsaturatedFat")
        coder.encode(try! NSKeyedArchiver.archivedData(withRootObject: cholesterol!, requiringSecureCoding: true), forKey: "cholesterol")
        coder.encode(try! NSKeyedArchiver.archivedData(withRootObject: sodium!, requiringSecureCoding: true), forKey: "sodium")
        coder.encode(try! NSKeyedArchiver.archivedData(withRootObject: potassium!, requiringSecureCoding: true), forKey: "potassium")
        coder.encode(try! NSKeyedArchiver.archivedData(withRootObject: totalCarbohydrates!, requiringSecureCoding: true), forKey: "totalCarbohydrates")
        coder.encode(try! NSKeyedArchiver.archivedData(withRootObject: dietaryFiber!, requiringSecureCoding: true), forKey: "dietaryFiber")
        coder.encode(try! NSKeyedArchiver.archivedData(withRootObject: sugars!, requiringSecureCoding: true), forKey: "sugars")
        coder.encode(try! NSKeyedArchiver.archivedData(withRootObject: protein!, requiringSecureCoding: true), forKey: "protein")
        coder.encode(try! NSKeyedArchiver.archivedData(withRootObject: vitaminA!, requiringSecureCoding: true), forKey: "vitaminA")
        coder.encode(try! NSKeyedArchiver.archivedData(withRootObject: vitaminC!, requiringSecureCoding: true), forKey: "vitaminC")
        coder.encode(try! NSKeyedArchiver.archivedData(withRootObject: calcium!, requiringSecureCoding: true), forKey: "calcium")
        coder.encode(try! NSKeyedArchiver.archivedData(withRootObject: iron!, requiringSecureCoding: true), forKey: "iron")
    }
    
    public required init?(coder: NSCoder) {
        calories = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Item.self, from: coder.decodeObject(forKey: "calories") as! Data)
        calories = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Item.self, from: coder.decodeObject(forKey: "calories") as! Data)
        totalFat = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Item.self, from: coder.decodeObject(forKey: "totalFat") as! Data)
        saturatedFat = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Item.self, from: coder.decodeObject(forKey: "saturatedFat") as! Data)
        transFat = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Item.self, from: coder.decodeObject(forKey: "transFat") as! Data)
        polysaturatedFat = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Item.self, from: coder.decodeObject(forKey: "polysaturatedFat") as! Data)
        monounsaturatedFat = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Item.self, from: coder.decodeObject(forKey: "monounsaturatedFat") as! Data)
        cholesterol = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Item.self, from: coder.decodeObject(forKey: "cholesterol") as! Data)
        sodium = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Item.self, from: coder.decodeObject(forKey: "sodium") as! Data)
        potassium = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Item.self, from: coder.decodeObject(forKey: "potassium") as! Data)
        totalCarbohydrates = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Item.self, from: coder.decodeObject(forKey: "totalCarbohydrates") as! Data)
        dietaryFiber = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Item.self, from: coder.decodeObject(forKey: "dietaryFiber") as! Data)
        sugars = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Item.self, from: coder.decodeObject(forKey: "sugars") as! Data)
        protein = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Item.self, from: coder.decodeObject(forKey: "protein") as! Data)
        vitaminA = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Item.self, from: coder.decodeObject(forKey: "vitaminA") as! Data)
        vitaminC = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Item.self, from: coder.decodeObject(forKey: "vitaminC") as! Data)
        calcium = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Item.self, from: coder.decodeObject(forKey: "calcium") as! Data)
        iron = try! NSKeyedUnarchiver.unarchivedObject(ofClass: Item.self, from: coder.decodeObject(forKey: "iron") as! Data)
    }
    
    public override init() {
        super.init()
    }
    
    var calories: Item?
    var totalFat: Item?
    var saturatedFat: Item?
    var transFat: Item?
    var polysaturatedFat: Item?
    var monounsaturatedFat: Item?
    var cholesterol: Item?
    var sodium: Item?
    var potassium: Item?
    var totalCarbohydrates: Item?
    var dietaryFiber: Item?
    var sugars: Item?
    var protein: Item?
    var calcium: Item?
    var iron: Item?
    var alcohol: Item?
    var caffeine: Item?
    var copper: Item?
    var cysteine: Item?
    var energy: Item?
    var lactose: Item?
    var magnesium: Item?
    var phosphorus: Item?
    var starch: Item?
    var valine: Item?
    var zinc: Item?
    var vitaminA: Item?
    var vitaminB: Item?
    var vitaminC: Item?
    var vitaminD: Item?
    var vitaminE: Item?
    var vitaminK: Item?
    
    public var amount: Int {
        get {
            return 17
        }
    }
    
    public var dictionary: [[String: Any]] {
        get {
            return [
                [
                    "name": "Calories",
                    "value": calories?.rawValue,
                ],
                [
                    "name": "Calcium",
                    "value": calcium?.rawValue,
                ],
                [
                    "name": "Total Fat",
                    "value": totalFat?.rawValue,
                ],
                [
                    "name": "Iron",
                    "value": iron?.rawValue,
                ],
                [
                    "name": "Fiber",
                    "value": dietaryFiber?.rawValue,
                ],
                [
                    "name": "Potassium",
                    "value": potassium?.rawValue,
                ],
                [
                    "name": "Sodium",
                    "value": sodium?.rawValue,
                ],
                [
                    "name": "Protein",
                    "value": protein?.rawValue,
                ],
                [
                    "name": "Sugars",
                    "value": sugars?.rawValue,
                ],
                [
                    "name": "Vitamin A",
                    "value": vitaminA?.rawValue,
                ],
                [
                    "name": "Vitamin B",
                    "value": vitaminB?.rawValue,
                ],
                [
                    "name": "Vitamin C",
                    "value": vitaminC?.rawValue,
                ],
                [
                    "name": "Vitamin D",
                    "value": vitaminD?.rawValue,
                ],
                [
                    "name": "Vitamin E",
                    "value": vitaminE?.rawValue,
                ],
                [
                    "name": "Vitamin K",
                    "value": vitaminK?.rawValue,
                ],
                [
                    "name": "Alcohol",
                    "value": alcohol?.rawValue,
                ],
                [
                    "name": "Caffeine",
                    "value": caffeine?.rawValue,
                ],
                [
                    "name": "Copper",
                    "value": copper?.rawValue,
                ],
                [
                    "name": "Cysteine",
                    "value": cysteine?.rawValue,
                ],
                [
                    "name": "Energy",
                    "value": energy?.rawValue,
                ],
                [
                    "name": "Lactose",
                    "value": lactose?.rawValue,
                ],
                [
                    "name": "Magnesium",
                    "value": magnesium?.rawValue,
                ],
                [
                    "name": "Phosphorus",
                    "value": phosphorus?.rawValue,
                ],
                [
                    "name": "Starch",
                    "value": starch?.rawValue,
                ],
                [
                    "name": "Valine",
                    "value": valine?.rawValue,
                ],
                [
                    "name": "Zinc",
                    "value": zinc?.rawValue,
                ],
            ]
        }
    }
}

// MARK: Item
public class Item: NSObject, NSCoding, NSSecureCoding {
    public static var supportsSecureCoding: Bool = true
    
    public func encode(with coder: NSCoder) {
        coder.encode(_value, forKey: "value")
        coder.encode(_percent, forKey: "percent")
    }
    
    public required init?(coder: NSCoder) {
        _value = coder.decodeDouble(forKey: "value")
        _percent = coder.decodeDouble(forKey: "percent")
    }
    
    private var _value: Double
    private var _percent: Double
    
    var value: String? {
        get {
            return "\(_value)g"
        }
    }
    var percent: String? {
        get {
            return "\(_percent)%"
        }
    }
    
    var rawValue: Double {
        get {
            return _value
        }
    }
    
    public init(amount: Double, requirement: Double = 0) {
        _value = amount.roundToDecimal(2)
        _percent = requirement > 0 ? (((_value / requirement)) * 100).roundToDecimal(2) : 0
    }
    
    public func update(by amount: Double? = nil, requirement: Double? = nil) {
        _value += amount?.roundToDecimal(2) ?? _value
        _percent = (requirement ?? _percent) > 0 ? (((_value / (requirement ?? _percent))) * 100).roundToDecimal(2) : 0
    }
}

class NutritionInformation {
    
    // MARK: NutritionInput
    public struct NutritionInput {
        let endpoint = "https://trackapi.nutritionix.com/v2/natural/nutrients"
        let headers = Headers()
        var body: Body
        
        // MARK: Headers
        public struct Headers {
            let authentification = Bundle.main.object(forInfoDictionaryKey: "Nutritionix") as! Dictionary<String, String>
            let contentType = "application/json"
            let titles = ["Content-Type", "x-app-key", "x-app-id"]
            
            public func package() -> Dictionary<String, String> {
                return [
                    "Content-Type": contentType,
                    "x-app-key": authentification["API Key"]!,
                    "x-app-id": authentification["App ID"]!
                ]
            }
        }

        // MARK: Body
        public struct Body {
            var query: String
            
            public func package() -> Dictionary<String, String> {
                return [
                    "query": query,
                    "timezone": TimeZone.current.identifier
                ]
            }
        }
    }
}

// MARK: Methods
extension NutritionInformation {
    public static func getNutrition(for foods: NutritionInput, completion: @escaping (NutritionOutput) -> Void) {
        //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid

        let parameters = foods.body.package()

        //create the url with URL
        let url = URL(string: foods.endpoint)! //change the url

        //create the session object
        let session = URLSession.shared

        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        foods.headers.titles.forEach { (header) in
            request.addValue(foods.headers.package()[header]!, forHTTPHeaderField: header)
        }

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    let parsed = (json["foods"] as! [Dictionary<String, Any>])[0]
                    let output = NutritionOutput()
                    output.calories = .init(amount: parsed["nf_calories"] as! Double)
                    (parsed["full_nutrients"] as! [Dictionary<String, Double>]).forEach { (data) in
                        switch data["attr_id"] {
                        case 301:
                            output.calcium = .init(amount: data["value"]!, requirement: 1300)
                        case 205:
                            output.totalCarbohydrates = .init(amount: data["value"]!, requirement: 275)
                        case 601:
                            output.cholesterol = .init(amount: data["value"]!, requirement: 300)
                        case 606:
                            output.saturatedFat = .init(amount: data["value"]!, requirement: 20)
                        case 204:
                            output.totalFat = .init(amount: data["value"]!, requirement: 70)
                        case 605:
                            output.transFat = .init(amount: data["value"]!)
                        case 303:
                            output.iron = .init(amount: data["value"]!, requirement: 18)
                        case 291:
                            output.dietaryFiber = .init(amount: data["value"]!, requirement: 28)
                        case 306:
                            output.potassium = .init(amount: data["value"]!, requirement: 4700)
                        case 307:
                            output.sodium = .init(amount: data["value"]!, requirement: 2300)
                        case 203:
                            output.protein = .init(amount: data["value"]!, requirement: 50)
                        case 269:
                            output.sugars = .init(amount: data["value"]!, requirement: 50)
                        case 645:
                            output.monounsaturatedFat = .init(amount: data["value"]!)
                        case 646:
                            output.polysaturatedFat = .init(amount: data["value"]!)
                        case 318:
                            output.vitaminA = .init(amount: data["value"]!, requirement: 800)
                        case 578, 418, 415:
                            if output.vitaminB == nil {
                                output.vitaminB = .init(amount: data["value"]!, requirement: 82.5)
                            } else {
                                output.vitaminB?.update(by: data["value"])
                            }
                        case 401:
                            output.vitaminC = .init(amount: data["value"]!, requirement: 82.5)
                        case 324:
                            output.vitaminD = .init(amount: data["value"]!, requirement: 82.5)
                        case 573, 323:
                            if output.vitaminE == nil {
                                output.vitaminE = .init(amount: data["value"]!, requirement: 82.5)
                            } else {
                                output.vitaminE?.update(by: data["value"])
                            }
                        case 430:
                            output.vitaminK = .init(amount: data["value"]!, requirement: 82.5)
                        case 221:
                            output.alcohol = .init(amount: data["value"]!)
                        case 262:
                            output.caffeine = .init(amount: data["value"]!)
                        case 312:
                            output.copper = .init(amount: data["value"]!)
                        case 507:
                            output.cysteine = .init(amount: data["value"]!)
                        case 268:
                            output.energy = .init(amount: data["value"]!)
                        case 213:
                            output.lactose = .init(amount: data["value"]!)
                        case 304:
                            output.magnesium = .init(amount: data["value"]!)
                        case 305:
                            output.phosphorus = .init(amount: data["value"]!)
                        case 209:
                            output.starch = .init(amount: data["value"]!)
                        case 510:
                            output.valine = .init(amount: data["value"]!)
                        case 309:
                            output.zinc = .init(amount: data["value"]!)
                        default:
                            break
                        }
                    }
                    
                    completion(output)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
}

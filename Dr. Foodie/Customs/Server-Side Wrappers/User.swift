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
        guard let id = coder.decodeObject(forKey: "id") as? String,
            let firstName = coder.decodeObject(forKey: "firstName") as? String,
            let lastName = coder.decodeObject(forKey: "lastName") as? String,
            let email = coder.decodeObject(forKey: "email") as? String else {
                return nil
        }
        
        self.init(firstName: firstName, lastName: lastName, contact: email, key: id) {
            
        }
    }

    // MARK: Constructors & Properties
    static let key = "SignedAccount"
    static private var _authorized: User?
    
    private(set) var id: String
    private(set) var firstName: String
    private(set) var lastName: String
    private(set) var email: String
    
    // MARK: Apple
    init(credentials: ASAuthorizationAppleIDCredential, completion: @escaping () -> Void) {
        id = credentials.user
        
        firstName = credentials.fullName?.givenName ?? ""
        lastName = credentials.fullName?.familyName ?? ""
        email = credentials.email ?? ""
        
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
        completion: @escaping () -> Void
    ) {
        id = ""
        
        self.firstName = firstName
        self.lastName = lastName
        
        email = contact
        
        super.init()
        
        id = key ?? createUniqueID()
        
        if key == nil {
             sync {
                 completion()
             }
        }
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
        CloudKitManager.account(for: self, action: email == "" ? .login : .signup) {
            RestaurantCategories.create(with: ["sushi", "pizza", "indian", "deli", "café", "brasserie", "asian", "american"])
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
    
    public func login(firstName: String, lastName: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    
    public static func updateInformation(firstName: String, lastName: String, email: String) {
        _authorized?.login(firstName: firstName, lastName: lastName, email: email)
        CloudKitManager.account(for: authorized(account: _authorized)!, action: .update) {
            
        }
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
        """
    }
}

// MARK:
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
    }
}

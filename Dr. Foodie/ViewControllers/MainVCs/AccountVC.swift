//
//  AccountVC.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/12/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit
import LocalAuthentication

// MARK: Properties, IBOutlets, & IBActions
class AccountVC: BaseVC {
    
    let reachability = ReachabilityHandler()

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var edit: UIButton!
    
    @IBAction func signOut(_ sender: Any) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Please confirm to logout.") { success, authenticationError in
                if let error = authenticationError {
                    print(error.localizedDescription)
                }
                
                DispatchQueue.main.async {
                    if success {
                        User.logout()
                        self.performSegue(withIdentifier: "returnToEntrance", sender: self)
                    }
                }
            }
        } else {
            User.logout()
        }
    }
}

// MARK: Methods
extension AccountVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: SignUpAreaVC.self) {
            (segue.destination as! SignUpAreaVC).delegate = self
            (segue.destination as! SignUpAreaVC).style = .update
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fillValues()
        
        reachability.handler = {
            self.edit.isEnabled = $0
        }
    }
    
    private func fillValues() {
        if let user = User.authorized() {
            UIView.animate(withDuration: 0.3, animations: {
                self.username.alpha = 0
                self.email.alpha = 0
            }) { _ in
                self.username.text = "\(user.firstName) \(user.lastName)"
                self.email.text = user.email
                UIView.animate(withDuration: 0.3) {
                    self.username.alpha = 1
                    self.email.alpha = 1
                }
            }
        }
    }
}

// MARK:
extension AccountVC: SignUpAreaVCDelegate {
    func submittedInformation(firstName: String?, lastName: String?, email: String?, sex: String?, age: Int, weight: Int, height: Int) {
        User.updateInformation(firstName: firstName == "" ? nil : firstName, lastName: lastName == "" ? nil : lastName, email: email == "" ? nil : email)
        User.updateInformation(sex: sex == "" ? nil : sex, age: age, weight: weight, height: height)
        fillValues()
    }
}

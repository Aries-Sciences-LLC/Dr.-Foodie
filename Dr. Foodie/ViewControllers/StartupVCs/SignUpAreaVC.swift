//
//  SignUpAreaVC.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/10/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit
import TextFieldEffects

// MARK: SignUpAreaDelegate
protocol SignUpAreaVCDelegate {
    func submittedInformation(firstName: String, lastName: String, email: String)
}

// MARK: IBOutlets, Properties, Entrance Methods, & IBActions
class SignUpAreaVC: UIViewController {

    @IBOutlet weak var goBack: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var firstName: YoshikoTextField!
    @IBOutlet weak var lastName: YoshikoTextField!
    @IBOutlet weak var email: YoshikoTextField!
    @IBOutlet weak var finished: UIButton!
    
    public var delegate: SignUpAreaVCDelegate?
    public var style: Style?
    
    enum Style {
        case signup, update
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        firstName.placeholder = "First Name"
        lastName.placeholder = "Last Name"
        email.placeholder = "Email"
    }
    
    @IBAction func userCancelled(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func firstNameHandle(_ sender: Any) {
        updateInformation()
    }
    
    @IBAction func lastNameHandle(_ sender: Any) {
        updateInformation()
    }
    
    @IBAction func emailHandle(_ sender: Any) {
        updateInformation()
    }
    
    @IBAction func userSubmitted(_ sender: Any) {
        dismiss(animated: true, completion: {
            if let handler = self.delegate {
                handler.submittedInformation(
                    firstName: self.firstName.text!,
                    lastName: self.lastName.text!,
                    email: self.email.text!
                )
            }
        })
    }
}

// MARK: Methods
extension SignUpAreaVC {
    private func updateInformation() {
        switch style {
        case .update:
            finished.isEnabled = true
        case .signup:
            finished.isEnabled = firstName.text != "" && lastName.text != "" && email.isEmail()
        case .none:
            break
        }
    }
}

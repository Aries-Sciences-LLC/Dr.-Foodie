//
//  SignUpAreaVC.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/10/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: SignUpAreaVCDelegate
protocol SignUpAreaVCDelegate {
    func submittedInformation(firstName: String?, lastName: String?, email: String?, sex: String?, age: Int, weight: Int, height: Int)
}

// MARK: IBOutlets, Properties, & IBActions
class SignUpAreaVC: DRFVC {

    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var goBack: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var finished: UIButton!
    
    public var delegate: SignUpAreaVCDelegate?
    public var style: Style?
    
    enum Style {
        case signup, update
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
}

// MARK: Methods
extension SignUpAreaVC {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        switch style {
        case .signup:
            heading.text = "Sign Up"
        case .update:
            heading.text = "Edit Account"
        case .none:
            break
        }
    }
    
    private func updateInformation() {
        switch style {
        case .update:
            finished.isEnabled = true
        case .signup:
            finished.isEnabled = firstName.text != "" && (email.isEmail() || email.text == "") // && lastName.text != "" && email.isEmail()
        case .none:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: UserBodySelectionVC.self) {
            (segue.destination as! UserBodySelectionVC).style = style
            (segue.destination as! UserBodySelectionVC).delegate = self
        }
    }
}

// MARK: UserBodySelectionVC
extension SignUpAreaVC: UserBodySelectionVCDelegate {
    func submittedInformation(sex: String, age: Int, weight: Int, height: Int) {
        if let handler = self.delegate {
            handler.submittedInformation(
                firstName: self.firstName.text,
                lastName: self.lastName.text,
                email: self.email.text,
                sex: sex,
                age: age,
                weight: weight,
                height: height
            )
        }
        userCancelled(goBack as Any)
    }
}

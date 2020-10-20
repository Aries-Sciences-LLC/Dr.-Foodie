//
//  LoginVC.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/9/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit
import AuthenticationServices

// MARK: Properties, IBOutlets, Override Methods, & IBActions
class LoginVC: UIViewController {
    
    public var cancelHandler: (() -> Void)?

    @IBOutlet weak var authentificationSection: AuthorizationButtons!
    
    @IBAction func hide(_ sender: Any) {
        dismiss(animated: true, completion: {
            self.cancelHandler?()
        })
    }
}

// MARK: Methods
extension LoginVC {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pop()
        
        authentificationSection.authorizationDelegate = self
        authentificationSection.authorizationPresentationContext = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: SignUpAreaVC.self) {
            (segue.destination as! SignUpAreaVC).delegate = self
        }
    }
    
    func success() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "LoginSuccessful", sender: self)
        }
    }
}

// MARK: ASAuthorizationControllerDelegate
extension LoginVC: AuthorizationButtonsDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            _ = User(credentials: credentials) {
                self.success()
            }
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
    
    func userSkippedLogIn() {
        performSegue(withIdentifier: "AlternativeSignup", sender: self)
    }
}

// MARK: ASAuthorizationControllerPresentationContextProviding
extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}

// MARK: SignUpAreaDelegate
extension LoginVC: SignUpAreaVCDelegate {
    func submittedInformation(firstName: String, lastName: String, email: String) {
        _ = User(firstName: firstName, lastName: firstName, contact: email) {
            self.success()
        }
    }
}

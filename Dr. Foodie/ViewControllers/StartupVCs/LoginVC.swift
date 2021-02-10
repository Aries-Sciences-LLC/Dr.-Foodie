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
class LoginVC: DRFVC {
    
    public var cancelHandler: (() -> Void)?
    private var createdCredentials: ASAuthorizationAppleIDCredential?

    @IBOutlet weak var working: UIActivityIndicatorView!
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
            (segue.destination as! SignUpAreaVC).style = .signup
        } else if segue.destination.isKind(of: UserBodySelectionVC.self) {
            (segue.destination as! UserBodySelectionVC).delegate = self
            (segue.destination as! UserBodySelectionVC).style = .signup
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.working.alpha = 1
        }) { _ in
            self.working.startAnimating()
        }
    }
    
    func success() {
        DispatchQueue.main.async {
            self.working.stopAnimating()
            
            self.performSegue(withIdentifier: "LoginSuccessful", sender: self)
        }
    }
    
    func userSkippedLogIn() {
        performSegue(withIdentifier: "AlternativeSignup", sender: self)
    }
}

// MARK: ASAuthorizationControllerDelegate
extension LoginVC: AuthorizationButtonsDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            createdCredentials = credentials
            performSegue(withIdentifier: "bodySelectionShortcut", sender: self)
        default:
            fallback()
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
        fallback()
    }
    
    func fallback() {
        UIAlertController.create(parent: self, title: "Hmm...", message: "Looks like there was a problem with your sign in. Please use the \"local\" option. Or try again later.")
        working.stopAnimating()
    }
}

// MARK: ASAuthorizationControllerPresentationContextProviding
extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}

// MARK: SignUpAreaVCDelegate
extension LoginVC: SignUpAreaVCDelegate {
    func submittedInformation(firstName: String?, lastName: String?, email: String?, sex: String?, age: Int, weight: Int, height: Int) {
        _ = User(firstName: firstName!, lastName: lastName!, contact: email!, sex: sex!, age: age, height: height, weight: weight) {
            self.success()
        }
    }
}

// MARK: LoginVC: UserBodySelectionVCDelegate
extension LoginVC: UserBodySelectionVCDelegate {
    func submittedInformation(sex: String, age: Int, weight: Int, height: Int) {
        _ = User(credentials: createdCredentials!, sex: sex, age: age, weight: weight, height: height) {
            self.success()
        }
    }
}

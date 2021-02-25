//
//  AppleIDAuthorizationButton.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/4/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit
import SnapKit
import AuthenticationServices

// MARK: ASAuthorizationControllerDelegate
protocol AuthorizationButtonsDelegate: ASAuthorizationControllerDelegate {
    func userSkippedLogIn()
}

// MARK: Properties
class AuthorizationButtons: UIStackView {
    var authorizationDelegate: AuthorizationButtonsDelegate?
    var authorizationPresentationContext: ASAuthorizationControllerPresentationContextProviding?
    
    let reachability = ReachabilityHandler()
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        axis = .vertical
        alignment = .fill
        distribution = .fill
        spacing = 8
        
        var signWithApple: ASAuthorizationAppleIDButton
        if #available(iOS 13.2, *) {
            signWithApple = ASAuthorizationAppleIDButton(type: .signUp, style: traitCollection.userInterfaceStyle == .dark ? .white : .black)
        } else {
            signWithApple = ASAuthorizationAppleIDButton(type: .signIn, style: traitCollection.userInterfaceStyle == .dark ? .white : .black)
        }
        signWithApple.addTarget(self, action: #selector(sendRequest(_:)), for: .touchUpInside)
        addArrangedSubview(signWithApple)
        signWithApple.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        
        let dontSignIn = UIButton()
        dontSignIn.setTitle("Stay Local", for: .normal)
        dontSignIn.titleLabel?.textAlignment = .center
        dontSignIn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        dontSignIn.setTitleColor(UIColor(named: "LabelColor"), for: .normal)
        dontSignIn.alpha = 0.9
        dontSignIn.addTarget(self, action: #selector(userSelectedLocalDataStorage(_:)), for: .touchUpInside)
        addArrangedSubview(dontSignIn)
        dontSignIn.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.width.equalToSuperview()
        }
        
        reachability.handler = {
            signWithApple.isEnabled = $0
            dontSignIn.isEnabled = $0
        }
    }
}

// MARK: Methods
extension AuthorizationButtons {
    @objc func sendRequest(_ sender: UIButton!) {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.email, .fullName]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        if let delegate = authorizationDelegate, let presentationContext = authorizationPresentationContext {
            controller.delegate = delegate
            controller.presentationContextProvider = presentationContext
        }
        
        controller.performRequests()
    }
    
    @objc func userSelectedLocalDataStorage(_ sender: UIButton!) {
        if let delegate = authorizationDelegate {
            delegate.userSkippedLogIn()
        }
    }
}

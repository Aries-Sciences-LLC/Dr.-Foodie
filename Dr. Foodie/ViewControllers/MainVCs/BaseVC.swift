//
//  BaseVC.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 12/7/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

class BaseVC: DRFVC {
    
    private let container: UIButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UIApplication.shared.isFirstLaunch() {
            container.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            container.alpha = 0
            container.addTarget(self, action: #selector(dismissMessage(_:)), for: .touchUpInside)
            view.addSubview(container)
            
            let message = UILabel()
            message.text = "Scroll up to switch menus."
            message.textColor = .lightGray
            message.font = UIFont(name: "Futura-Bold", size: 25)
            message.textAlignment = .center
            message.center = view.center
            container.addSubview(message)
            
            UIView.animate(withDuration: 0.3) {
                self.container.alpha = 1
            }
        }
    }
    
    @objc func dismissMessage(_ sender: UIButton!) {
        UIView.animate(withDuration: 0.3, animations: {
            self.container.alpha = 0
        }) { _ in
            self.container.removeFromSuperview()
        }
    }
}

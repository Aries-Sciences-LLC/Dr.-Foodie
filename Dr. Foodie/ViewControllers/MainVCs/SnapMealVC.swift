//
//  SnapMealVC.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 9/22/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

protocol SnapMealVCDelegate {
    func created(categories: FoodRecognition.Response, for image: UIImage)
}

// MARK: IBOutlets, Properties, & IBActions
class SnapMealVC: BaseVC {
    @IBOutlet weak var titleContainer: UIVisualEffectView!
    @IBOutlet weak var cameraView: CameraView!
    @IBOutlet weak var activityIndicator: UIView!
    
    private let service = FoodRecognition()
    private let reachability = ReachabilityHandler()
    
    private var delegate: SnapMealVCDelegate?
}

// MARK: Methods
extension SnapMealVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleContainer.layer.borderColor = UIColor.white.cgColor
        
        reachability.handler = { [self] in
            cameraView.captureBtn.isEnabled = $0
            switch $0 {
            case true:
                cameraView.captureBtn.setImage(UIImage(systemName: "camera.fill"), for: .normal)
            default:
                cameraView.captureBtn.setImage(UIImage(systemName: "wifi.slash"), for: .normal)
            }
        }
        
        cameraView.captureBtn.layer.borderColor = UIColor.label.cgColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: CategorySelectionVC.self) {
            (segue.destination as! CategorySelectionVC).parentVC = self
            delegate = (segue.destination as! CategorySelectionVC)
        }
    }
    
    public func autoSelected(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3, animations: {
            self.activityIndicator.alpha = 1
        }) { _ in
            completion()
        }
    }
}

// MARK: CameraViewDelegate
extension SnapMealVC: CameraViewDelegate {
    func photoWasTaken(photo: UIImage) {
        autoSelected {
            self.cameraView.captureBtn.isEnabled = false
            self.service.recognize(for: photo) { (response) in
                self.performSegue(withIdentifier: "presentCategories", sender: self)
                self.cameraView.captureBtn.isEnabled = true
                self.delegate?.created(categories: response, for: photo)
                UIView.animate(withDuration: 0.3) {
                    self.activityIndicator.alpha = 0
                }
            }
        }
    }
}

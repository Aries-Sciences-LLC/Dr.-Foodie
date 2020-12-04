//
//  UserBodySelectionVC.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 11/30/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: UserBodySelectionVC
protocol UserBodySelectionVCDelegate {
    func submittedInformation(sex: String, age: Int, weight: Int, height: Int)
}

// MARK: IBOutlets, Properties, & IBActions
class UserBodySelectionVC: UIViewController {
    
    @IBOutlet weak var goBack: UIButton!
    @IBOutlet weak var sex: UIPickerView!
    @IBOutlet weak var height: UIPickerView!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var finished: UIButton!
    
    @IBOutlet weak var topY: NSLayoutConstraint!
    
    var delegate: UserBodySelectionVCDelegate?
    var style: SignUpAreaVC.Style?
    
    private let sexOptions = ["Male", "Female", "Prefer not to say"]
    
    @IBAction func userCancelled(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func userFinished(_ sender: Any) {
        dismiss(animated: true) {
            if let handler = self.delegate {
                let selectedSex = self.sex.selectedRow(inComponent: 0)
                let selectedHeight = self.height.selectedRow(inComponent: 0)
                handler.submittedInformation(
                    sex: self.sexOptions[selectedSex],
                    age: Int(self.age.text!)!,
                    weight: Int(self.weight.text!)!,
                    height: selectedHeight + 24)
            }
        }
    }
    
    @IBAction func userInputtedWeight(_ sender: Any) {
        updateState()
    }
    
    @IBAction func userInputtedAge(_ sender: Any) {
        updateState()
    }
}

// MARK: Methods
extension UserBodySelectionVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        weight.resignFirstResponder()
        age.resignFirstResponder()
    }
    
    func updateState() {
        switch style {
        case .update:
            finished.isEnabled = true
        case .signup:
            finished.isEnabled = weight.text != "" && age.text != ""
        case .none:
            break
        }
    }
    
    func updateView() {
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: UIPickerViewDelegate
extension UserBodySelectionVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView {
        case sex:
            return sexOptions[row]
        case height:
            return "\(Int((row + 24) / 12))'\((row + 24) % 12)\""
        default:
            return ""
        }
    }
}

// MARK: UIPickerViewDataSource
extension UserBodySelectionVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView {
        case sex:
            return 3
        case height:
            return 6 * 12
        default:
            return 0
        }
    }
}

// MARK: UITextFieldDelegate
extension UserBodySelectionVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        topY.constant = -325
        updateView()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        topY.constant = 20
        updateView()
    }
}

//
//  ThirdPartyMapSelector.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 11/24/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

// MARK: ThirdPartyMapsSelectorDelegate
protocol ThirdPartyMapsSelectorVCDelegate {
    func selectedAnnotation() -> MKMapItem
}

// MARK: IBOutlets & Properties
class ThirdPartyMapSelectorVC: DRFVC {
    @IBOutlet weak var googleMaps: UIButton!
    @IBOutlet weak var appleMaps: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    var dismiss: (() -> Void)?
    var delegate: ThirdPartyMapsSelectorVCDelegate?
}

// MARK: Methods
extension ThirdPartyMapSelectorVC {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        pop()
    }
}

// MARK: IBActions
extension ThirdPartyMapSelectorVC {
    @IBAction func userSelectedAppleMaps(_ sender: UIButton!) {
        (delegate?.selectedAnnotation())?.openInMaps(launchOptions: nil)
        
        userCancelled(cancel)
    }
    
    @IBAction func userSelectedGoogleMaps(_ sender: UIButton!) {
        let location = (delegate?.selectedAnnotation().name)!
        let query = location.replacingOccurrences(of: " ", with: "+")
        
        UIApplication.shared.open(URL(string:"https://www.google.com/maps/search/?api=1&query=\(query)")!, options: [:], completionHandler: nil)
        
        userCancelled(cancel)
    }
    
    @IBAction func userCancelled(_ sender: UIButton!) {
        dismiss(animated: true, completion: {
            self.dismiss?()
        })
    }
}

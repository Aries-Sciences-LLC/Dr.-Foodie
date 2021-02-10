//
//  RestaurantMapVC.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 9/21/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit
import MapKit
import GooglePlaces

// MARK: IBOutlets
class RestaurantMapVC: BaseVC {

    @IBOutlet weak var categories: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    
    private var editingMode = false
    private let locationManager = CLLocationManager()

    private var placesClient: GMSPlacesClient!
    
    private var locations: [MKMapItem]?
    private var selectedLocation: Int?
}

// MARK: Methods
extension RestaurantMapVC {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        placesClient = GMSPlacesClient.shared()
        
        CloudKitManager.categories(action: .fetch) { (names) in
            DispatchQueue.main.async {
                self.categories.reloadData()
            }
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        // Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }

        DispatchQueue.main.async {
            self.locationManager.startUpdatingLocation()
        }
        
        categories.superview?.superview?.layer.borderColor = UIColor.white.cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        mapView.isScrollEnabled = true

        if (CLLocationManager.locationServicesEnabled()) {
            if let userLocation = locationManager.location?.coordinate {
                addPlaces(near: userLocation)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        mapView.isScrollEnabled = false
    }
}

// MARK: UICollectionViewDataSource
extension RestaurantMapVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RestaurantCategories.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categories.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as! RestaurantCategoryCell
        cell.delegate = self
        cell.category.text = RestaurantCategories.categories[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = categories.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "edit", for: indexPath) as! EditCell
        cell.delegate = self
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension RestaurantMapVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let test = UILabel()
        test.font = UIFont(name: "Futura-Bold", size: 16)
        test.text = RestaurantCategories.categories[indexPath.item]
        return CGSize(width: 90 + test.intrinsicContentSize.width, height: 45)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        switch editingMode {
        case true:
            return CGSize(width: collectionView.bounds.width - 30, height: 45)
        case false:
            return CGSize(width: 45, height: 45)
        }
    }
}

// MARK: RestaurantCategoryCellDelegate
extension RestaurantMapVC: RestaurantCategoryCellDelegate {
    func categoryWasDeleted(with title: String) {
        RestaurantCategories.remove(name: title)
        categories.reloadData()
    }
}

// MARK: EditCellDelegate
extension RestaurantMapVC: EditCellDelegate {
    func displayEditor() {
        textFieldHandler()
        categories.setContentOffset(CGPoint(x: categories.contentSize.width, y: 0), animated: true)
    }
    
    func finishedEditing() {
        textFieldHandler()
        categories.reloadData()
    }
    
    func textFieldHandler() {
        categories.performBatchUpdates({
            editingMode = !editingMode
            UIView.animate(withDuration: 0.3) {
                self.categories.collectionViewLayout.invalidateLayout()
            }
        }, completion: nil)
    }
}

// MARK: MKMapViewDelegate
extension RestaurantMapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        var counter = 0
        for location in locations! {
            if location.placemark.coordinate.equals(view.annotation!.coordinate) {
                selectedLocation = counter
                break
            }
            counter += 1
        }
        performSegue(withIdentifier: "selectResource", sender: parent)
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        mapView.removeAnnotations(mapView.annotations)
        if let userLocation = locationManager.location?.coordinate {
            addPlaces(near: userLocation)
        }
    }
}

// MARK: Methods
extension RestaurantMapVC {
    func addPlaces(near location: CLLocationCoordinate2D) {
        let viewRegion = MKCoordinateRegion(center: location, latitudinalMeters: 400, longitudinalMeters: 400)
        mapView.setRegion(viewRegion, animated: true)
        
        searchBy(naturalLanguageQuery: "restaurants", region: viewRegion, coordinates: location) { (response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.locations = response?.mapItems
                self.selectedLocation = 0
                response?.mapItems.forEach({ (mapItem) in
                    self.mapView.addAnnotation(mapItem.placemark)
                })
            }
        }
    }
    
    func searchBy(naturalLanguageQuery: String, region: MKCoordinateRegion, coordinates: CLLocationCoordinate2D, completionHandler: @escaping (_ response: MKLocalSearch.Response?, _ error: Error?) -> Void) {

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = naturalLanguageQuery
        request.region = region

        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                completionHandler(nil, error)

                return
            }

            completionHandler(response, error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! UINavigationController
        if let controller = (destination.topViewController as? ThirdPartyMapSelectorVC) {
            controller.delegate = self
            controller.dismiss = {
                self.mapView.deselectAnnotation(self.mapView.selectedAnnotations.first!, animated: true)
            }
        }
    }
}

// MARK: ThirdPartyMapsSelectorDelegate
extension RestaurantMapVC: ThirdPartyMapsSelectorVCDelegate {
    func selectedAnnotation() -> MKMapItem {
        return locations![selectedLocation!]
    }
}

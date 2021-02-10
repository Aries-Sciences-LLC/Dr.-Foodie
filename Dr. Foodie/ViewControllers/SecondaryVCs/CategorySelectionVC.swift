//
//  CategorySelectionVC.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/17/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: Properties, IBOutlets, & IBActions
class CategorySelectionVC: DRFVC {
    
    private var categories: FoodRecognition.Response?
    private var cells: [CategoryCell] = []
    private var image: UIImage?
    private var delegate: NutritionOverviewVCDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var finishedBtn: UIButton!
    
    public var parentVC: SnapMealVC?
    
    @IBAction func userFinished(_ sender: UIButton!) {
        if let delegate = delegate {
            var selected: [String] = []
            for cell in cells {
                if cell.enabled {
                    selected.append(cell.titleLbl.text ?? "")
                }
            }
            delegate.userSelectedCategories!(categories: selected, for: image!)
        }
    }
    
    @IBAction func cancel(_ sender: UIButton!) {
        if parentVC?.parent is ContainerVC {
            (parentVC?.parent as! ContainerVC).goToHome(nil)
        }
        
        dismiss(animated: true) {
            self.parentVC?.cameraView.captureSession.startRunning()
        }
    }
}

// MARK: Methods
extension CategorySelectionVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pop()
        
        finishedBtn.layer.borderColor = UIColor.label.cgColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: NutritionOverviewVC.self) {
            delegate = (segue.destination as! NutritionOverviewVC)
            (segue.destination as! NutritionOverviewVC).parentVC = self
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension CategorySelectionVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let name = categories?.predictions[indexPath.item].name
        let testLBL = UILabel()
        testLBL.text = name
        testLBL.font = UIFont(name: "Futura-Medium", size: 15)
        return CGSize(width: testLBL.intrinsicContentSize.width + 50, height: 45)
    }
}

// MARK: UICollectionViewDataSource
extension CategorySelectionVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.predictions.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "category", for: indexPath) as! CategoryCell
        cell.set(category: categories?.predictions[indexPath.item].name ?? "")
        cell.indexPath = indexPath
        cell.onSwitched = { _ in
        self.finishedBtn.isEnabled = false
            self.cells.forEach { (cell) in
                if cell.enabled {
                    self.finishedBtn.isEnabled = true
                }
            }
        }
        cells.append(cell)
        return cell
    }
}

// MARK: SnapMealVCDelegate
extension CategorySelectionVC: SnapMealVCDelegate {
    func created(categories: FoodRecognition.Response, for image: UIImage) {
        self.image = image
        self.categories = categories
        collectionView.reloadData()
        
        if categories.predictions.first?.name == "No Data" {
            let ac = UIAlertController(title: "Enter Name", message: "Sorry, the AI couldn't come up with anything just yet, why don't you just enter the name of the food that you were eating and we'll know for next time.", preferredStyle: .alert)
            ac.addTextField { (tf) in
                tf.placeholder = "Ex. \"Salmon\", not \"Salmon Tartar\""
            }
            
            let action = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
                self.delegate?.userSelectedCategories?(categories: [ac.textFields![0].text!], for: image)
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .destructive) { _ in
                self.dismiss(animated: true) {
                    self.parentVC?.cameraView.captureSession.startRunning()
                }
            }
            
            ac.addAction(action)
            ac.addAction(cancel)
            present(ac, animated: true)
        }
    }
}

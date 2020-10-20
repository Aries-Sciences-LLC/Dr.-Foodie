//
//  CompleteDayCell.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/19/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: CompleteDayCellDelegate
protocol CompleteDayCellDelegate {
    func onUserClicked(selected nutrition: NutritionOutput)
}

// MARK: IndividualDayCellDelegate
protocol IndividualDayCellDelegate {
    func onUserSelected(for item: Int)
}

// MARK: IBOutlets & Properties
class CompleteDayCell: UITableViewCell {
    
    @IBOutlet weak var titleDate: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private(set) var data: [JournalManager.Food]?
    
    public var delegate: CompleteDayCellDelegate!
}

// MARK: Methods
extension CompleteDayCell {
    public func set(data: [JournalManager.Food]) {
        self.data = data
        self.titleDate.text = data.first!.time.convertToMonthDayCombination()
        collectionView.reloadData()
    }
}

// MARK: UICollectionViewDataSource
extension CompleteDayCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let individualCell = collectionView.dequeueReusableCell(withReuseIdentifier: "meal", for: indexPath) as! IndividualDayCell
        if let data = data?[indexPath.item] {
            individualCell.image.image = data.image
            individualCell.name.text = data.names.first
            individualCell.dateCreated.text = data.time.convertTo12hour()
            
            individualCell.item = indexPath.item
            individualCell.delegate = self
        }
        return individualCell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension CompleteDayCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let testLbl = UILabel()
        testLbl.textAlignment = .center
        testLbl.font = UIFont(name: "Futura-Bold", size: 17)
        testLbl.text = data?[indexPath.item].names.first ?? ""
        if testLbl.intrinsicContentSize.width < 150 {
            return CGSize(width: 150, height: 150)
        }
        return CGSize(width: testLbl.intrinsicContentSize.width, height: 150)
    }
}

// MARK: IndividualDayCellDelegate
extension CompleteDayCell: IndividualDayCellDelegate {
    func onUserSelected(for item: Int) {
        delegate.onUserClicked(selected: data![item].nutritionInformation)
    }
}

// MARK: Properties, IBOutlets, and IBActions
class IndividualDayCell: UICollectionViewCell {
    
    public var item: Int?
    public var delegate: IndividualDayCellDelegate?
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dateCreated: UILabel!
    
    @IBAction func userSelected(_ sender: Any) {
        delegate?.onUserSelected(for: item!)
    }
}

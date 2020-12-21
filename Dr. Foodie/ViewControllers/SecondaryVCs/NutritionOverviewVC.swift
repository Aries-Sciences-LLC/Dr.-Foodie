//
//  LocalNutritionOverviewVC.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 12/20/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: NutritionOverviewVCDelegate
@objc protocol NutritionOverviewVCDelegate {
    @objc optional func userSelectedCategories(categories: [String], for image: UIImage)
    @objc optional func userReviewing(data: NutritionOutput)
}


// MARK: Properties, IBOutlets, IBActions
class NutritionOverviewVC: DRFVC {

    @IBOutlet weak var nutritionTable: UITableView!
    
    private var names: [String]?
    private var image: UIImage?
    private var nutritionData: NutritionOutput?
    
    public var parentVC: CategorySelectionVC?
    
    @IBAction func added(_ sender: Any!) {
        dismiss(animated: true) {
            self.parentVC?.cancel(UIButton())
            let journal = JournalManager.Food(names: self.names!, image: self.image!, nutritionInformation: self.nutritionData!)
            JournalManager.add(meal: journal)
            CloudKitManager.meals(action: .upload) {
                QuickAddData.insert(new: QuickAddContainer(image: self.image!, called: self.names!.first!))
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

// MARK: Methods
extension NutritionOverviewVC {
    func viewingMode() {
        view.subviews[1].constraints.forEach { (constraint) in
            if constraint.identifier == "hider" {
                constraint.constant = 0
            }
        }
    }
}

// MARK: UITableViewDelegate
extension NutritionOverviewVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.item {
        case 0:
            return 50
        case 1, 4, 18:
            return 10
        case 23:
            return 50
        default:
            return 30
        }
    }
}

// UITableViewDataSource
extension NutritionOverviewVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let amount = nutritionData?.amount {
            return amount + 7
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case 0:
            return nutritionTable.dequeueReusableCell(withIdentifier: "title")!
        case 1:
            return nutritionTable.dequeueReusableCell(withIdentifier: "divider")!
        case 2:
            return nutritionTable.dequeueReusableCell(withIdentifier: "subtitle")!
        case 3:
            let cell = nutritionTable.dequeueReusableCell(withIdentifier: "calories")!
            (cell.contentView.subviews[1] as! UILabel).text = nutritionData?.calories?.value
            return cell
        case 4:
            return nutritionTable.dequeueReusableCell(withIdentifier: "divider")!
        case 5:
            return nutritionTable.dequeueReusableCell(withIdentifier: "description")!
        case 6:
            let cell = nutritionTable.dequeueReusableCell(withIdentifier: "totalFat")!
            (cell.contentView.subviews[1] as! UILabel).text = nutritionData?.totalFat?.value
            (cell.contentView.subviews[2] as! UILabel).text = nutritionData?.totalFat?.percent
            return cell
        case 7:
            let cell = nutritionTable.dequeueReusableCell(withIdentifier: "saturatedFat")!
            (cell.contentView.subviews[1] as! UILabel).text = nutritionData?.saturatedFat?.value
            (cell.contentView.subviews[2] as! UILabel).text = nutritionData?.saturatedFat?.percent
            return cell
        case 8:
            let cell = nutritionTable.dequeueReusableCell(withIdentifier: "transFat")!
            (cell.contentView.subviews[1] as! UILabel).text = nutritionData?.transFat?.value
            return cell
        case 9:
            let cell = nutritionTable.dequeueReusableCell(withIdentifier: "polySaturatedFat")!
            (cell.contentView.subviews[1] as! UILabel).text = nutritionData?.polysaturatedFat?.value
            return cell
        case 10:
            let cell = nutritionTable.dequeueReusableCell(withIdentifier: "monounSaturatedFat")!
            (cell.contentView.subviews[1] as! UILabel).text = nutritionData?.monounsaturatedFat?.value
            return cell
        case 11:
            let cell = nutritionTable.dequeueReusableCell(withIdentifier: "cholesterol")!
            (cell.contentView.subviews[1] as! UILabel).text = nutritionData?.cholesterol?.value
            (cell.contentView.subviews[2] as! UILabel).text = nutritionData?.cholesterol?.percent
            return cell
        case 12:
            let cell = nutritionTable.dequeueReusableCell(withIdentifier: "sodium")!
            (cell.contentView.subviews[1] as! UILabel).text = nutritionData?.sodium?.value
            (cell.contentView.subviews[2] as! UILabel).text = nutritionData?.sodium?.percent
            return cell
        case 13:
            let cell = nutritionTable.dequeueReusableCell(withIdentifier: "potassium")!
            (cell.contentView.subviews[1] as! UILabel).text = nutritionData?.potassium?.value
            (cell.contentView.subviews[2] as! UILabel).text = nutritionData?.potassium?.percent
            return cell
        case 14:
            let cell = nutritionTable.dequeueReusableCell(withIdentifier: "totalCarbohydrates")!
            (cell.contentView.subviews[1] as! UILabel).text = nutritionData?.totalCarbohydrates?.value
            (cell.contentView.subviews[2] as! UILabel).text = nutritionData?.totalCarbohydrates?.percent
            return cell
        case 15:
            let cell = nutritionTable.dequeueReusableCell(withIdentifier: "dietaryFiber")!
            (cell.contentView.subviews[1] as! UILabel).text = nutritionData?.dietaryFiber?.value
            (cell.contentView.subviews[2] as! UILabel).text = nutritionData?.dietaryFiber?.percent
            return cell
        case 16:
            let cell = nutritionTable.dequeueReusableCell(withIdentifier: "sugars")!
            (cell.contentView.subviews[1] as! UILabel).text = nutritionData?.sugars?.value
            return cell
        case 17:
            let cell = nutritionTable.dequeueReusableCell(withIdentifier: "protein")!
            (cell.contentView.subviews[1] as! UILabel).text = nutritionData?.protein?.value
            (cell.contentView.subviews[2] as! UILabel).text = nutritionData?.protein?.percent
            return cell
        case 18:
            return nutritionTable.dequeueReusableCell(withIdentifier: "divider")!
        case 19:
            let cell = nutritionTable.dequeueReusableCell(withIdentifier: "vitaminA")!
            (cell.contentView.subviews[1] as! UILabel).text = nutritionData?.vitaminA?.value
            (cell.contentView.subviews[2] as! UILabel).text = nutritionData?.vitaminA?.percent
            return cell
        case 20:
            let cell = nutritionTable.dequeueReusableCell(withIdentifier: "vitaminC")!
            (cell.contentView.subviews[1] as! UILabel).text = nutritionData?.vitaminC?.value
            (cell.contentView.subviews[2] as! UILabel).text = nutritionData?.vitaminC?.percent
            return cell
        case 21:
            let cell = nutritionTable.dequeueReusableCell(withIdentifier: "calcium")!
            (cell.contentView.subviews[1] as! UILabel).text = nutritionData?.calcium?.value
            (cell.contentView.subviews[2] as! UILabel).text = nutritionData?.calcium?.percent
            return cell
        case 22:
            let cell = nutritionTable.dequeueReusableCell(withIdentifier: "iron")!
            (cell.contentView.subviews[1] as! UILabel).text = nutritionData?.iron?.value
            (cell.contentView.subviews[2] as! UILabel).text = nutritionData?.iron?.percent
            return cell
        case 23:
            return nutritionTable.dequeueReusableCell(withIdentifier: "footer")!
        default:
            return UITableViewCell()
        }
    }
}

// MARK: NutritionOverviewVCDelegate
extension NutritionOverviewVC: NutritionOverviewVCDelegate {
    func userSelectedCategories(categories: [String], for image: UIImage) {
        let params = NutritionInformation.NutritionInput.Body(query: categories.joined(separator: ", "))
        let input = NutritionInformation.NutritionInput(body: params)
        names = categories
        self.image = image
        NutritionInformation.getNutrition(for: input) { (output) in
            DispatchQueue.main.async {
                self.userReviewing(data: output)
            }
        }
    }
    
    func userReviewing(data: NutritionOutput) {
        nutritionData = data
        nutritionTable.reloadData()
    }
}

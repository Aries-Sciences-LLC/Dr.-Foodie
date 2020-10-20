//
//  HomeVC.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 9/21/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit
import CardSlider

// MARK: Meal
struct Meal: CardSliderItem {
    var rating: Int?
    
    let image: UIImage
    let title: String
    let subtitle: String?
    let description: String?
    
    let nutrition: NutritionOutput
}

// MARK: Properties, IBOutlets, & IBActions
class HomeVC: UIViewController {
    
    var meals: [Meal] = []
    var nutritionOverviewDelegate: NutritionOverviewVCDelegate?
    var currentItem = 0
    
    @IBOutlet weak var todayPage: UIView!
    @IBOutlet weak var fullJournal: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var fullX: NSLayoutConstraint!
    @IBOutlet weak var todayX: NSLayoutConstraint!

    var cardSlider: CardSliderViewController?
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        switch sender.currentPage {
        case 0:
            leftSwipe(sender)
        case 1:
            rightSwipe(sender)
        default:
            break
        }
    }
    
    @IBAction func rightSwipe(_ sender: Any) {
        todayX.constant = 0
        fullX.constant = view.bounds.width
        pageControl.currentPage = 0
        update()
    }
    
    @IBAction func leftSwipe(_ sender: Any) {
        todayX.constant = -view.bounds.width
        fullX.constant = 20
        pageControl.currentPage = 1
        update()
    }
    
    @IBAction func pageSelected(_ sender: Any) {
        onUserClicked(selected: meals[currentItem].nutrition)
    }
}

// MARK: Methods
extension HomeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CloudKitManager.meals(action: .fetch) {
            JournalManager.meals.forEach { (meal) in
                self.meals.append(
                    Meal(
                        rating: nil,
                        image: meal.image,
                        title: meal.names.joined(separator: ", "),
                        subtitle: meal.time.convertTo12hour(),
                        description: nil,
                        nutrition: meal.nutritionInformation
                    )
                )
            }
            
            self.meals.reverse()
            
            DispatchQueue.main.async {
                self.fullJournal.dataSource = self
                
                self.cardSlider = CardSliderViewController.with(dataSource: self)
                self.cardSlider!.title = "Today's Journal"
                self.addChild(self.cardSlider!)
                self.todayPage.addSubview(self.cardSlider!.view)
                self.cardSlider!.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
                self.cardSlider!.didMove(toParent: self)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        rightSwipe(pageControl!)
        todayPage.layoutSubviews()
        cardSlider?.collectionView.reloadData()
        update()
    }
    
    override func viewWillLayoutSubviews() {
        cardSlider?.collectionView.reloadData()
        update()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: NutritionOverviewVC.self) {
            nutritionOverviewDelegate = (segue.destination as! NutritionOverviewVC)
            (segue.destination as! NutritionOverviewVC).viewingMode()
        }
    }
    
    private func update() {
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: CardSliderDataSource
extension HomeVC: CardSliderDataSource {
    func item(for index: Int) -> CardSliderItem {
        return meals[index]
    }
    
    func numberOfItems() -> Int {
        return meals.count
    }
    
    func userSwiped(to item: Int) {
        currentItem = item
    }
}

// MARK: UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalManager.history.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "day") as! CompleteDayCell
        cell.set(data: JournalManager.getLatest())
        cell.delegate = self
        return cell
    }
}

// MARK: UITableViewDelegate
extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 235
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UILabel()
        header.text = "Your Journal"
        header.font = UIFont(name: "Futura-Bold", size: 35)
        header.frame.origin = CGPoint(x: 20, y: 8)
        return header
    }
}

// MARK:
extension HomeVC: CompleteDayCellDelegate {
    func onUserClicked(selected nutrition: NutritionOutput) {
        performSegue(withIdentifier: "displayNutrition", sender: self)
        nutritionOverviewDelegate?.userReviewing?(data: nutrition)
    }
}

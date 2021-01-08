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

// MARK: HomeVCDelegate
protocol HomeVCDelegate {
    func dataIsIn()
}


// MARK: Properties, IBOutlets, & IBActions
class HomeVC: BaseVC {
    
    var meals: [Meal] = []
    var historical: [[JournalManager.Food]] = []
    var nutritionOverviewDelegate: NutritionOverviewVCDelegate?
    var currentItem = 0
    var messageMode: MessageMode?
    
    enum MessageMode {
        case both, meals, history
    }
    
    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var todayPage: UIView!
    @IBOutlet weak var fullJournal: UITableView!
    @IBOutlet var cardsListener: UITapGestureRecognizer!
    @IBOutlet weak var switcher: UISegmentedControl!
    
    @IBOutlet weak var fullX: NSLayoutConstraint!
    @IBOutlet weak var todayX: NSLayoutConstraint!

    var cardSlider: CardSliderViewController?
    var booted: Bool = false
    var notifier: NSObjectProtocol?
    var delegate: HomeVCDelegate?
    
    @IBAction func pageChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            rightSwipe()
        case 1:
            leftSwipe()
        default:
            break
        }
    }
    
    @IBAction func pageSelected(_ sender: Any) {
        onUserClicked(selected: meals[currentItem].nutrition)
    }
}

// MARK: Methods
extension HomeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switcher.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Futura-Bold", size: 13) ?? UIFont.boldSystemFont(ofSize: 13)], for: .normal)
        
        rightSwipe()
        
        CloudKitManager.meals(action: .fetch) {
            self.reload()
            
            DispatchQueue.main.async {
                self.delegate?.dataIsIn()
                
                let shouldPopulateMeals = self.meals.count > 0
                let shouldPopulateHistory = JournalManager.history.count > 0
                
                if !shouldPopulateMeals && !shouldPopulateHistory {
                    self.messageMode = .both
                } else if !shouldPopulateMeals {
                    self.messageMode = .meals
                } else if !shouldPopulateHistory {
                    self.messageMode = .history
                }
                
                UIView.animate(withDuration: 0.3) {
                    self.todayPage.alpha = shouldPopulateMeals ? 1 : 0
                    self.fullJournal.alpha = shouldPopulateHistory ? 1 : 0
                    self.emptyMessage.alpha = shouldPopulateMeals ? 0 : 1
                }
                
                if shouldPopulateHistory {
                    self.fullJournal.reloadData()
                }
                
                if shouldPopulateMeals {
                    self.recreate()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        notifier = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "updateSlider"), object: nil, queue: nil, using: { _ in
            self.recreate()
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        cardSlider?.collectionView.reloadData()
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        
//        NotificationCenter.default.removeObserver(notifier)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: NutritionOverviewVC.self) {
            nutritionOverviewDelegate = (segue.destination as! NutritionOverviewVC)
            (segue.destination as! NutritionOverviewVC).viewingMode()
        }
    }
    
    func rightSwipe() {
        emptyMessage.text = "Why don't you go snap a pic of your first meal of the day!"
        cardsListener.isEnabled = true
        todayX.constant = 0
        fullX.constant = view.bounds.width
        switcher.selectedSegmentIndex = 0
        UIView.animate(withDuration: 0.3) {
            self.emptyMessage.alpha = self.messageMode == .both || self.messageMode == .meals ? 1 : 0
        }
        update()
    }
    
    func leftSwipe() {
        emptyMessage.text = "This is where all of your previous days go!"
        cardsListener.isEnabled = false
        todayX.constant = -view.bounds.width
        fullX.constant = 20
        switcher.selectedSegmentIndex = 1
        UIView.animate(withDuration: 0.3) {
            self.emptyMessage.alpha = self.messageMode == .both || self.messageMode == .history ? 1 : 0
        }
        update()
    }
    
    public func reload() {
        meals = []
        historical = []
        
        JournalManager.meals.forEach { (meal) in
            self.meals.append(convert(meal: meal))
        }
        
        JournalManager.history.forEach { _ in
            historical.append(JournalManager.getLatest())
        }
        
        historical.insert(historical.popLast() ?? [], at: 0)
        
        meals.reverse()
    }
    
    @objc public func recreate() {
        
        todayPage.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        
        self.reload()
        
        cardSlider = CardSliderViewController.with(dataSource: self)
        cardSlider!.title = "Today's Journal"
        addChild(self.cardSlider!)
        todayPage.addSubview(cardSlider!.view)
        cardSlider!.didMove(toParent: self)
    }
    
    private func update() {
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func convert(meal: JournalManager.Food) -> Meal {
        return Meal(
            rating: nil,
            image: meal.image,
            title: meal.names.joined(separator: ", "),
            subtitle: meal.time.convertTo12hour(),
            description: nil,
            nutrition: meal.nutritionInformation
        )
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
        return historical.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "day") as! CompleteDayCell
        cell.set(data: historical[indexPath.item])
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
        header.font = UIFont(name: "Futura-Bold", size: 25)
        header.frame.origin = CGPoint(x: 20, y: 8)
        return header
    }
}

// MARK: CompleteDayCellDelegate
extension HomeVC: CompleteDayCellDelegate {
    func onUserClicked(selected nutrition: NutritionOutput) {
        performSegue(withIdentifier: "displayNutrition", sender: self)
        nutritionOverviewDelegate?.userReviewing?(data: nutrition)
    }
}

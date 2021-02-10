//
//  HomeVC.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 9/21/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit

// MARK: HomeVCDelegate
protocol HomeVCDelegate {
    func dataIsIn()
}

// MARK: Properties, IBOutlets, & IBActions
class HomeVC: BaseVC {
    
    var historical: [[JournalManager.Food]] = []
    var nutritionOverviewDelegate: NutritionOverviewVCDelegate?
    var messageMode: MessageMode?
    
    enum MessageMode {
        case both, meals, history
    }
    
    @IBOutlet weak var inFetchingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyContainer: UIStackView!
    @IBOutlet weak var emptyMessage: UILabel!
    @IBOutlet weak var showCamera: UIButton!
    @IBOutlet weak var todayPage: UIView!
    @IBOutlet weak var fullJournal: UITableView!
    @IBOutlet weak var switcher: UISegmentedControl!
    
    @IBOutlet weak var fullX: NSLayoutConstraint!
    @IBOutlet weak var todayX: NSLayoutConstraint!
    
    var booted: Bool = false
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
}

// MARK: Methods
extension HomeVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switcher.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Futura-Bold", size: 13) ?? UIFont.boldSystemFont(ofSize: 13)], for: .normal)
        
        rightSwipe()
        
        CloudKitManager.meals(action: .fetch) { [self] in
            reload()
            
            DispatchQueue.main.async { [self] in
                inFetchingIndicator.stopAnimating()
                
                delegate?.dataIsIn()
                
                let shouldPopulateMeals = JournalManager.meals.count > 0
                let shouldPopulateHistory = JournalManager.history.count > 0
                
                if !shouldPopulateMeals && !shouldPopulateHistory {
                    messageMode = .both
                } else if !shouldPopulateMeals {
                    messageMode = .meals
                } else if !shouldPopulateHistory {
                    messageMode = .history
                }
                
                UIView.animate(withDuration: 0.3) { [self] in
                    todayPage.alpha = shouldPopulateMeals ? 1 : 0
                    fullJournal.alpha = shouldPopulateHistory ? 1 : 0
                    emptyContainer.alpha = shouldPopulateMeals ? 0 : 1
                }
                
                if shouldPopulateMeals {
                    children.forEach {
                        // guard let child = $0 as? TodayJournalVC else { return }
                        ($0 as? TodayJournalVC)?.updateDataSource()
                        ($0 as? TodayJournalVC)?.resetCardAnimation()
                    }
                }
                
                if shouldPopulateHistory {
                    fullJournal.reloadData()
                }
            }
        }
        
        showCamera.layer.borderWidth = 0.35
        showCamera.layer.borderColor = UIColor.label.cgColor
        showCamera.addTarget(parent, action: #selector((parent as! ContainerVC).goToCamera(_:)), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        emptyMessage.layer.shadowColor = emptyMessage.textColor.cgColor
        emptyMessage.layer.shadowOffset = CGSize(width: 3, height: 3)
        emptyMessage.layer.shadowRadius = 12
        emptyMessage.layer.shadowOpacity = 1
        
        switcher.layer.shadowColor = switcher.tintColor.cgColor
        switcher.layer.shadowOffset = CGSize(width: 3, height: 3)
        switcher.layer.shadowRadius = 8
        switcher.layer.shadowOpacity = 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: NutritionOverviewVC.self) {
            nutritionOverviewDelegate = (segue.destination as! NutritionOverviewVC)
            (segue.destination as! NutritionOverviewVC).viewingMode()
        }
    }
    
    func rightSwipe() {
        if messageMode == .both || messageMode == .meals {
            emptyMessage.text = "Why don't you go snap a pic of your first meal of the day!"
        }
        todayX.constant = 0
        fullX.constant = view.bounds.width
        switcher.selectedSegmentIndex = 0
        UIView.animate(withDuration: 0.3) {
            self.emptyContainer.alpha = self.messageMode == .both || self.messageMode == .meals ? 1 : 0
        }
        update()
    }
    
    func leftSwipe() {
        if messageMode == .both || messageMode == .history {
            emptyMessage.text = "This is where all of your previous days go!"
        }
        todayX.constant = -view.bounds.width
        fullX.constant = 20
        switcher.selectedSegmentIndex = 1
        UIView.animate(withDuration: 0.3) {
            self.emptyContainer.alpha = self.messageMode == .both || self.messageMode == .history ? 1 : 0
        }
        update()
    }
    
    public func reload() {
        self.children.forEach {
            guard let child = $0 as? TodayJournalVC else { return }
            child.reload()
        }
        
        historical = []
        JournalManager.history.forEach { _ in
            historical.append(JournalManager.getLatest())
        }
        historical.insert(historical.popLast() ?? [], at: 0)
    }
    
    private func update() {
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
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

// MARK: ContainerVCDelegate
extension HomeVC: ContainerVCDelegate {
    func wasSummonedUpon() {
        reload()
        children.forEach {
            // guard let child = $0 as? TodayJournalVC else { return }
            ($0 as? TodayJournalVC)?.updateDataSource()
            ($0 as? TodayJournalVC)?.resetCardAnimation()
        }
    }
    
    func isBeingShown() {
//        children.forEach {
//            guard let child = $0 as? TodayJournalVC else { return }
//            child.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
//        }
    }
}

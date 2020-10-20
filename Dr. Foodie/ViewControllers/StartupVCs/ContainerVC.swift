//
//  ContainerVC.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/9/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit
import CircularCarousel

// MARK: IBOutlets, Properties, Override Methods
class ContainerVC: UIViewController {

    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var welcomeLbl: UILabel!
    @IBOutlet weak var quickAdd: UICollectionView!
    @IBOutlet weak var whiteBottomView: UIView!
    @IBOutlet weak var navigationView: ContainerTableView!
    
    private var tableCarouselView: TableCarouselView?
    private var buttonCarouselView: ButtonCarouselView?
    private var selectedItemIndex = ViewConstants.startingCarouselItem
    private var controllers: [UIView] = []
    private var selectedQuickAdd: QuickAddContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupNavigation()
        
        ["HomePage", "BussinessLocator", "AddMeal", "DailyInformation", "UserAccount"].forEach { (identifier) in
            let controller = storyboard!.instantiateViewController(withIdentifier: identifier)
            addChild(controller)
            controllers.append(controller.view)
            controller.didMove(toParent: self)
        }
        
        welcomeLbl.text! += "\n\(User.authorized()?.firstName ?? "my guy")?"
        
        CloudKitManager.quickAdd(action: .fetch) {
            DispatchQueue.main.async {
                self.quickAdd.reloadData()
                // (self.children[0] as! HomeVC).foodSet()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateBackground(direction: .left)
    }
}

// MARK: Methods
extension ContainerVC {
    private func animateBackground(direction: AnimationDirection) {
        view.constraints.forEach { (constraint) in
            if constraint.identifier == "xValue" {
                switch direction {
                case .left:
                    constraint.constant = view.frame.width - bg.frame.width
                case .right:
                    constraint.constant = 0
                }
            }
        }
        
        UIView.animate(withDuration: 15, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            switch direction {
            case .left:
                self.animateBackground(direction: .right)
            case .right:
                self.animateBackground(direction: .left)
            }
        }
    }
    
    private func setupNavigation() {
        navigationView.style(withDetail: .primary)
        // Setup table view controls
        navigationView.register(UINib(nibName: ViewConstants.NibNames.tableCarousel, bundle: nil), forCellReuseIdentifier: ViewConstants.CellIdentifiers.tableCarousel)
        navigationView.register(UINib(nibName: ViewConstants.NibNames.buttons, bundle: nil), forCellReuseIdentifier: ViewConstants.CellIdentifiers.buttons)
        navigationView.separatorInset.left = 0
        navigationView.bounds = CGRect(x: 0,
                                  y: 0,
                                  width: navigationView.bounds.size.width,
                                  height: navigationView.bounds.size.height * 2)
    }
    
    private func applyImageScale(withScrollView scrollView: UIScrollView) {
        whiteBottomView.frame = CGRect(origin: CGPoint(x: 0,
                                                       y: scrollView.contentSize.height - scrollView.contentOffset.y + 0),
                                       size: whiteBottomView.frame.size)
        
        let minScale:CGFloat = 1.1
        let maxScale:CGFloat = 2.0
        
        let offset = navigationView.contentOffset.y
        let height = navigationView.contentSize.height
        
        var scale = (1.0 / height) * offset
        
        scale = scale * (maxScale - minScale)
        scale += minScale
        
        bg.applyScale(scale)
    }
    
    public func updateQuickAdd() {
        quickAdd.reloadData()
    }
}

// MARK: UITableViewDelegate
extension ContainerVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            cell.backgroundView = nil
            cell.backgroundColor = UIColor.clear
            cell.layer.backgroundColor = UIColor.clear.cgColor
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return ViewConstants.topRowScreenRatio * view.bounds.height
        case ViewConstants.RowIndex.buttonCarousel:
            return ViewConstants.CellHeights.buttonsCarousel
        case ViewConstants.RowIndex.tableCarousel:
            return UIScreen.main.bounds.height
        default:
            return ViewConstants.CellHeights.normal
        }
    }
}

// MARK: UITableViewDataSource
extension ContainerVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        
        switch row {
        case 0:
            let cell = UITableViewCell()
            cell.backgroundColor = UIColor.clear
            cell.separatorInset = UIEdgeInsets(top: 0.0, left: tableView.bounds.size.width, bottom: 0.0, right: 0.0)
            return cell
            
        case ViewConstants.RowIndex.tableCarousel:
            if let tableCarouselView = self.tableCarouselView {
                // Cache the table Carousel view - There is only one
                return tableCarouselView
            } else {
                let cell: TableCarouselView = tableView.dequeueReusableCell(withIdentifier: ViewConstants.CellIdentifiers.tableCarousel) as! TableCarouselView
                
                cell.delegate = self
                cell.views = controllers
                
                cell.carousel.panEnabled = false
                cell.carousel.swipeEnabled = false
                cell.carousel.reloadData()
                tableCarouselView = cell
                return cell
            }
        
        case ViewConstants.RowIndex.buttonCarousel:
            let cell: ButtonCarouselView = tableView.dequeueReusableCell(withIdentifier: ViewConstants.CellIdentifiers.buttons) as! ButtonCarouselView
            cell.backgroundColor = UIColor.clear
            
            cell.delegate = self
            cell.dataSource = self

            cell.carousel.panEnabled = false
            cell.carousel.swipeEnabled = true
            
            cell.carousel.reloadData()
            
            buttonCarouselView = cell
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewConstants.numberOfPrimaryViewRows
    }
}

// MARK: ButtonCarouselViewDelegate
extension ContainerVC: ButtonCarouselViewDelegate {
    func buttonCarousel(_ carousel: ButtonCarouselView, buttonPressed button: UIButton) {
    }
    
    func buttonCarousel(_ carousel: ButtonCarouselView, willScrollToIndex index: IndexPath) {
        // Pass the message to the image carousel
        selectedItemIndex = index.row
        tableCarouselView?.carousel.scroll(toItemAtIndex: index.row, animated: true)
    }
    
    func startingIndex(forButtonCarousel carousel: ButtonCarouselView) -> Int {
        return selectedItemIndex
    }
    
    func itemWidth(forButtonCarousel carousel: ButtonCarouselView) -> CGFloat {
        return ViewConstants.Size.carouselButtonItemWidith
    }
}

// MARK: ButtonCarouselViewDataSource
extension ContainerVC: ButtonCarouselViewDataSource {
    func buttonCarousel(_ buttonCarousel: ButtonCarouselView, modelForIndex index: IndexPath) -> ButtonCarouselModel {
        return CarouselData.buttonViewModels[index.row]
    }
    
    func numberOfButtons(inButtonCarousel buttonCarousel: ButtonCarouselView) -> Int {
        return CarouselData.buttonViewModels.count
    }
}

// MARK: TableCarouselViewDelegate
extension ContainerVC: TableCarouselViewDelegate {
    func numberOfItems(inTableCarousel view: TableCarouselView) -> Int {
        return ViewConstants.numberOfCarouselItems
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension ContainerVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = quickAdd.frame.width / 2
        if let insets = (quickAdd.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset {
            size -= insets.left + insets.right
        }
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: quickAdd.frame.width, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return quickAdd.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
    }
}

// MARK: UICollectionViewDataSource
extension ContainerVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return QuickAddData.containers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = quickAdd.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! QuickAddItem
        cell.tag = indexPath.item
        cell.insert(item: QuickAddData.containers[indexPath.item]) {
            self.buttonCarouselView?.carousel.scroll(toItemAtIndex: 2, animated: true)
            self.tableCarouselView?.carousel.scroll(toItemAtIndex: 2, animated: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.navigationView.scrollToRow(at: IndexPath(item: 2, section: 0), at: .bottom, animated: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.children.forEach { (controller) in
                        if controller.isKind(of: SnapMealVC.self) {
                            (controller as! SnapMealVC).photoWasTaken(photo: cell.itemImage.image!)
                            cell.listener.isEnabled = true
                        }
                    }
                }
            }
        }
        return cell
    }
}

// ContainerTableView
class ContainerTableView: UITableView {
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return !(cellForRow(at: IndexPath(item: 0, section: 0))?.frame.contains(point) ?? false)
    }
}

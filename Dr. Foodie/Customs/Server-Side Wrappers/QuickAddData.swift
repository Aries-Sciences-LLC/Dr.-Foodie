//
//  QuickAddData.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 10/13/20.
//  Copyright © 2020 Aries Sciences LLC. All rights reserved.
//

import UIKit
import CloudKit

// MARK: Properties
struct QuickAddData {
    static private(set) var containers: [QuickAddContainer] = []
    
    static public var handler: (() -> Void)?
    static public var display: ContainerVC?
    
    struct Package {
        var names: [String]
        var images: [CKAsset?]
    }
}

// MARK: Methods
extension QuickAddData {
    public static func add(container: QuickAddContainer) {
        containers.append(container)
    }
    
    public static func extract() -> Package {
        var names: [String] = []
        var images: [CKAsset?] = []
        
        containers.forEach { (container) in
            names.append(container.itemName)
            images.append(container.itemImage?.cloud())
        }
        
        return Package(names: names, images: images)
    }
    
    public static func insert(new item: QuickAddContainer, completion: @escaping () -> Void) {
        containers.insert(item, at: 0)
        if containers.count > 4 {
            containers.removeLast()
        }
        CloudKitManager.quickAdd(action: .update) {
            DispatchQueue.main.async {
                if let vc = display {
                    vc.quickAdd.reloadData()
                }
            }
            completion()
        }
    }
    
    public static func fetch() {
        CloudKitManager.quickAdd(action: .fetch) {
            DispatchQueue.main.async {
                handler?()
            }
        }
    }
}

// MARK: QuickAddContainer
struct QuickAddContainer {
    public var itemImage: UIImage?
    public var itemName: String
    
    public init(image: URL, called name: String) {
        itemImage = UIImage(data: try! Data(contentsOf: image))
        itemName = name
    }
    
    public init(image: String, called name: String) {
        itemImage = UIImage(named: image)
        itemName = name
    }
    
    public init(image: UIImage, called name: String) {
        itemImage = image
        itemName = name
    }
}

//
//  ReachabilityHandler.swift
//  Dr. Foodie
//
//  Created by Ozan Mirza on 2/7/21.
//  Copyright © 2021 Aries Sciences LLC. All rights reserved.
//

class ReachabilityHandler: ReachabilityObserverDelegate {
    
    var handler: ((_ isReachable: Bool) -> Void)?
  
    //MARK: Lifecycle
  
    required init() {
        try? addReachabilityObserver()
    }
  
    deinit {
        removeReachabilityObserver()
    }
  
    // MARK: Reachability
    
    func reachabilityChanged(_ isReachable: Bool) {
        handler?(isReachable)
    }
}

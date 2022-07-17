//
//  MainCoordinator.swift
//  ZuriHealthTest
//
//  Created by ANTHONY NWUDO WEMABANK on 16/07/2022.
//

import Foundation
import Foundation
import UIKit
class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func eventOccured(event: Event) {
        switch event {
        case .addToNewItemToBasketTapped:
          var vc:UIViewController & Coordinating = ItemsViewController()
          vc.coordinator = self
          navigationController?.pushViewController(vc, animated: true)
            break
        default:
            var vc:UIViewController & Coordinating = MainPageViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func start() {
        var vc:UIViewController & Coordinating = MainPageViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: true)
    }
    
    

    
    
}

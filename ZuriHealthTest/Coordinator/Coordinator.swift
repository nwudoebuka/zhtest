//
//  Coordinator.swift
//  ZuriHealthTest
//
//  Created by ANTHONY NWUDO WEMABANK on 16/07/2022.
//
import Foundation
import UIKit
enum Event{
    case addToNewItemToBasketTapped
    case navigateEvent
}
protocol Coordinator {
      //var childCoordinators: [Coordinator] { get set }
      var navigationController: UINavigationController? { get set }
      func eventOccured(event:Event)
      func start()
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}

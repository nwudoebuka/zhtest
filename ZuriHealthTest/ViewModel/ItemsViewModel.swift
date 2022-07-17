//
//  ItemsViewModel.swift
//  ZuriHealthTest
//
//  Created by ANTHONY NWUDO WEMABANK on 17/07/2022.
//

import Foundation
import CoreData
import UIKit

enum ReferEarnListState {
    case ReferEarnListStatePending
    case ReferEarnListStateCompleted
}

enum ItemsViewModelState {
    case ItemsViewModelDidStartRetrievingItems
    case ItemsViewModelDidFailToRetrieveItems
    case ItemsViewModelDidEndRetrievingItems
}

protocol ItemsViewModelDelegate: AnyObject {
    func ItemsViewModelDidTransitionToState(model: ItemsViewModel, state: ItemsViewModelState)
}

final class ItemsViewModel: NSObject  {
    
    var items = [ItemEntity]()
  let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
    private var apiLoader: ServiceProtocol?
    public weak var delegate:ItemsViewModelDelegate?
    private var currentListState:ReferEarnListState = .ReferEarnListStatePending
    var itemsList: ResponseModel?
  var errorMessage: String?
    required init(apiLoader: ServiceProtocol = Service()) {
        self.apiLoader = apiLoader
        super.init()
    }
    
  public func saveItemToBasket(_ name: String,_ price: String,_ image: UIImage){
    let entityName =  NSEntityDescription.entity(forEntityName: "ItemEntity", in: managedContext)!
    let newItem = NSManagedObject(entity: entityName, insertInto: managedContext)
    newItem.setValue(name, forKey: #keyPath(ItemEntity.name))
    newItem.setValue(price, forKey: #keyPath(ItemEntity.price))
    let pngImageData  = image.pngData()
    newItem.setValue(pngImageData, forKeyPath: "image")
    do {
      try managedContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }
    
  }
  
  func deleteAllItems()->Bool{
    // get reference to the persistent container
    let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ItemEntity")
       let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
       do {
           try persistentContainer.viewContext.execute(deleteRequest)
         return true
       } catch let error as NSError {
           debugPrint(error)
         return false
       }
  }
  
  public func getSavedBasket()->[NSManagedObject]?{
    
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ItemEntity")
    do {
      let result = try managedContext.fetch(fetchRequest)
      return result
    } catch let error as NSError {
      return nil
    }
    
  }
  
    public func getItems() {
        delegate?.ItemsViewModelDidTransitionToState(model: self, state: .ItemsViewModelDidStartRetrievingItems)
        apiLoader?.getItems(completion: { [weak self] result in
            guard let self = self else {
                return
            }
    
            switch result {
            case .success(let response):
                    self.itemsList = response
              self.delegate?.ItemsViewModelDidTransitionToState(model: self, state: .ItemsViewModelDidEndRetrievingItems)
            case .failure(let failure):
              self.errorMessage = failure.localizedDescription
              self.delegate?.ItemsViewModelDidTransitionToState(model: self, state: .ItemsViewModelDidFailToRetrieveItems)
           
            }
        })
    }
    

}



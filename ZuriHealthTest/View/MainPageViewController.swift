//
//  MainPageViewController.swift
//  ZuriHealthTest
//
//  Created by ANTHONY NWUDO WEMABANK on 16/07/2022.
//

import UIKit
import CoreData

class MainPageViewController: BaseViewController ,Coordinating {
  var coordinator: Coordinator?
  var noSavedItem:UILabel!
  var totalRetailPrice:UILabel!
  
  var totalPriceValue = 0{
    didSet{
      totalRetailPrice.text = "Total price #\(totalPriceValue)"
      if totalPriceValue == 0{
        totalRetailPrice.isHidden = true
      }else{
        totalRetailPrice.isHidden = false
      }
    }
  }
  
  var savedItems:[NSManagedObject]?{
    didSet{
      totalPriceValue = 0
     
      for data in savedItems as! [NSManagedObject] {
        totalPriceValue += Int(data.value(forKey: "price") as! String) ?? 0
       }
      mainPageTableView.reloadData()
    }
  }
  
  var viewModel = ItemsViewModel()
  lazy var clearBascketBtn:UIButton = {
      let clearBascketBtn = UIButton()
    clearBascketBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    clearBascketBtn.setTitle("Clear basket", for: .normal)
    clearBascketBtn.setTitleColor(.link, for: .normal)
    clearBascketBtn.isUserInteractionEnabled = true
    clearBascketBtn.addTarget(self, action: #selector(onTapClear), for: .touchUpInside)
      return clearBascketBtn
  }()
  lazy var addItemBtn:UIButton = {
      let addItemBtn = UIButton()
    addItemBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
    addItemBtn.setTitle("Add to basket", for: .normal)
    addItemBtn.setTitleColor(.link, for: .normal)
    addItemBtn.isUserInteractionEnabled = true
    addItemBtn.addTarget(self, action: #selector(onTapAdd), for: .touchUpInside)
      return addItemBtn
  }()
  
  private let mainPageTableView : UITableView = {
       let mainPageTableView = UITableView()
    mainPageTableView.register(BasketItemsTableViewCell.self, forCellReuseIdentifier: BasketItemsTableViewCell.identifier)
    mainPageTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    mainPageTableView.backgroundColor = .white
       return mainPageTableView
   }()

  override func viewDidAppear(_ animated: Bool) {
    debugPrint("saw view did appear")
    navigationController?.setNavigationBarHidden(true, animated: animated)
    savedItems = viewModel.getSavedBasket()
  }
  
  override func initView() {
    // Do any additional setup after loading the view.
    view.backgroundColor = .white
    mainPageTableView.delegate = self
    mainPageTableView.dataSource = self
    view.addSubview(addItemBtn)
    addItemBtn.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor,padding: UIEdgeInsets(top: 50, left: 20, bottom: 0, right: 20))
    view.addSubview(clearBascketBtn)
    clearBascketBtn.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: UIEdgeInsets(top: 50, left: 20, bottom: 0, right: 0))
    totalRetailPrice = view.labelBold(text: "Total price \(totalPriceValue)")
    view.addSubview(totalRetailPrice)
    totalRetailPrice.anchor(top: clearBascketBtn.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20))
    view.addSubview(mainPageTableView)
    //homeTableView.backgroundColor = .black
    mainPageTableView.separatorStyle = .none
    mainPageTableView.separatorColor = .clear
    mainPageTableView.rowHeight = UITableView.automaticDimension
    mainPageTableView.anchor(top: totalRetailPrice.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,padding: UIEdgeInsets(top: 40, left: 20, bottom: 50, right: 20))
    noSavedItem = noDataLabel("You do not have any saved item(s)")
    view.addSubview(noSavedItem)
    noSavedItem.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    noSavedItem.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    noSavedItem.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
    //mainPageTableView.isHidden = true
  }
  
  @objc func onTapClear(){
    //delete all item from basket
    let clearedItem = viewModel.deleteAllItems()
    if clearedItem{
      savedItems = viewModel.getSavedBasket()
      showSnackBar("Basket cleared")
    }
  }
  
  @objc func onTapAdd(){
   //add item to basket
    coordinator?.eventOccured(event: .addToNewItemToBasketTapped)
  }
  
}

extension MainPageViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      var dataCount = savedItems?.count ?? 0
      if dataCount == 0{
        noSavedItem.isHidden = false
        mainPageTableView.isHidden = true
      }else{
        noSavedItem.isHidden = true
        mainPageTableView.isHidden = false
      }
      return dataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = mainPageTableView.dequeueReusableCell(withIdentifier: BasketItemsTableViewCell.identifier) as! BasketItemsTableViewCell
      cell.selectionStyle = .none
      cell.contentView.isUserInteractionEnabled = false
      if  let items = savedItems{
        cell.configure(items[indexPath.row])
      }
     
      return cell
    }
    
    
}


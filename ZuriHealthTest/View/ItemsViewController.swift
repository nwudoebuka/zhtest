//
//  ItemsViewController.swift
//  ZuriHealthTest
//
//  Created by ANTHONY NWUDO WEMABANK on 17/07/2022.
//

import UIKit

class ItemsViewController:  BaseViewController ,Coordinating {
  var coordinator: Coordinator?
  var titleLabel:UILabel!
  var descriptionLabel:UILabel!
  var labelStackV:UIStackView!
  private let viewModel = ItemsViewModel()
  lazy var backBtn:UIButton = {
      let backBtn = UIButton()
    backBtn.heightAnchor.constraint(equalToConstant: 28).isActive = true
    backBtn.widthAnchor.constraint(equalToConstant: 28).isActive = true
    backBtn.setTitleColor(.link, for: .normal)
    backBtn.isUserInteractionEnabled = true
    if let image = UIImage(named: "ic_back.png") {
      backBtn.setImage(image, for: .normal)
    }
    backBtn.addTarget(self, action: #selector(onTapBack), for: .touchUpInside)
      return backBtn
  }()
  
  let itemsCollectionView : UICollectionView = {
      let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
      let itemsCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 150, height: 150), collectionViewLayout: flowLayout)
    itemsCollectionView.register(ItemsCollectionViewCell.self, forCellWithReuseIdentifier: ItemsCollectionViewCell.identifier)
      flowLayout.itemSize = CGSize(width: 100, height: 100)
      flowLayout.minimumLineSpacing = 80
      flowLayout.minimumInteritemSpacing = 5
      flowLayout.scrollDirection = .vertical
    itemsCollectionView.showsHorizontalScrollIndicator = false
    itemsCollectionView.setCollectionViewLayout(flowLayout, animated: true)
    itemsCollectionView.backgroundColor = .white
//    itemsCollectionView.heightAnchor.constraint(equalToConstant: 105).isActive = true
     
      return itemsCollectionView
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .white
    viewModel.delegate = self
    itemsCollectionView.delegate = self
    itemsCollectionView.dataSource = self
    itemsCollectionView.reloadData()
    titleLabel = labelBold(text: "Add Item",textSize: 20,textColor: .black)
    titleLabel.textAlignment = .center
    view.addSubview(backBtn)
    backBtn.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil,padding: UIEdgeInsets(top: 50, left: 20, bottom: 0, right: 0))
    view.addSubview(titleLabel)
    titleLabel.anchor(top: nil, leading: backBtn.trailingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 48))
    titleLabel.centerYAnchor.constraint(equalTo: backBtn.centerYAnchor).isActive = true
    descriptionLabel = view.labelMedium(text: "Tap on an item you wish to add to the basket, Note: duplicate items aree shown twice in the basket",textSize: 10,textColor: .gray)
    labelStackV = view.generateStackView(axis: .vertical)
    labelStackV.addArrangedSubview(descriptionLabel)
    descriptionLabel.textAlignment = .center
    view.addSubview(labelStackV)
    labelStackV.anchor(top: backBtn.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,padding: UIEdgeInsets(top: 40, left: 20, bottom: 50, right: 20))
    view.addSubview(itemsCollectionView)
    //homeTableView.backgroundColor = .black
    itemsCollectionView.anchor(top: labelStackV.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor,padding: UIEdgeInsets(top: 40, left: 20, bottom: 50, right: 20))
    //itemsCollectionView.isHidden = true
    //showLoading()
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    viewModel.getItems()
  }
  private func updateUI() {
    debugPrint("item list \(viewModel.itemsList)")
    itemsCollectionView.reloadData()
    
  }
  override func initView() {
    
  }
  
  @objc func onTapBack(){
    navigationController?.popViewController(animated: true)
  }
  
  @objc func onTapAdd(){
    debugPrint("add item to basket")
  }
  
}

extension ItemsViewController:UICollectionViewDelegate,UICollectionViewDataSource{
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("seen cell count")
      return viewModel.itemsList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemsCollectionViewCell.identifier, for: indexPath) as! ItemsCollectionViewCell
      if let itemList = viewModel.itemsList{
        let itemObject = Array<ResponseModelValue>(itemList.values)[indexPath.row]
        cell.configure(itemObject)
      }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      if let itemList = viewModel.itemsList{
       let cell = collectionView.cellForItem(at: IndexPath(row: indexPath.row, section: indexPath.section)) as! ItemsCollectionViewCell
        
        let itemObject = Array<ResponseModelValue>(itemList.values)[indexPath.row]
        viewModel.saveItemToBasket(itemObject.name, String(itemObject.retailPrice), (cell.itemImg.image ?? UIImage(named: "dummy_image"))!)
       showSnackBar("Item saved")
      }
     
    }
    
}

extension ItemsViewController:ItemsViewModelDelegate {
  func ItemsViewModelDidTransitionToState(model: ItemsViewModel, state: ItemsViewModelState) {
    
    switch state {
    case .ItemsViewModelDidStartRetrievingItems:
        self.showLoading()
    case .ItemsViewModelDidFailToRetrieveItems:
      self.hideLoading()
      //showError
      self.showError("Failed", viewModel.errorMessage ?? "unable to retrieve items")
    case .ItemsViewModelDidEndRetrievingItems:
      self.hideLoading()
      //updateUI
      updateUI()
    }
    
  }
  
}

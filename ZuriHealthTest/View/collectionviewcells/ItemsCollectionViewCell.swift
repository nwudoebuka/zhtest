//
//  ItemsCollectionViewCell.swift
//  ZuriHealthTest
//
//  Created by ANTHONY NWUDO WEMABANK on 17/07/2022.
//

import UIKit

class ItemsCollectionViewCell: UICollectionViewCell {
  var itemNameLabel:UILabel!
  var retailPriceLabel:UILabel!
  lazy var itemImg:UIImageView = {
      let itemImg = UIImageView()
    itemImg.heightAnchor.constraint(equalToConstant: 100).isActive = true
    itemImg.widthAnchor.constraint(equalToConstant: 100).isActive = true
    itemImg.translatesAutoresizingMaskIntoConstraints = false
    itemImg.contentMode = .scaleToFill
    itemImg.image = UIImage(named: "dummy_image")
      return itemImg
  }()
  
  lazy var mainVH:UIView = {
      let mainVH = UIView()
      mainVH.heightAnchor.constraint(equalToConstant: 140)
      return mainVH
  }()

  static let identifier = "ItemsCollectionViewCell"
  override init(frame: CGRect) {
      super.init(frame: frame)
      initView()
      
  }
  
  required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  func configure(_ data: ResponseModelValue){
    itemNameLabel.text = data.name
    itemImg.setImage(with: data.imageURL)
    retailPriceLabel.text = "#\(String(data.retailPrice))"
  }
  private func initView(){
    addSubview(mainVH)
    mainVH.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil)
    mainVH.addSubview(itemImg)
  itemImg.anchor(top: mainVH.topAnchor, leading: mainVH.leadingAnchor, bottom: mainVH.bottomAnchor, trailing: mainVH.trailingAnchor)
    itemNameLabel = labelBold(text: "N/A",textSize: 11,textColor: .black)
    retailPriceLabel = labelBold(text: "N/A",textSize: 11,textColor: .link)
    itemNameLabel.numberOfLines = 3
  itemNameLabel.textAlignment = .center
    mainVH.addSubview(retailPriceLabel)
    retailPriceLabel.anchor(top: nil, leading: itemImg.leadingAnchor, bottom: itemImg.bottomAnchor, trailing: itemImg.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8))
  addSubview(itemNameLabel)
    itemNameLabel.anchor(top: itemImg.bottomAnchor, leading: itemImg.leadingAnchor, bottom: nil, trailing: itemImg.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
  }
    
}

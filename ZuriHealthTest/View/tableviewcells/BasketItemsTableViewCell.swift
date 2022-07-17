//
//  BasketItemsTableViewCell.swift
//  ZuriHealthTest
//
//  Created by ANTHONY NWUDO WEMABANK on 16/07/2022.
//

import UIKit
import CoreData

class BasketItemsTableViewCell: UITableViewCell {
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
  
    static let identifier = "BasketItemsTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
  func configure(_ data: NSManagedObject){
    itemNameLabel.text = data.value(forKey: "name") as? String
    let price = data.value(forKey: "price") as! String
    retailPriceLabel.text = "#\(price)"
    let imgData = data.value(forKey: "image") as! Data
    itemImg.image = UIImage(data: imgData)
    }
  
   @objc func tapBackBtn(){
      print("taped back")
    }
  
    private func setUpView(){
        addSubview(mainVH)
        mainVH.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil)
        mainVH.addSubview(itemImg)
      itemImg.anchor(top: mainVH.topAnchor, leading: mainVH.leadingAnchor, bottom: mainVH.bottomAnchor, trailing: mainVH.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
      itemNameLabel = labelBold(text: "Basket Name",textSize: 20,textColor: .black)
      itemNameLabel.textAlignment = .left
      retailPriceLabel = labelBold(text: "N/A",textSize: 11,textColor: .link)
      mainVH.addSubview(retailPriceLabel)
      retailPriceLabel.anchor(top: nil, leading: itemImg.leadingAnchor, bottom: itemImg.bottomAnchor, trailing: itemImg.trailingAnchor,padding: UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8))
      addSubview(itemNameLabel)
      itemNameLabel.anchor(top: nil, leading: itemImg.trailingAnchor, bottom: nil, trailing: trailingAnchor,padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
      itemNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

}

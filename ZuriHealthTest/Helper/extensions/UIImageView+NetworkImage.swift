//
//  UIImageView+NetworkImage.swift
//  ZuriHealthTest
//
//  Created by ANTHONY NWUDO WEMABANK on 17/07/2022.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView{
    func setImage(with urlString: String, placeholder: Bool = true){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        var kf = self.kf
        
        if placeholder{
            self.kf.setImage(with: resource, placeholder:  #imageLiteral(resourceName: "dummy_image"))
        }else{
            self.kf.setImage(with: resource)
            kf.indicatorType = .activity
        }
        
    }
}

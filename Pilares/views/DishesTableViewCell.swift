//
//  DishesTableViewCell.swift
//  Pilares
//
//  Created by Mariano Bonilla on 16/10/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit
import Kingfisher


class DishesTableViewCell: UITableViewCell {

        
    @IBOutlet var imgDish: UIImageView!
    @IBOutlet var promoDish: UILabel!
    @IBOutlet var descDish: UILabel!
    @IBOutlet var priceDish: UILabel!
    
    
    func setupDish(aDish: Dish){
        
        if let thisImgDish = aDish.imgUrl {
            let url = URL(string: thisImgDish)
            imgDish.kf.setImage(with: url)
        }
        
        if let thisPromoDish = aDish.promo {
            promoDish.text = thisPromoDish
        }
        
        if let thisDescDish = aDish.description {
            descDish.text = thisDescDish
        }
        
        if let thisPriceDish = aDish.price {
            priceDish.text = String(format: "%.2f", thisPriceDish)
        }

        
    }


}

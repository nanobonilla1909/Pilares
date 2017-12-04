//
//  AddedDishTableViewCell.swift
//  Pilares
//
//  Created by Mariano Bonilla on 27/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class AddedDishTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imgAddedDish: UIImageView!
    @IBOutlet weak var lblAddedDishDescription: UILabel!
    @IBOutlet weak var lblAddedDishUnitPrice: UILabel!
    @IBOutlet weak var lblAddedDishQuantity: UILabel!
    @IBOutlet weak var lblAddedDishTotalPrice: UILabel!
//
//    var productId: Int?
//    var comments: String?
    
    func setupAddedDish(aOrderItem: OrderItem){
        
        var unitPrice: Double = 0
        var unitQty: Int = 0
        var totalPrice: Double = 0
        
        if let thisImgAddedDish = aOrderItem.productUrl {
            let url = URL(string: thisImgAddedDish)
            imgAddedDish.kf.setImage(with: url)
        }
        
        if let thisAddedDishDescription = aOrderItem.productDescription {
            lblAddedDishDescription.text = thisAddedDishDescription
        }
        
        
        if let thisAddedDishPrice = aOrderItem.productPrice {
            lblAddedDishUnitPrice.text = String(format: "%.2f", thisAddedDishPrice)
            unitPrice = thisAddedDishPrice
        }
        
        if let thisAddedDishQuantity = aOrderItem.quantity {
            lblAddedDishQuantity.text = String(thisAddedDishQuantity)
            unitQty = thisAddedDishQuantity
        }
        
        totalPrice = unitPrice * Double(unitQty)
        lblAddedDishTotalPrice.text = String(format: "%.2f", totalPrice)
        
        
    }

    
}

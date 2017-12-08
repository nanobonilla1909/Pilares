//
//  AddToCartViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 26/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class AddToCartViewController: UIViewController {

    @IBOutlet weak var imgDish: UIImageView!
    @IBOutlet weak var lblDishDescription: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var txtComments: UITextField!
    @IBOutlet weak var lblPrice: UILabel!
    
    var selectedDish: Dish?
    var aQty = 1
    
    @IBAction func btnSubstract(_ sender: UIButton) {
        
        if aQty > 0 {
            aQty -= 1
            lblQuantity.text = String(aQty)
        }
    }
    
    @IBAction func btnAdd(_ sender: UIButton) {
        aQty += 1
        lblQuantity.text = String(aQty)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        self.title = "Plato"
        
        if let thisImgDish = selectedDish?.imgUrl {
            let url = URL(string: thisImgDish)
            imgDish.kf.setImage(with: url)
        }
        
        
        if let thisDescDish = selectedDish?.description {
            lblDishDescription.text = thisDescDish
        }
        
        if let thisPriceDish = selectedDish?.price {
            lblPrice.text = "$ " + String(format: "%.2f", thisPriceDish)
        }
        
    }

    
    
    @IBAction func btnAddToOrder(_ sender: UIButton) {
        
        if aQty > 0 {
            if let aProductId = selectedDish?.id, let productDesciption = selectedDish?.description, let productPrice = selectedDish?.price, let productUrl = selectedDish?.imgUrl {
                
                var aComment: String = ""
                if txtComments.text != nil {
                    aComment = txtComments.text! // ATT
                }
                
                let mainOrder = OrderManager.getInstance()
                
                let aOrderItem = OrderItem(productId: aProductId, productDescription: productDesciption, productPrice: productPrice, productUrl: productUrl, quantity: Int(aQty), comments: aComment)
                
                mainOrder.addItem(newItem: aOrderItem)
                
                
            }
        }
        
    }
    

}

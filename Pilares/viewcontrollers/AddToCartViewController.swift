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

       
        if let thisImgDish = selectedDish?.imgUrl {
            let url = URL(string: thisImgDish)
            imgDish.kf.setImage(with: url)
        }
        
        
        if let thisDescDish = selectedDish?.description {
            lblDishDescription.text = thisDescDish
        }
        
        if let thisPriceDish = selectedDish?.price {
            lblPrice.text = "$ " + String(thisPriceDish)
        }
        
    }

    @IBAction func btnAddToOrder(_ sender: UIButton) {
    }
    

}

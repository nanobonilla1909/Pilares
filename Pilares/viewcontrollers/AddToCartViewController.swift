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

       
    }

   

}

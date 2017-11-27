//
//  Dishes2ViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 23/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class Dish2ViewController: UIViewController {

    
    @IBOutlet weak var lblCant: UILabel!
    
    var thisQuantity: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let managerCategoryList = CategoriesManager.getInstance()
        var mainCategoryList = managerCategoryList.getCategories()
        

        
    }

   
    @IBAction func minusQuantityTapped(_ sender: UIButton) {
        
        if thisQuantity > 0 {
            thisQuantity = thisQuantity - 1
            // lblQuantity.text = String(thisQuantity)
        }
        
    }
    
    
    @IBAction func addQuantityTapped(_ sender: UIButton) {
        
        thisQuantity = thisQuantity + 1
        // lblQuantity.text = String(thisQuantity)
        
    }
    
    
}

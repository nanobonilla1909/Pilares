//
//  OrderSubmittedViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 13/12/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class OrderSubmittedViewController: UIViewController {

    @IBOutlet weak var lblOrderNumber: UILabel!
    var strOrderId: String?
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let thisOrderId = strOrderId {
            lblOrderNumber.text = thisOrderId
        }
        
    }

    
    @IBAction func acceptTapped(_ sender: UIButton) {
        
//        var inStackVCs: Int = 0
//
//        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
//        inStackVCs = viewControllers.count
//        if inStackVCs > 2 {
//            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);
//        } else {
//            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
//        }
        
        dismiss(animated: true) {
            
        }
        
    }
    
    

}

//
//  OrderSubmittedViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 13/12/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class OrderSubmittedViewController: UIViewController {

    @IBOutlet weak var lblOrderName: UILabel!
    @IBOutlet weak var lblShiftDescription: UILabel!
    @IBOutlet weak var lblOrderNumber: UILabel!
    var strOrderId: String?
    var strShiftDescription: String?
    var strName: String?
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblOrderName.numberOfLines = 1
        lblOrderName.adjustsFontSizeToFitWidth = true
        lblOrderName.minimumScaleFactor = 0.1
        
        if let thisName = strName {
            lblOrderName.text = thisName
        } else {
            lblOrderName.text = "Error"
        }
        
        if let thisShift = strShiftDescription {
            lblShiftDescription.text = thisShift
        } else {
            lblShiftDescription.text = "Error"
        }
        
        if let thisOrderId = strOrderId {
            lblOrderNumber.text = thisOrderId
        } else {
            lblOrderNumber.text = "Error"
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

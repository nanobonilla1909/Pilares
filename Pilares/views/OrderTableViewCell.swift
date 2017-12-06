//
//  OrderTableViewCell.swift
//  Pilares
//
//  Created by Mariano Bonilla on 5/12/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var lblDateHour: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    
    func setup(aDate: String, aId:Int) -> Void {
        
        lblDateHour?.text = aDate
        lblOrderId.text = String(aId)
        
    }

}

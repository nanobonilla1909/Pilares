//
//  OptionTableViewCell.swift
//  Pilares
//
//  Created by Mariano Bonilla on 4/12/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblOption: UILabel!
    
    func setup(optionName: String) -> Void {
        lblOption?.text = optionName
        
    }
    

}

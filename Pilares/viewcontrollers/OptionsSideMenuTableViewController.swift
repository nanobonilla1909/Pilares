//
//  OptionsSideMenuTableViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 4/12/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class OptionsSideMenuTableViewController: UITableViewController {

    let options : [String] = ["Pedido Actual", "Pedidos a Retirar"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return options.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath)
        
        if let optionCell = cell as? OptionTableViewCell {
            
            optionCell.setup(optionName: options[indexPath.row])
            
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            performSegue(withIdentifier: "toOrderVC", sender: self)
            
        } else {
            
            if indexPath.row == 1 {

                performSegue(withIdentifier: "toOrdersList", sender: self)

            } else {

                

            }
        }
    }
    

}

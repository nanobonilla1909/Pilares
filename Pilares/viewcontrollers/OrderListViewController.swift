//
//  OrderListViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 5/12/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class OrderListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var arrOrders: [Order] = []
    var thisUserKey = "1|1|2|201711162055"
    
    @IBOutlet weak var ordersTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let orderService = OrdersService()
        orderService.getOrderListFromAPI(userKey: thisUserKey, termine: {
            ordersArray in
            
            self.arrOrders = ordersArray
            self.ordersTable.reloadData()
            
        })
        
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOrders.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath)
        
        if let orderCell = cell as? OrderTableViewCell {
            let aOrder = arrOrders[indexPath.row]
            if let aDateTime = aOrder.dateTime, let aId = aOrder.id {
                 orderCell.setup(aDate: aDateTime, aId: aId)
            }
           
        }
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            
            
            self.arrOrders.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
        }
    }
    

    
}

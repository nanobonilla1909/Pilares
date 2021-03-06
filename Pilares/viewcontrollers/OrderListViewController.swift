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
    var deleteConfirmation: Bool = false
    
    @IBOutlet weak var ordersTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let orderService = OrdersService()
        orderService.getOrderListFromAPI(termine: {
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
            
            if let orderToDelete = arrOrders[indexPath.row].id {
                
                
                let alert = UIAlertController(title: "Confirmación", message: "Estas seguro que querés eliminar el pedido?", preferredStyle: .alert)
                
                let DeleteAction = UIAlertAction(title: "Eliminar", style: .destructive, handler: { action in
                    
                    
                    let ordersService = OrdersService()
                    ordersService.deleteOrderWithAPI(idOrder: orderToDelete, termine: {
                        thisStatus in
                        
                        if thisStatus == "OK" {
                            self.arrOrders.remove(at: indexPath.row)
                            tableView.beginUpdates()
                            tableView.deleteRows(at: [indexPath], with: .automatic)
                            tableView.endUpdates()
                        }
                        
                        
                    })
                    
                  
                })
                
                let CancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: cancelDeletePlanet)
                
                alert.addAction(DeleteAction)
                alert.addAction(CancelAction)
                self.present(alert, animated: true, completion: nil)
               
            }
            
        }
    }
    

    
    func handleDeletePlanet(alertAction: UIAlertAction!) -> Void {
        deleteConfirmation = true
        
    }
    
    func cancelDeletePlanet(alertAction: UIAlertAction!) -> Void {
        deleteConfirmation = false
        
    }
    
}

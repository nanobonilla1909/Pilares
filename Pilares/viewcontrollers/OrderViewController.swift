//
//  OrderViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 27/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var lblTotal: UILabel!
    var orderItems: [OrderItem] = []
    var totalOrder: Double = 0
    var totalPriceByDish: Double = 0
    var totalItemToRemove: Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let mainOrder = OrderManager.getInstance()
        orderItems = mainOrder.getItems()
        for i in 0...orderItems.count-1 {
            if let aProductPrice = orderItems[i].productPrice, let aQuantity = orderItems[i].quantity {
                totalPriceByDish = aProductPrice * Double(aQuantity)
                totalOrder = totalOrder + totalPriceByDish
            }
            
        }
        
        lblTotal.text = String(format: "%.2f", totalOrder)
        let a = 1
        
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAddedDish", for: indexPath)
    
        if let addedDishCell = cell as? AddedDishTableViewCell {
            let addedDish = orderItems[indexPath.row]
            addedDishCell.setupAddedDish(aOrderItem: addedDish)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
         
            if editingStyle == .delete {
                
            }
            
            if let aTotalItemToRemove = orderItems[indexPath.row].productPrice, let aQuantity = orderItems[indexPath.row].quantity {
                 totalItemToRemove = aTotalItemToRemove * Double(aQuantity)
            }
           
            totalOrder = totalOrder - totalItemToRemove
            lblTotal.text = String(format: "%.2f", totalOrder)
            
            self.orderItems.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            
            let mainOrder = OrderManager.getInstance()
            mainOrder.deleteOneItem(index: indexPath.row)
            
            
     
        }
    }
    

    
    @IBAction func btnContinueBuying(_ sender: UIButton) {
        
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);
    }
    
    
    
    @IBAction func btnClerOrder(_ sender: Any) {
    
        let mainOrder = OrderManager.getInstance()
        mainOrder.deleteItems()
        orderItems = []
        totalOrder = 0
        lblTotal.text = String(format: "%.2f", totalOrder)
        
        orderTableView.reloadData()
        // Aca tengo que recargar la tabla!!!
        
    }
    
    
    @IBOutlet weak var btnSubmitOrder: UIButton!
    
    
    
    @IBAction func btnSubmitFinalOrder(_ sender: UIButton) {
        
        
        // Graba el Pedido
        
        let ordersService = OrdersService()
        ordersService.setOrderWithAPI(termine: {
            idOrder in
            
            print("en el form de submit order vino: " + idOrder)
        })
        
        
        
        
    }
    
    
}

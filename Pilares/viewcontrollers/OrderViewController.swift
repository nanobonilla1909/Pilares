//
//  OrderViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 27/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate {

     var yaGrabo : Bool = false
    
    @IBOutlet weak var pckShifts: UIPickerView!
    @IBOutlet weak var orderTableView: UITableView!
    @IBOutlet weak var lblTotal: UILabel!
    var orderItems: [OrderItem] = []
    var allShifts: [Shift] = []
    var totalOrder: Double = 0
    var totalPriceByDish: Double = 0
    var totalItemToRemove: Double = 0
    var orderName: String = ""
    var orderShift: String = ""
    var arrShiftsStr:[String] = []
    var arrShiftsId:[Int] = []
    var strSubmittedOrderId: String = ""
    var shiftSelected : Int = 0
    
    
    // Variables del PopUp View
    
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var centerPopUpConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblName: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Pedido"
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        // Rescata los horarios
        
        let mainShift = ShiftsManager.getInstance()
        allShifts = mainShift.getShifts()
        var txtShift: String = ""
        
        for aShift in allShifts {
            
            if let idShift = aShift.id, let nameShift = aShift.description {
                txtShift = nameShift
                arrShiftsStr.append(txtShift)
                arrShiftsId.append(idShift)
            }
            
        }
        
        
        let mainOrder = OrderManager.getInstance()
        orderItems = mainOrder.getItems()
        if orderItems.count > 0 {
            
            for i in 0...orderItems.count-1 {
                if let aProductPrice = orderItems[i].productPrice, let aQuantity = orderItems[i].quantity {
                    totalPriceByDish = aProductPrice * Double(aQuantity)
                    totalOrder = totalOrder + totalPriceByDish
                }
            }
        }
        
        lblTotal.text = String(format: "%.2f", totalOrder)
        
        
        
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
    

    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
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
        
        var inStackVCs: Int = 0
 
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        inStackVCs = viewControllers.count
        if inStackVCs > 2 {
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);
        } else {
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
        }
        
    }
    
    
    @IBAction func btnClerOrder(_ sender: Any) {
    
        if orderItems.count > 0 {
            
            let mainOrder = OrderManager.getInstance()
            mainOrder.resetOrder()
            
            orderItems = []
            totalOrder = 0
            lblTotal.text = String(format: "%.2f", totalOrder)
            
            orderTableView.reloadData()
            // Aca tengo que recargar la tabla!!!
            
        }
        
        
    }
    
    
    @IBOutlet weak var btnSubmitOrder: UIButton!
    
    
    
    @IBAction func btnSubmitFinalOrder(_ sender: UIButton) {
        
        if self.orderItems.count > 0 {
            
            let mainOrder = OrderManager.getInstance()
            let ordersService = OrdersService()
            ordersService.setOrderWithAPI(myOrder: mainOrder, termine: {
                idOrder in
                
                self.strSubmittedOrderId = idOrder
                print("adentro del closure:" + self.strSubmittedOrderId)
            
                mainOrder.resetOrder()
                self.totalOrder = 0
                self.yaGrabo = true
                self.performSegue(withIdentifier: "segueToOrderSubmitted", sender: nil)
                
            })
            
        }        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let orderIdDetailViewController = segue.destination as? OrderSubmittedViewController {
            let givenOrder = self.strSubmittedOrderId
            orderIdDetailViewController.strOrderId = givenOrder
            
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if yaGrabo {
            
            var inStackVCs: Int = 0
            
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
            inStackVCs = viewControllers.count
            if inStackVCs > 2 {
                self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);
            } else {
                self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
            }
            
            yaGrabo = false
            
        }
        
        
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return arrShiftsStr[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrShiftsStr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selectedShift = arrShiftsId[row]
        shiftSelected = row
        
    }
    

    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica Neue", size: 16)
        
        // where data is an Array of String
        label.text = arrShiftsStr[row]
        
        return label
    }
    
}

//
//  OrderViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 27/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var lblTotal: UILabel!
    var orderItems: [OrderItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mainOrder = OrderManager.getInstance()
        orderItems = mainOrder.getItems()
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
    
        return cell
    }
    
    @IBAction func btnContinueBuying(_ sender: UIButton) {
    }
    
    @IBAction func btnClerOrder(_ sender: Any) {
    
    }
    
    
    @IBOutlet weak var btnSubmitOrder: UIButton!
    
    @IBAction func btnSubmitFinalOrder(_ sender: UIButton) {
    }
    
    
}

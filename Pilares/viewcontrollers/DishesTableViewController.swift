//
//  DishesTableViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 16/10/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class DishesTableViewController: UITableViewController {

    var mainDishes: [Dish] = []
    var pruebaItems: [OrderItem] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Menues"
//        let mainOrder = OrderManager.getInstance()
//
//        let orderI1 = OrderItem(productId: 1, shiftId: 2, quantity: 23, comments: "sin sal")
//
//        mainOrder.addItem(newItem: orderI1)
//        pruebaItems = mainOrder.getItems()
//        print(pruebaItems[0].comments)
//
        
        let dishesService = DishesService()
        dishesService.getDishesFromAPI(termine: {
            dishesArray in
            
            self.mainDishes = dishesArray
            self.tableView.reloadData()
            
        })
           }

    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mainDishes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       

        let cell = tableView.dequeueReusableCell(withIdentifier: "dishCell", for: indexPath)
        
        if let dishCell = cell as? DishesTableViewCell {
            dishCell.setupDish(aDish: mainDishes[indexPath.row])
        }
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let dishDetailViewController = segue.destination as? AddToCartViewController, let indexPath = tableView.indexPathForSelectedRow {
            let selectedDish = mainDishes[indexPath.row]
            dishDetailViewController.selectedDish = selectedDish
        }
        
    }

}

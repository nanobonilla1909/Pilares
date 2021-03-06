//
//  DishesTableViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 16/10/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit
import SideMenu

class DishesTableViewController: UITableViewController {

    var mainDishes: [Dish] = []
    var pruebaItems: [OrderItem] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        
        SideMenuManager.menuWidth = view.frame.width * CGFloat(0.50)
        let menuPresentMode = SideMenuManager.MenuPresentMode.viewSlideInOut
        SideMenuManager.menuPresentMode = menuPresentMode
        
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackTranslucent
        
        self.navigationController?.navigationBar.barTintColor = UIColor.violet
        self.title = "Menues"
        
        
        let dishesService = DishesService()
        dishesService.getDishesFromAPI(termine: {
            dishesArray in
            
            self.mainDishes = dishesArray
            self.tableView.reloadData()
            
        })
    }

    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(false)
//        
//        print("----------------")
//        print("aca van los VCs")
//        print(Date())
//        print("----------------")
//        if let viewControllers = navigationController?.viewControllers {
//            print("Cantidad en el Stack: \(viewControllers.count)" )
//            for viewController in viewControllers {
//                print("Yo: ")
//                print(viewController.navigationItem)
//                print("Padre: ")
//                print(viewController.parent?.navigationItem)
//            }
//           
//        }
//    }
    
    

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

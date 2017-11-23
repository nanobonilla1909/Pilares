//
//  DishesServices.swift
//  Pilares
//
//  Created by Mariano Bonilla on 16/10/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import Foundation
import Alamofire

class DishesService {
    
    func getDishesFromAPI(termine: @escaping ([Dish])-> Void) -> Void {
        
        let dishDAO = DishesDAO()
        
        if let networkManager = NetworkReachabilityManager(), networkManager.isReachable {
            
            dishDAO.getDishesFromAPI(termine: { (dishesArray) in
                termine(dishesArray)
            })
            
        } else {
            
            let dishesArray:[Dish] = []
            termine(dishesArray)
            
        }
    }
}


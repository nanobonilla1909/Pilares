//
//  OrdersService.swift
//  Pilares
//
//  Created by Mariano Bonilla on 30/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import Foundation
import Alamofire


class OrdersService {
    
    
    func setOrderWithAPI(termine: @escaping (String)-> Void) -> Void {
        
        let ordersDAO = OrdersDAO()
        
        if let networkManager = NetworkReachabilityManager(), networkManager.isReachable {
            
            ordersDAO.setOrderWithAPI(termine: { (idOrder) in
                termine(idOrder)
            })
            
        } else {
            

            
        }
    }
}

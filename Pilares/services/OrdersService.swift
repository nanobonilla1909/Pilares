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
    
    
    func setOrderWithAPI(myOrder: OrderManager, termine: @escaping (String)-> Void) -> Void {
        
        let ordersDAO = OrdersDAO()
        
        if let networkManager = NetworkReachabilityManager(), networkManager.isReachable {
            
            ordersDAO.setOrderWithAPI(myOrder: myOrder, termine: { (idOrder) in
                termine(idOrder)
            })
            
        } else {
            

            
        }
    }
    
    
    func deleteOrderWithAPI(idOrder: Int, termine: @escaping (String)-> Void) -> Void {
        
        let ordersDAO = OrdersDAO()
        
        if let networkManager = NetworkReachabilityManager(), networkManager.isReachable {
            
            ordersDAO.deleteOrderWithAPI(idOrder: idOrder, termine: { (thisStatus) in
                termine(thisStatus)
            })
            
        } else {
            
        }
    }
    
    
    func getOrderListFromAPI(termine: @escaping ([Order])-> Void) -> Void {
        
        let ordersDAO = OrdersDAO()
        
        if let networkManager = NetworkReachabilityManager(), networkManager.isReachable {
            
            ordersDAO.getOrderListFromAPI(termine: { (ordersArray) in
                termine(ordersArray)
            })
            
        } else {
            
            let ordersArray:[Order] = []
            termine(ordersArray)
            
        }
    }
    
    
}

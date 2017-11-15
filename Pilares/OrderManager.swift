//
//  OrderManager.swift
//  Pilares
//
//  Created by Mariano Bonilla on 18/10/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import Foundation

public class OrderManager {
    
    private var items: [OrderItem] = []
    
    private init() {}
    

   private static var theInstance: OrderManager = OrderManager()

    
    static public func getInstance() -> OrderManager {
        return OrderManager.theInstance
    }
    
    
    public func addItem(newItem: OrderItem) {
        //crea order item
        // agregar order item a items
        self.items.append(newItem)
    }
    
    public func getItems() -> [OrderItem] {
        
        return self.items
        
    }
    
}

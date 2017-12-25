//
//  OrderManager.swift
//  Pilares
//
//  Created by Mariano Bonilla on 18/10/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import Foundation

public class OrderManager {
    

    public var name: String?
    public var shiftId: Shift?
    private var items: [OrderItem] = []
    
    private init() {}
    

   private static var theInstance: OrderManager = OrderManager()

    
    static public func getInstance() -> OrderManager {
        return OrderManager.theInstance
    }
    
    
    public func resetOrder() {
        
        self.name = nil
        self.shiftId = nil
        self.deleteItems()
        
    }
    
    public func addItem(newItem: OrderItem) {

        self.items.append(newItem)
    }
    
    public func getItems() -> [OrderItem] {
        
        return self.items
        
    }
    
    public func deleteItems() {
        
        self.items = []
        
        return
        
    }
    
    
    public func deleteOneItem(index: Int) {
        
        self.items.remove(at: index)
        
        return
        
    }
    
    public func setShift(thisShift: Shift) {
        
        self.shiftId = thisShift
        
    }
    
}

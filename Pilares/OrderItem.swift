//
//  OrderItem.swift
//  Pilares
//
//  Created by Mariano Bonilla on 17/10/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import Foundation

public class OrderItem {
    
    var productId: Int?
    var shiftId: Int?
    var quantity: Double?
    var comments: String?
    
    
    public init(productId: Int, shiftId: Int, quantity:Double, comments:String) {
        
        self.productId = productId
        self.shiftId = shiftId
        self.quantity = quantity
        self.comments = comments
    }
    
}

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
    var productDescription: String?
    var productPrice: Double?
    var productUrl: String?
    var quantity: Int?
    var comments: String?
    
    
    public init(productId: Int, productDescription: String, productPrice: Double, productUrl: String, quantity:Int, comments:String) {
        
        self.productId = productId
        self.productDescription = productDescription
        self.productPrice = productPrice
        self.productUrl = productUrl
        self.quantity = quantity
        self.comments = comments
    }
    
}

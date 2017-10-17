//
//  Dish.swift
//  Pilares
//
//  Created by Mariano Bonilla on 16/10/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import Foundation

public class Dish {
    
    var id: Int?
    var description: String?
    var price: Double?
    var promo: String?
    var imgUrl: String?
    
    public init(id: Int, description: String, price:Double, promo:String, imgUrl:String) {
        self.id = id
        self.description = description
        self.price = price
        self.promo = promo
        self.imgUrl = imgUrl
    }
    
}

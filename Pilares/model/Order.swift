//
//  Order.swift
//  Pilares
//
//  Created by Mariano Bonilla on 5/12/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import Foundation

public class Order {
    
    public var id: Int?
    public var dateTime: String?
        
    public init(id: Int, dateTime: String) {
        
        self.id = id
        self.dateTime = dateTime
        
    }

}


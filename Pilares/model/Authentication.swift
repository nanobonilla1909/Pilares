//
//  Authentication.swift
//  Pilares
//
//  Created by Mariano Bonilla on 23/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import Foundation

public class Authentication {
    
    var key: String?
    var shifts: [Shift]?
    var categories: [DishCategory]?
    
    public init(key: String) {
        self.key = key
    }
    
    public init(key: String, shifts: [Shift], categories:[DishCategory]) {
        self.key = key
        self.shifts = shifts
        self.categories = categories

    }
    
}

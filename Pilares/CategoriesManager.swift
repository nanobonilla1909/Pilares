//
//  CategoriesManager.swift
//  Pilares
//
//  Created by Mariano Bonilla on 23/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import Foundation

public class CategoriesManager {
    
    private var categories: [DishCategory] = []
    
    private init() {}
    
    
    private static var theInstance: CategoriesManager = CategoriesManager()
    
    
    static public func getInstance() -> CategoriesManager {
        return CategoriesManager.theInstance
    }
    
    
    public func addCategory(newItem: DishCategory) {
        
        self.categories.append(newItem)
    }
    
    public func getCategories() -> [DishCategory] {
        
        return self.categories
        
    }
    
}

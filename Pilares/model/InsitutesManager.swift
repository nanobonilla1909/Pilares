//
//  InsitutesManager.swift
//  Pilares
//
//  Created by Mariano Bonilla on 14/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import Foundation

public class InstitutesManager {
    
    private var institutes: [Institute] = []
    
    private init() {}
    
    
    private static var theInstance: InstitutesManager = InstitutesManager()
    
    
    static public func getInstance() -> InstitutesManager {
        return InstitutesManager.theInstance
    }
    
    
    public func addInstitute(newItem: Institute) {
        //crea order item
        // agregar order item a items
        self.institutes.append(newItem)
    }
    
    public func getInstitutes() -> [Institute] {
        
        return self.institutes
        
    }
    
}

//
//  File.swift
//  Pilares
//
//  Created by Mariano Bonilla on 23/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import Foundation

public class ShiftsManager {
    
    private var shifts: [Shift] = []
    
    private init() {}
    
    
    private static var theInstance: ShiftsManager = ShiftsManager()
    
    
    static public func getInstance() -> ShiftsManager {
        return ShiftsManager.theInstance
    }
    
    
    public func addShift(newItem: Shift) {
        
        self.shifts.append(newItem)
    }
    
    public func getShifts() -> [Shift] {
        
        return self.shifts
        
    }
    
}


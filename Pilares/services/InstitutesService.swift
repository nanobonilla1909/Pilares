//
//  InstitutesService.swift
//  Pilares
//
//  Created by Mariano Bonilla on 14/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import Foundation
import Alamofire

class InstitutesService {
    
    func getInstitutesFromAPI(termine: @escaping ([Institute])-> Void) -> Void {
        
        let institutesDAO = InstitutesDAO()
        
        if let networkManager = NetworkReachabilityManager(), networkManager.isReachable {
            
            institutesDAO.getInstitutesFromAPI(termine: { (institutesArray) in
                termine(institutesArray)
            })
            
        } else {
            
            let institutesArray:[Institute] = []
            termine(institutesArray)
        
        }
    }
}

//
//  UsersService.swift
//  Pilares
//
//  Created by Mariano Bonilla on 23/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import Foundation
import Alamofire

class UsersService {
    
    var dictAuthentication = [String:Any]()
    
    func getUserAuthFromAPI(aMail: String, aName: String, aInst: Int, termine: @escaping (Authentication?)-> Void) -> Void {
        
        let userAuthDAO = UsersDAO()
        
        if let networkManager = NetworkReachabilityManager(), networkManager.isReachable {
            
            userAuthDAO.getAuthenticationFromAPI(aMail: aMail, aName: aName, aInst: aInst, termine: { (thisAuth) in
                termine(thisAuth)
            })
            
        } else {
            
            // let dishesArray:[Dish] = []
            // termine(dictAuthentication)
            
        }
    }
}

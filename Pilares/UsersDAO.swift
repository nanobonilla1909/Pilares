//
//  UsersDAO.swift
//  Pilares
//
//  Created by Mariano Bonilla on 23/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import Foundation
import TTMVC
import Alamofire


class UsersDAO {
    
    func getAuthenticationFromAPI(termine: @escaping (Authentication)->Void) -> Void {
        
        
        let urltemp = "http://weminipocket.weoneconsulting.com/handlers/activacionGet.ashx?C=201711170943&U={'Correo':'mb2@yahoo.com','Nombre':'Mariano','IdInstitucion':1}"
.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        Alamofire.request(urltemp!).responseJSON(completionHandler: {
            myResponse in
            if let value = myResponse.value as? [String: AnyObject] {
                
                var arrAuth: [Authentication] = []
                
                if let dictData = value["data"] as? [String: AnyObject] {
                    
                    if let dictKey = dictData["KEY"] {
                        if let strKey = dictKey as? String {
                            let thisAuth = Authentication(key: strKey)
                            arrAuth.append(thisAuth)
                        }
                    }

                }
                
                termine(arrAuth[0])
            }
        })
        
    }
    
}

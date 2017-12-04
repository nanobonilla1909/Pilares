//
//  OrdersDAO.swift
//  Pilares
//
//  Created by Mariano Bonilla on 30/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import Foundation
import TTMVC
import Alamofire


class OrdersDAO {
    
    func setOrderWithAPI(termine: @escaping (String)->Void) -> Void {
        
        let thisUrl = "http://weminipocket.weoneconsulting.com/handlers/PedidosSet.ashx"
        
        var params : [String:Any] = [:]
        
        params["key"]="1|1|2|201711162051"
        params["H"] = "2"
        // params["P"] = "[{'IdMenu':1,'Precio':99,'Cantidad': 1,'Observacion': 'sin salsa'}]"
       
       
        Alamofire.request(thisUrl, method: .post, parameters: params).responseJSON(completionHandler: {
            myResponse in
            if let value = myResponse.value as? [String: AnyObject] {
                
                var idOrder: String = ""
               
                
                  if let dictData = value["Message"] as? [String: String] {

                    print(dictData["status"])
                    print(dictData["value"])
                    

                  }
                termine(idOrder)
            }
        })
        
    }
    
}


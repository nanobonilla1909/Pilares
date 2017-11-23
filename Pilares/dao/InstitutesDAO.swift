//
//  InstitutesDAO.swift
//  Pilares
//
//  Created by Mariano Bonilla on 14/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import Foundation
import TTMVC
import Alamofire


class InstitutesDAO {
    
    func getInstitutesFromAPI(termine: @escaping ([Institute])->Void) -> Void {
        
        let urltemp = "http://weminipocket.weoneconsulting.com/handlers/Institucionesget.ashx?key=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        Alamofire.request(urltemp!).responseJSON(completionHandler: {
            myResponse in
            if let value = myResponse.value as? [String: AnyObject] {
                
                var institutesArray: [Institute] = []
                var idInstitute: Int = 0
                var descriptionInstitute: String = ""
                
                if let arrayData = value["data"] as? [[String: AnyObject]] {
                    
                    for institutesDictionary in arrayData {
                        
                        if let idInst = institutesDictionary["IdInstitucion"] as? Int {
                            idInstitute = idInst
                        }
                        
                        if let descInst = institutesDictionary["Institucion"] as? String {
                            descriptionInstitute = descInst
                        }
                        
                        let aInstitute = Institute(instituteId: idInstitute, instituteName: descriptionInstitute)
                        
                        institutesArray.append(aInstitute)
                        
                    }
                    
                }
                termine(institutesArray)
            }
        })
        
    }
    
}

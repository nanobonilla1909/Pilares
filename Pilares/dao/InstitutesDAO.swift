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
    
    var handler:String = ""
    
    public init() {
        
        // Lee plist de parametros
        
        if let path = Bundle.main.path(forResource: "PilaresParam", ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            if let dict = dictRoot {
                self.handler = dict["handler"] as! String
            }
        }
    }
    
    func getInstitutesFromAPI(termine: @escaping ([Institute])->Void) -> Void {
        
        // asi funciona 7-12
        //        let urltemp = "http://weminipocket.weoneconsulting.com/handlers/Institucionesget.ashx?key=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        //
        var institutesArray: [Institute] = []
        
        var params: [String: Any] = [:]
        params["key"] = 1
        let urltemp = handler + "/Institucionesget.ashx"
        
            
        Alamofire.request(urltemp, parameters: params).responseJSON(completionHandler: {
                myResponse in
            
            print("----------------------------")
            print("Este es el Request")
            print("----------------------------")
            print("Request: \(String(describing: myResponse.request))")   // original url request
            print("----------------------------")
            print("Este es el Response")
            print("----------------------------")
            print("Response: \(String(describing: myResponse.response))") // http url response
            print("----------------------------")
            print("Este es el Result")
            print("----------------------------")
            print("Result: \(myResponse.result)")                         // response serialization result
            
            print("----------------------------")
            print("Este es el Value")
            print("----------------------------")
            print("Result: \(myResponse.value)")
            
            
            if let value = myResponse.value as? [String: AnyObject] {
                
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
                
            } else {
                institutesArray = []
               
            }
            termine(institutesArray)
        })
        
    }
    
}

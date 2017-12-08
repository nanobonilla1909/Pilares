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
    
    var concatDate: String = ""
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
    
    func getAuthenticationFromAPI(aMail: String, aName: String, aInst: Int, termine: @escaping (Authentication?)->Void) -> Void {
        
        var params: [String: String] = [:]
        var myU: String = ""
        
        params["C"] = getSystemDateInString()
        
        // params["U"] = "{'Correo':'mb2@yahoo.com','Nombre':'Mariano','IdInstitucion':1}" //
        myU = "{'Correo':'" + aMail
        myU = myU + "','Nombre':'" + aName
        myU = myU + "','IdInstitucion': \(aInst)}"
        
        params["U"] = myU
        
        let thisUrl = self.handler + "/activacionGet.ashx"
        
        Alamofire.request(thisUrl, parameters: params).responseJSON(completionHandler: {
        
            myResponse in
            if let value = myResponse.value as? [String: AnyObject] {
                
                
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
                
                
                var auth2 : Authentication?
                var arrCategories: [DishCategory] = []
                var arrShifts: [Shift] = []
                
                if let dictData = value["data"] as? [String: AnyObject] {
                    
                    // lee la clave de Autenticacion que retorna la API
                    if let dictKey = dictData["KEY"] {
                        if let strKey = dictKey as? String {
                            
                            if let dictCategories = dictData["Categorias"] as? [[String: AnyObject]] {
                                
                                let mainCategoryList = CategoriesManager.getInstance()
                                
                                for category in dictCategories {
                                    
                                    if let idCat = category["IdCategoria"] as? Int, let descCat = category["Categoria"] as? String {
                                        let aCategory = DishCategory(id: idCat, description: descCat)
                                        arrCategories.append(aCategory)
                                        mainCategoryList.addCategory(newItem: aCategory)
                                    }
                                    
                                }
                            }
                            
                            if let dictShifts = dictData["Horarios"] as? [[String: AnyObject]] {
                                
                                let mainShiftList = ShiftsManager.getInstance()
                                
                                for shift in dictShifts {
                                    
                                    if let idShift = shift["IdHorario"] as? Int, let descShift = shift["Horario"] as? String {
                                        let aShift = Shift(id: idShift, description: descShift)
                                        arrShifts.append(aShift)
                                        mainShiftList.addShift(newItem: aShift)
                                    
                                    }
                                    
                                }
                            }
                            
                            auth2 = Authentication(key: strKey, shifts: arrShifts, categories: arrCategories)
                            
                        }
                    }

                }
                
                termine(auth2)
            }
        })
        
    }
    
    func getSystemDateInString() -> String {
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        return String(year) + String(format:"%02d", month) + String(format:"%02d", day) + String(format:"%02d", hour) + String(format:"%02d", minutes)
        
        // ATT - Arreglar que cuando es entre 1 y 9 minutos no agerga el 0 adelante
        
    }
    
    
}

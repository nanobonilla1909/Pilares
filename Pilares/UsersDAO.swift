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
    
    
    func getAuthenticationFromAPI(termine: @escaping (Authentication)->Void) -> Void {
        
        var params: [String: String] = [:]
        
        concatDate =  getSystemDateInString()
        params["C"] = getSystemDateInString()
        params["U"] = "{'Correo':'mb2@yahoo.com','Nombre':'Mariano','IdInstitucion':1}"
        
        let thisUrl = "http://weminipocket.weoneconsulting.com/handlers/activacionGet.ashx"
        
       // esta anda
      let urltemp = "http://weminipocket.weoneconsulting.com/handlers/activacionGet.ashx?C=201711231604&U={'Correo':'mb2@yahoo.com','Nombre':'Mariano','IdInstitucion':1}".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
       
        // esta NO anda
       // let urltemp: String? = "http://weminipocket.weoneconsulting.com/handlers/activacionGet.ashx?C=" + concatDate + "U={'Correo':'mb2@yahoo.com','Nombre':'Mariano','IdInstitucion':1}".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        // esta NO anda (concatenando URLs)
        // let url1 = "http://weminipocket.weoneconsulting.com/handlers/activacionGet.ashx?C=" + concatDate + "U={'Correo':'mb2@yahoo.com','Nombre':'Mariano','IdInstitucion':1}"
        // let urltemp: String? = url1.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        // esta NO anda (sin el addingPercent)
        // let urltemp: String? = "http://weminipocket.weoneconsulting.com/handlers/activacionGet.ashx?C=" + concatDate + "U={'Correo':'mb2@yahoo.com','Nombre':'Mariano','IdInstitucion':1}"
        
        Alamofire.request(urltemp!).responseJSON(completionHandler: {
            myResponse in
            if let value = myResponse.value as? [String: AnyObject] {
                
                var arrAuth: [Authentication] = []
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
                            
                            
                            let thisAuth = Authentication(key: strKey, shifts: arrShifts, categories: arrCategories)
                            
                            
                            arrAuth.append(thisAuth)
                        }
                    }
                    
                    // lee las categorias y crea la instancia de CategoriesManager
                    
                    if let dictCategories = dictData["Categorias"] {
                        
                        
                            
                        
                    }
                    
                    

                }
                
                termine(arrAuth[0])
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
        
        return String(year) + String(month) + String(day) + String(hour) + String(minutes)
        
        
    }
    
    
}

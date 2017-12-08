//
//  DishesDAO.swift
//  Pilares
//
//  Created by Mariano Bonilla on 16/10/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import Foundation
import TTMVC
import Alamofire


class DishesDAO {
    
    var key: String = ""
    var handler:String = ""
    
    public init() {
        
        if let aKey = UserDefaults.standard.object(forKey: "authkey") as? String {
            self.key = aKey
        } else {
            self.key = "error"
        }
        
        if let path = Bundle.main.path(forResource: "PilaresParam", ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            if let dict = dictRoot {
                self.handler = dict["handler"] as! String
            } else {
                self.handler = "error"
            }
        }
    }
    
    
    func getDishesFromAPI(termine: @escaping ([Dish])->Void) -> Void {
        
        
        if self.handler != "error" && self.key != "error" {
            
            // Esta URL funciona
            //       let urltemp = "http://weminipocket.weoneconsulting.com/handlers/menuesget.ashx?key=69|2|1|201710111843".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            var params: [String: String] = [:]
            params["key"] = self.key
            
            let urltemp = self.handler + "/menuesget.ashx"
            
            
            Alamofire.request(urltemp, parameters: params).responseJSON(completionHandler: {
                myResponse in
                if let value = myResponse.value as? [String: AnyObject] {
                    
                    var dishesArray: [Dish] = []
                    var idDish: Int = 0
                    var promoDish: String = ""
                    var descriptionDish: String = ""
                    var priceDish: Double = 0
                    var urlDish: String = ""
                    
                    if let arrayData = value["data"] as? [[String: AnyObject]] {
                        
                        for dishesDictionary in arrayData {
                            
                            if let idMenu = dishesDictionary["IdMenu"] as? Int {
                                idDish = idMenu
                            }
                            if let price = dishesDictionary["Precio"] as? Double {
                                priceDish = price
                            }
                            if let promo = dishesDictionary["Promo"] as? String {
                                promoDish = promo
                            }
                            if let description = dishesDictionary["Descripcion"] as? String {
                                descriptionDish = description
                            }
                            if let aUrl = dishesDictionary["ImgFileName"] as? String {
                                urlDish = aUrl
                            }
                            
                            
                            let aDish = Dish(id: idDish, description: descriptionDish, price: priceDish, promo: promoDish, imgUrl: urlDish)
                            
                            dishesArray.append(aDish)
                            
                        }
                        
                    }
                    termine(dishesArray)
                }
            })

            
            
        }
        
       
    }

}

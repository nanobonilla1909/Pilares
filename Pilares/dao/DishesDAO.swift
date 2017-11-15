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
    
    
    func getDishesFromAPI(termine: @escaping ([Dish])->Void) -> Void {
        
       let urltemp = "http://weminipocket.weoneconsulting.com/handlers/menuesget.ashx?key=69|2|1|201710111843".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        Alamofire.request(urltemp!).responseJSON(completionHandler: {
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
                        
                        if let idMenu = dishesDictionary["idMenu"] as? Int {
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

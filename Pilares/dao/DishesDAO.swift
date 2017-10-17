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
        
        print("antes del Alamofire")
        Alamofire.request("http://ttsocial.herokuapp.com/webapi/timeline").responseJSON(completionHandler: {
            myResponse in
            if let value = myResponse.value as? [[String: AnyObject]] {
                print("entra al if final")
                var dishesArray: [Dish] = []
                for dishesDictionary in value {
//                    if let aDish = News(dictionary: newsDictionary) {
                        let aDish = Dish(id: 1, description: "sarasa", price: 20, promo: "PROMO DEL DIA", imgUrl: "")
                        dishesArray.append(aDish)
                    
                }
                termine(dishesArray)
            }
        })

    }

}

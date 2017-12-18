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
    
    
    
    func setOrderWithAPI(myOrder: OrderManager, termine: @escaping (String)->Void) -> Void {
        
        var myP: String = ""
        
        if self.handler != "error" && self.key != "error" {
            
            let orderItems = myOrder.getItems()
            for i in 0...orderItems.count-1 {
                
                var strThisProductId: String = ""
                var strThisPrice: String = ""
                var strThisQuantity: String = ""
                var aComment:String = ""
                
                if let thisProductId = orderItems[i].productId {
                    strThisProductId = "\(thisProductId)"
                }
                
                if let thisProductPrice = orderItems[i].productPrice {
                    strThisPrice = "\(thisProductPrice)"
                }
                
                if let thisQuantity = orderItems[i].quantity {
                    strThisQuantity = "\(thisQuantity)"
                }
                
                if strThisProductId != "" && strThisPrice != "" && strThisQuantity != "" {
                    
                    if i == 0 {
                        myP = myP + "["
                    } else {
                        myP = myP + ","
                    }
                    
                    myP = myP + "{'IdMenu':'" + strThisProductId
                    myP = myP + "','Precio':'" + strThisPrice
                    myP = myP + "','Cantidad':'" + strThisQuantity
                    if let thisComment = orderItems[i].comments {
                        aComment = thisComment
                    }
                    myP = myP + "','Observacion':'" + aComment + "'}"
                    
                    if i == orderItems.count-1 {
                        myP = myP + "]"
                    }
                    
                }
            }
            
            var params: [String: Any] = [:]
            
            params["key"] = self.key
            params["H"] = "2" // ATT Cambiar x el horario real
            params["P"] = myP
            
            let thisUrl = self.handler + "/PedidosSet.ashx"
                
                
            Alamofire.request(thisUrl, parameters: params).responseJSON(completionHandler: {
                response in
                if let value = response.value as? [String: AnyObject] {
                    
                    if let json = response.result.value {
                        print("JSON: \(json)") // serialized json response
                    }
                    
                    if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                        print("Data: \(utf8Text)") // original server data as UTF8 string
                    }
                    
                    var idOrder: String = ""
                    
                    if let dictData = value["Message"] as? [String: String] {
                        
                        if let theStatus = dictData["status"] {
                            if theStatus != "OK" {
                                idOrder = "ERROR"
                            } else {
                                if let theOrder = dictData["value"]{
                                    idOrder = theOrder
                                }
                            }
                        }
                    }
                    termine(idOrder)
                }
            })
        }
    }
    
    
    func getOrderListFromAPI(termine: @escaping ([Order])->Void) -> Void {
        
        var params: [String: Any] = [:]
        params["key"] = self.key
        
        let thisUrl = self.handler + "/PedidosGet.ashx"
        
        Alamofire.request(thisUrl, parameters: params).responseJSON(completionHandler: {
            myResponse in
            if let value = myResponse.value as? [String: AnyObject] {
                
                var ordersArray: [Order] = []
                var idOrder: Int = 0
                var dateOrder: String = ""
                
                if let arrayData = value["data"] as? [[String: AnyObject]] {
                    
                    for ordersDictionary in arrayData {
                        
                        if let myOrderId = ordersDictionary["Numero"] as? Int {
                            idOrder = myOrderId
                        }
                        
                        if let myOrderDate = ordersDictionary["Fecha"] as? String {
                            dateOrder = myOrderDate
                        }
                        
                        let aOrder = Order(id: idOrder, dateTime: dateOrder)
                        
                        ordersArray.append(aOrder)
                        
                    }
                    
                }
                termine(ordersArray)
            }
        })
        
    }
    
    
    func deleteOrderWithAPI(idOrder: Int, termine: @escaping (String)->Void) -> Void {
        
        var params: [String: Any] = [:]
        
        params["key"] = self.key
        params["P"] = idOrder
 
        let thisUrl = self.handler + "/PedidosAnularSet.ashx"
        
        Alamofire.request(thisUrl, parameters: params).responseJSON(completionHandler: {
            myResponse in
            if let value = myResponse.value as? [String: AnyObject] {
                
                var thisStatus: String = ""
                
                if let dictData = value["Message"] as? [String: String] {
                    
                    if let aStatus = dictData["status"] {
                        thisStatus = aStatus
                    }
                }
                
                termine(thisStatus)
            }
        })
        
    }
    
}


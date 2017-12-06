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
    
    func setOrderWithAPI(myOrder: OrderManager, termine: @escaping (String)->Void) -> Void {
        
        let orderItems = myOrder.getItems()
        for i in 0...orderItems.count-1 {
            print(orderItems[i].productDescription)
            print(orderItems[i].productPrice)
            print(orderItems[i].quantity)
            
        }
        
        
        let miMenu1 = 1
        let miPrecio1 = 99
        let miCant1: Int = 1
        let miComment1 = "sin mayonesa"
        
        let myP = "[{'IdMenu':'" + String(miMenu1) + "','Precio':'" + String(miPrecio1) + "','Cantidad':'" + String(miCant1) + "','Observacion':'" + miComment1 + "'}]"
        print(myP)
        
        
        var params: [String: Any] = [:]
        
        params["key"] = "1|1|2|201711162055"
        params["H"] = "2"
        params["P"] = "[{'IdMenu':'1','Precio':'99','Cantidad':'1', 'Observacion':'sin mayonesa'}, {'IdMenu':'2','Precio':'66','Cantidad':'2', 'Observacion':'sin lechuga'}]"
        
        
        
        params["P"] = myP
        
        let thisUrl = "http://weminipocket.weoneconsulting.com/handlers/PedidosSet.ashx"
       
       
        Alamofire.request(thisUrl, parameters: params).responseJSON(completionHandler: {
            response in
            if let value = response.value as? [String: AnyObject] {
                
                print("----------------------------")
                print("Este es el Request")
                print("----------------------------")
                print("Request: \(String(describing: response.request))")   // original url request
                print("----------------------------")
                print("Este es el Response")
                print("----------------------------")
                print("Response: \(String(describing: response.response))") // http url response
                print("----------------------------")
                print("Este es el Result")
                print("----------------------------")
                print("Result: \(response.result)")                         // response serialization result
                
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
    
    
    func getOrderListFromAPI(userKey: String, termine: @escaping ([Order])->Void) -> Void {
        
        var params: [String: Any] = [:]
        params["key"] = userKey
        
        let thisUrl = "http://weminipocket.weoneconsulting.com/handlers/PedidosGet.ashx"
        
        // let urltemp = "http://weminipocket.weoneconsulting.com/handlers/Institucionesget.ashx?key=1".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
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
    
}


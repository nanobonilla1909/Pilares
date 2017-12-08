//
//  PruebaViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 22/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myActivityIndicator.startAnimating()
        
//     ATT
//        
//        // Lee plist de parametros
//        
//        if let path = Bundle.main.path(forResource: "PilaresParam", ofType: "plist") {
//            let dictRoot = NSDictionary(contentsOfFile: path)
//            if let dict = dictRoot {
//                debugPrint(dict["handler"] as! String)
//            }
//        }
        
        // Carga los Institutos y solo cuando termino paso a la pantalla de Login
        
        let institutesService = InstitutesService()
        institutesService.getInstitutesFromAPI(termine: {
            institutesArray in
            
            //ATT Esta harcodeado para agregar solo dos institutos
            let mainInstituteList = InstitutesManager.getInstance()
            let Inst01 = institutesArray[0]
            let Inst02 = institutesArray[1]
            mainInstituteList.addInstitute(newItem: Inst01)
            mainInstituteList.addInstitute(newItem: Inst02)
            
            // ATT - Borrar
//            if let email = UserDefaults.standard.object(forKey: "email") as? String {
//                print("Mail Inicial:" + email)
//            }
//
//            if let aName = UserDefaults.standard.object(forKey: "name") as? String {
//
//                print("Nombre Inicial:" + aName)
//            }
//
//            if let aInst = UserDefaults.standard.object(forKey: "institute") as? Int {
//                print("Inst Inicial:" + String(aInst))
//            }
//
//            if let aAuth = UserDefaults.standard.object(forKey: "authkey") as? String {
//                print("Auth Inicial:" + aAuth)
//            }
//
            
            
            if UserDefaults.standard.object(forKey: "authkey") == nil {
            
                self.performSegue(withIdentifier: "toLogin", sender: self)
            
            } else {
                
                self.performSegue(withIdentifier: "toLogged", sender: self)
                
            }
        })
        
        
    }

    
}

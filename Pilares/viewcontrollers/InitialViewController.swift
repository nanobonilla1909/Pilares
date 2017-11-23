//
//  PruebaViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 22/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Lee plist de parametros
        
        if let path = Bundle.main.path(forResource: "PilaresParam", ofType: "plist") {
            let dictRoot = NSDictionary(contentsOfFile: path)
            if let dict = dictRoot {
                debugPrint(dict["handler"] as! String)
            }
        }
        
        // Carga los Institutos
        
        let institutesService = InstitutesService()
        institutesService.getInstitutesFromAPI(termine: {
            institutesArray in
            
            //ATT Esta harcodeado para agregar solo dos institutos
            let mainInstituteList = InstitutesManager.getInstance()
            let Inst01 = institutesArray[0]
            let Inst02 = institutesArray[1]
            mainInstituteList.addInstitute(newItem: Inst01)
            mainInstituteList.addInstitute(newItem: Inst02)
            
            
            if let email = UserDefaults.standard.object(forKey: "email"), let name = UserDefaults.standard.object(forKey: "name") {
            
                self.performSegue(withIdentifier: "toLogged", sender: self)
            
            } else {
                
                self.performSegue(withIdentifier: "toLogin", sender: self)
                
            }
        })
        
        
    }

    
}

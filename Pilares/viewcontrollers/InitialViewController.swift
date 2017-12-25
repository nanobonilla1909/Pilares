//
//  PruebaViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 22/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    
    @IBOutlet weak var lblMessages: UILabel!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myActivityIndicator.startAnimating()
        
        
        // Carga los Institutos y solo cuando termino paso a la pantalla de Login
        
        
        
        let institutesService = InstitutesService()
        institutesService.getInstitutesFromAPI(termine: {
            institutesArray in
            
            if institutesArray.count > 0 {
            
                let mainInstituteList = InstitutesManager.getInstance()

                for aInstitue in institutesArray {
                    mainInstituteList.addInstitute(newItem: aInstitue)
                }
            
            
                if UserDefaults.standard.object(forKey: "authkey") == nil {
                
                    self.performSegue(withIdentifier: "toLogin", sender: self)
                
                } else {
                    
                    
                    // Ejecuta la Autenticacion
                    
                    if let thisKey = UserDefaults.standard.object(forKey: "authkey") as? String {
                        
                        let authService = UsersService()
                        authService.getConfigurationFromAPI(aKey: thisKey, termine: {
                            auth in
                            
                            if let auth2 = auth {
                                    
                                self.performSegue(withIdentifier: "segueToMenues", sender: self)
                                
                                // self.setShiftsAndCategories(thisAuth: auth2)
                                // ATT  self.performSegue(withIdentifier: "segueToNavigation", sender: self)
                               
                            } else {
                                
                               self.lblMessages.text = "Falla de conexión ..."
                            }
                            
                        })
                        
                        // self.performSegue(withIdentifier: "toLogged", sender: self)
                        
                    }
                    
                }
            } else {
                 self.lblMessages.text = "Falla de conexión ..."
            }
        })
        
        
    }
    
    


}

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
            
            
            if UserDefaults.standard.object(forKey: "authkey") == nil {
            
                self.performSegue(withIdentifier: "toLogin", sender: self)
            
            } else {
                
                
                // Ejecuta la Autenticacion
                
                if let thisKey = UserDefaults.standard.object(forKey: "authkey") as? String {
                    
                    let authService = UsersService()
                    authService.getConfigurationFromAPI(aKey: thisKey, termine: {
                        auth in
                        
                        if let auth2 = auth {
                            
                            self.setShiftsAndCategories(thisAuth: auth2)
                            // ATT  self.performSegue(withIdentifier: "segueToNavigation", sender: self)
                            self.performSegue(withIdentifier: "toLogged", sender: self)
                            
                            
                        } else {
                            
                           // ATT Catchear el error
                        }
                        
                    })
                    
                    // self.performSegue(withIdentifier: "toLogged", sender: self)
                    
                }
                
            }
        })
        
        
    }
    
    
    func setShiftsAndCategories (thisAuth: Authentication) {
        
        let mainShiftList = ShiftsManager.getInstance()
        if let theseShifts = thisAuth.shifts {
            for aShift in theseShifts {
                mainShiftList.addShift(newItem: aShift)
            }
        }
    }


}

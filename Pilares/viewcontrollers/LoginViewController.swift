//
//  SchoolSelectionViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 15/10/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

   
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtEmailConf: UITextField!
    @IBOutlet weak var txtName: UITextField!
    
    @IBOutlet weak var lblSelectedSchool: UILabel!
    @IBOutlet weak var pckSchool: UIPickerView!
    @IBOutlet weak var lblMessages: UILabel!
    
    
    var arrInstitutesStr:[String] = []
    var arrInstitutesId:[Int] = []
    
    var instituteIdSelected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblMessages.isHidden = true
        let managerInstituteList = InstitutesManager.getInstance()
        var mainInstituteList = managerInstituteList.getInstitutes()
        
        
        if let email = UserDefaults.standard.object(forKey: "email") as? String {
            txtEmail.text = email
        }
        
        if let aName = UserDefaults.standard.object(forKey: "name") as? String {
            
            txtName.text = aName
        }
        
        
        var txtInst: String = ""
        for aInstitute in mainInstituteList {
            
            if let idInst = aInstitute.instituteId, let nameInst = aInstitute.instituteName {
                txtInst = String(idInst) + " - " + nameInst
                arrInstitutesStr.append(txtInst)
                arrInstitutesId.append(idInst)
            }
            
        }

        
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
  
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return arrInstitutesStr[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrInstitutesStr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        lblSelectedSchool.text = arrInstitutesStr[row]
        instituteIdSelected = arrInstitutesId[row]
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // Ejecuta la Autenticacion
        
        let authService = UsersService()
        if let inputMail = self.txtEmail.text, let inputMailConf = self.txtEmailConf.text, let inputName = self.txtName.text {
            
            if inputMail != "" && inputMailConf != "" && inputName != "" && instituteIdSelected != 0 {
                
                if inputMail == inputMailConf {
                    
                    authService.getUserAuthFromAPI(aMail: inputMail, aName: inputName, aInst: instituteIdSelected, termine: {
                        auth in
                        
                        if let auth2 = auth {
                            
                            UserDefaults.standard.set(self.txtEmail.text, forKey: "email")
                            UserDefaults.standard.set(self.txtName.text, forKey: "name")
                            UserDefaults.standard.set(self.instituteIdSelected, forKey: "institute")
                            if let strKey = auth2.key {
                                UserDefaults.standard.set(strKey, forKey: "authkey")
                            }
                            self.setShiftsAndCategories(thisAuth: auth2)
                            self.performSegue(withIdentifier: "segueToNavigation", sender: self)
                        } else {
                            
                            self.lblMessages.isHidden = false
                            self.lblMessages.text = "Datos de Login Incorrectos"
                        }
                        
                    })
                    
                } else {
                    self.lblMessages.isHidden = false
                    self.lblMessages.text = "Los dos mails deben ser Iguales"
                }
                
            } else {
                self.lblMessages.isHidden = false
                self.lblMessages.text = "complete todos los campos"
            }
            
        }
        
    }
    
    
    func setShiftsAndCategories (thisAuth: Authentication) {
        
        let mainShiftList = ShiftsManager.getInstance()
        if let theseShifts = thisAuth.shifts {
            for aShift in theseShifts {
                mainShiftList.addShift(newItem: aShift)
            }
        }
    }
   
        //ATT copiar codigo de InitialVC

}

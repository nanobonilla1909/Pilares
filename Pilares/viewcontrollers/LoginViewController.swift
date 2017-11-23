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
    
    
    var arrInstitutesStr:[String] = []
    var arrInstitutesId:[Int] = []
    
    var instituteIdSelected: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        authService.getUserAuthFromAPI(termine: {
            auth in
            
            print(auth.key)
            
            UserDefaults.standard.set(self.txtEmail.text, forKey: "email")
            UserDefaults.standard.set(self.txtName.text, forKey: "name")
            UserDefaults.standard.set(self.instituteIdSelected, forKey: "institute")
            UserDefaults.standard.set(auth.key, forKey: "authkey")
            
            self.performSegue(withIdentifier: "segueToNavigation", sender: self)
            
        })
        
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
// ATT
//        if let email = UserDefaults.standard.object(forKey: "email") as? String {
//            lblEmail.text = email
//        }
//        
//        if let aName = UserDefaults.standard.object(forKey: "name") as? String {
//            lblName.text = aName
//        }

        
    }
    

}

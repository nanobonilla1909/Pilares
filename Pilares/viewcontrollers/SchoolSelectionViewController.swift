//
//  SchoolSelectionViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 15/10/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class SchoolSelectionViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet var lblSelectedSchool: UILabel!
    @IBOutlet var pckSchool: UIPickerView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblEmail: UILabel!
    
    
    
    
    var dictSchools: [Int: String] = [1:"Argentina School", 2: "San Gabriel", 3:"Lomas de Nuñez"]
    var arrSchools:[String] = []
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let mainInstituteList = InstitutesManager.getInstance()
        var pruebaInst = mainInstituteList.getInstitutes()
        print(pruebaInst[0].instituteName)
        print(pruebaInst[1].instituteName)
        
        
        if let email = UserDefaults.standard.object(forKey: "email") as? String {
            lblEmail.text = email
        }
        
        if let aName = UserDefaults.standard.object(forKey: "name") as? String {
            
            lblName.text = aName
        }
        
        for school in dictSchools {
            let txtSchool = String(school.key) + " - " + school.value
            arrSchools.append(txtSchool)
        }
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
  
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return arrSchools[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrSchools.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        lblSelectedSchool.text = arrSchools[row]
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

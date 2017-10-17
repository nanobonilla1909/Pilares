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
    
    
    
    // let schools = ["1. Argentina School", "2. San Gabriel", "3. Lomas de Nuñez"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  LogueadoViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 22/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class LogueadoViewController: UIViewController {

    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMail: UILabel!
    @IBOutlet weak var lblInst: UILabel!
    
    @IBAction func deleteUserDef(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "name")
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "institute")
        defaults.removeObject(forKey: "authkey")

        if let email = UserDefaults.standard.object(forKey: "email") as? String {
            print("email: " + email)
        } else {
            print("No existe email en UserDefault")
        }
        
        if let aName = UserDefaults.standard.object(forKey: "name") as? String {
            
             print("name: " + aName)
        } else {
            print("No existe Name en UserDefault")
        }
        
        if let aInst = UserDefaults.standard.object(forKey: "institute") as? Int {
             print("email: " + String(aInst))
        } else {
            print("No existe Insitute en UserDefault")
        }
        
        if let aKey = UserDefaults.standard.object(forKey: "authKey") as? Int {
            print("KEY: " + String(aKey))
        } else {
            print("No existe KEY en UserDefault")
        }
        
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let email = UserDefaults.standard.object(forKey: "email") as? String {
            lblName.text = email
        }
        
        if let aName = UserDefaults.standard.object(forKey: "name") as? String {
            
            lblMail.text = aName
        }
        
        if let aInst = UserDefaults.standard.object(forKey: "institute") as? Int {
            lblInst.text = String(aInst)
        }
        
    }

  
}

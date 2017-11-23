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

  
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

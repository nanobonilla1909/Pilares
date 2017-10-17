//
//  LoginViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 15/10/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var inputEmail: UITextField!
    @IBOutlet weak var inputName: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let email = UserDefaults.standard.object(forKey: "email") as? String {
            inputEmail.text = email
        }
        
        if let aName = UserDefaults.standard.object(forKey: "name") as? String {
            
            inputName.text = aName
        }

    }

    
    @IBAction func btnLoginTapped(_ sender: UIButton) {
        
        UserDefaults.standard.set(inputEmail.text, forKey: "email")
        UserDefaults.standard.set(inputName.text, forKey: "name")
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

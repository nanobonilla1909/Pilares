//
//  AddToCartViewController.swift
//  Pilares
//
//  Created by Mariano Bonilla on 26/11/17.
//  Copyright © 2017 Mariano Bonilla. All rights reserved.
//

import UIKit

class AddToCartViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var imgDish: UIImageView!
    @IBOutlet weak var lblDishDescription: UILabel!
    @IBOutlet weak var lblQuantity: UILabel!
    @IBOutlet weak var txtComments: UITextField!
    @IBOutlet weak var lblPrice: UILabel!
    
    var selectedDish: Dish?
    var aQty = 1
    
    @IBAction func btnSubstract(_ sender: UIButton) {
        
        if aQty > 1 {
            aQty -= 1
            lblQuantity.text = String(aQty)
        }
    }
    
    @IBAction func btnAdd(_ sender: UIButton) {
        
        if aQty <= 5 {
            aQty += 1
            lblQuantity.text = String(aQty)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.white
        // self.title = "Pilares"
        
        if let thisImgDish = selectedDish?.imgUrl {
            let url = URL(string: thisImgDish)
            imgDish.kf.setImage(with: url)
        }
        
        
        if let thisDescDish = selectedDish?.description {
            lblDishDescription.text = thisDescDish
        }
        
        if let thisPriceDish = selectedDish?.price {
            lblPrice.text = "$ " + String(format: "%.2f", thisPriceDish)
        }
        
        // esto es para poder usar la funcion textfield
        self.txtComments.delegate = self
        
        
        
        // Para permitir bajar el teclado cuando tapee en la pantalla
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
//        view.addGestureRecognizer(tap)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddToCartViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddToCartViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @IBAction func btnAddToOrder(_ sender: UIButton) {
        
        if aQty > 0 {
            if let aProductId = selectedDish?.id, let productDesciption = selectedDish?.description, let productPrice = selectedDish?.price, let productUrl = selectedDish?.imgUrl {
                
                var aComment: String = ""
                if txtComments.text != nil {
                    aComment = txtComments.text! // ATT
                }
                
                
                let mainOrder = OrderManager.getInstance()
                
                let aOrderItem = OrderItem(productId: aProductId, productDescription: productDesciption, productPrice: productPrice, productUrl: productUrl, quantity: Int(aQty), comments: aComment)
                
                mainOrder.addItem(newItem: aOrderItem)
                
                
            }
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        // let newLength = text.characters.count + string.characters.count - range.length
        let newLength = text.count + string.count - range.length
        return newLength <= 60
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
}

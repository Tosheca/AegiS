//
//  RegisterViewController.swift
//  AegiS
//
//  Created by Zhilber Baev on 3/6/20.
//  Copyright © 2020 Zhilber Baev. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var registerView: UIView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var surnameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var backToLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        registerView.clipsToBounds = true
        registerView.layer.cornerRadius = 10
        registerView.backgroundColor = UIColor.white.withAlphaComponent(0.98)
        
        registerButton.clipsToBounds = true
        registerButton.layer.cornerRadius = 10
        
        backToLoginButton.clipsToBounds = true
        backToLoginButton.layer.cornerRadius = 10
    }
    
    @IBAction func register(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, err) in
            if err != nil {
                print("Error in creating user")
            }
            else {
                print("Successfully created user")
                
                let db = Firestore.firestore()
                db.collection("users").addDocument(data: ["firstName": self.firstNameTextField.text!, "surname": self.surnameTextField.text!, "email": self.emailTextField.text!]) { (error) in
                    
                    if error != nil {
                        
                    }
                    else {
                        
                    }
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

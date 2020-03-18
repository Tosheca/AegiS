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

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var registerView: UIView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var surnameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var backToLoginButton: UIButton!
    
    @IBOutlet weak var firstNameMark: UIImageView!
    @IBOutlet weak var surnameMark: UIImageView!
    @IBOutlet weak var emailMark: UIImageView!
    @IBOutlet weak var passwordMark: UIImageView!
    @IBOutlet weak var confirmPassMark: UIImageView!
    @IBOutlet weak var passwordInfoMark: UILabel!
    @IBOutlet weak var passwordInfoLine: UIView!
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
        
        emailTextField.textContentType = .emailAddress
        
        firstNameTextField.delegate = self
        surnameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        passwordInfoMark.isEnabled = false
    }
    
    @IBAction func register(_ sender: Any) {
        
        if firstNameTextField.text != "" && surnameTextField.text != "" && emailTextField.text != "" && passwordTextField.text != "" && confirmPasswordTextField.text != "" {
        
            if passwordTextField.text == confirmPasswordTextField.text {
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (result, err) in
                    if err != nil {
                        print("Error in creating user")
                        print("Error \(err.debugDescription)")
                        if err?.localizedDescription == "The email address is badly formatted." {
                            self.emailMark.isHidden = false
                        }
                        else if err?.localizedDescription == "The password must be 6 characters long or more." {
                            self.passwordMark.isHidden = false
                            self.confirmPassMark.isHidden = false
                            self.passwordInfoMark.isHidden = false
                            self.passwordInfoLine.isHidden = false
                        }
                    }
                    else {
                        print("Successfully created user")
                        
                        let db = Firestore.firestore()
                        db.collection("users").addDocument(data: ["firstName": self.firstNameTextField.text!, "surname": self.surnameTextField.text!, "email": self.emailTextField.text!]) { (error) in
                            
                            if error != nil {
                                
                            }
                            else {
                                self.performSegue(withIdentifier: "backToLogin", sender: nil)
                            }
                        }
                    }
                }
            }
            else {
                print("Passwords doesn't match")
                passwordMark.isHidden = false
                confirmPassMark.isHidden = false
            }
        }
        else {
            if passwordTextField.text != confirmPasswordTextField.text {
                print("Passwords doesn't match")
                passwordMark.isHidden = false
                confirmPassMark.isHidden = false
            }
            if firstNameTextField.text == "" {
                firstNameMark.isHidden = false
            }
            if surnameTextField.text == "" {
                surnameMark.isHidden = false
            }
            if emailTextField.text == "" {
                emailMark.isHidden = false
            }
            if passwordTextField.text == "" {
                passwordMark.isHidden = false
            }
            if confirmPasswordTextField.text == "" {
                confirmPassMark.isHidden = false
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        firstNameMark.isHidden = true
        surnameMark.isHidden = true
        emailMark.isHidden = true
        passwordMark.isHidden = true
        confirmPassMark.isHidden = true
        passwordInfoMark.isHidden = true
        passwordInfoLine.isHidden = true
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

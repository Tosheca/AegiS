//
//  ViewController.swift
//  AegiS
//
//  Created by Teodor Pavlov on 3/5/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleBackground: UIView!
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var emailMark: UIImageView!
    
    @IBOutlet weak var passwordMark: UIImageView!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.overrideUserInterfaceStyle = .light

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        self.view.addGestureRecognizer(tap)
        
        loginView.clipsToBounds = true
        loginView.layer.cornerRadius = 10
        loginView.backgroundColor = UIColor.white.withAlphaComponent(0.98)
        
        titleBackground.clipsToBounds = true
        titleBackground.layer.cornerRadius = 10
        
        loginBtn.clipsToBounds = true
        loginBtn.layer.cornerRadius = 10
        
        registerBtn.clipsToBounds = true
        registerBtn.layer.cornerRadius = 10
        
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }

    @IBAction func login(_ sender: Any) {
        if usernameTextField.text != "" && passwordTextField.text != "" {
            
            Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!) { (result, error) in
                if error != nil {
                    print("wrong user")
                    //Error
                    self.emailMark.isHidden = false
                    self.passwordMark.isHidden = false
                }
                else {
                    print("logged in successfully")
                    
                    let dispGroup = DispatchGroup()
                    var rmID = 0
                    let ref = Database.database().reference()
                    
                    dispGroup.enter()
                    ref.child("managers").child("\(Auth.auth().currentUser!.uid)").observeSingleEvent(of: .value, with: {(snapshot) in
                        let fetchedData = snapshot.value as! [String: AnyObject]
                        
                        rmID = fetchedData["ID"] as! Int
                        print("login RM ID: \(fetchedData["ID"] as! Int)")
                        UserDefaults.standard.setValue(rmID, forKey: "rmID")
                        dispGroup.leave()
                    })
                    
                    dispGroup.notify(queue: .main, execute: {
                        let mainTabBarView = MainTabBarViewController()
                        let nc = UINavigationController(rootViewController: mainTabBarView)
                        nc.modalPresentationStyle = .fullScreen
                        nc.view.backgroundColor = .white
                        self.present(nc, animated: true, completion: nil)
                    })
                }
                
            }
            
        }
        else {
            //Error
            emailMark.isHidden = false
            passwordMark.isHidden = false
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        emailMark.isHidden = true
        passwordMark.isHidden = true
    }
    
    @IBAction func goToRegister(_ sender: Any) {
        
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        let alertView = UIAlertController(title: "Forgot Password", message: "Enter your email", preferredStyle: .alert)
        
        alertView.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Email"
        })
        
        alertView.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {(action) in
            
        }))
        
        alertView.addAction(UIAlertAction(title: "Send email", style: .default, handler: {(action) in
            let email = alertView.textFields![0].text!
            
            print(email)
            
            Auth.auth().sendPasswordReset(withEmail: email, completion: {error in
                if error != nil {
                    print(error!)
                }
                else {
                    
                }
            })
        }))
        
        self.present(alertView, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}


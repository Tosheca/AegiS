//
//  ViewController.swift
//  AegiS
//
//  Created by Teodor Pavlov on 3/5/20.
//  Copyright © 2020 Teodor Pavlov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleBackground: UIView!
    
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
    }

    @IBAction func login(_ sender: Any) {
        if usernameTextField.text != "" && passwordTextField.text != "" {
            
            
        }
        else {
            //Error
        }
    }
    
    @IBAction func register(_ sender: Any) {
        
    }
    
    
    
    
    
    
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}


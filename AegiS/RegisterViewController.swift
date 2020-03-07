//
//  RegisterViewController.swift
//  AegiS
//
//  Created by Zhilber Baev on 3/6/20.
//  Copyright © 2020 Zhilber Baev. All rights reserved.
//

import UIKit

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

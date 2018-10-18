//
//  ViewController.swift
//  Tutor+
//
//  Created by MacOS-1.14 on 10/15/18.
//  Copyright © 2018 JunyiZhao. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase
class LoginViewController: UIViewController, GIDSignInUIDelegate{
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        // GIDSignIn.sharedInstance().signIn()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }
    
    
    @IBAction func SignInButtonOnClicked(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password){(user, error) in
                
                if error != nil{
                    debugHelpPrint(type: ClassType.LoginViewController, str: error.debugDescription)
                }else{
                    debugHelpPrint(type: ClassType.LoginViewController, str: "Signed In")
                }
            }
        }
    }
    
}

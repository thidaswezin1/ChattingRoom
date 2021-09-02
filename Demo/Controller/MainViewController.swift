//
//  ViewController.swift
//  Demo
//
//  Created by ISGM on 24/08/2021.
//  Copyright © 2021 thida. All rights reserved.
//

import UIKit
import CLTypingLabel
import FirebaseAuth

class MainViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var titleLabel: CLTypingLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Chatting Room"
        // Do any additional setup after loading the view.
    }


    @IBAction func btnLogin(_ sender: UIButton) {
        
        if let email = txtEmail.text, let password = txtPassword.text {
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.performSegue(withIdentifier: K.loginSegue, sender: self)
                }
             
            }
        }
        
    }
    
}


//
//  RegisterViewController.swift
//  Demo
//
//  Created by ISGM on 29/08/2021.
//  Copyright © 2021 thida. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = email.text, let password = password.text {
                   Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                       
                       if let e = error {
                           print(e.localizedDescription)
                       } else {
                        self.performSegue(withIdentifier: K.registerSegue, sender: self)
                       }
                    
                   }
               }
    }
}

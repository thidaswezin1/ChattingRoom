//
//  ChatViewController.swift
//  Demo
//
//  Created by ISGM on 01/09/2021.
//  Copyright © 2021 thida. All rights reserved.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chatting Room"
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
    
        do {
          try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
            
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
}

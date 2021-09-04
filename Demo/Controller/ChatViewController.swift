//
//  ChatViewController.swift
//  Demo
//
//  Created by ISGM on 01/09/2021.
//  Copyright © 2021 thida. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var message : [Message] = []
    let db = Firestore.firestore()

    @IBOutlet weak var messageTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Chatting Room"
        navigationItem.hidesBackButton = true
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: K.nibName, bundle: nil), forCellReuseIdentifier: K.reuseableCell)
        
        loadMessages()
        
    }
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
    
        do {
          try Auth.auth().signOut()
            navigationController?.popViewController(animated: true)
            
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
           
            db.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField : messageSender, K.FStore.bodyField : messageBody, K.FStore.dateField : Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    print("Error in saving document in firestore\(e)")
                } else {
                    print("Successfully saved document.")
                }
            }
        }
    }
    
    func loadMessages() {
       
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener{ (querySnapshot, error ) in
            self.message = []
            if let e = error {
                print(e)
            } else {
                if let snapshotDocuments = querySnapshot?.documents {
                    for docu in snapshotDocuments {
                        let data = docu.data()
                        if let messageSender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String  {
                            let newMessage = Message(sender: messageSender, message: messageBody)
                            self.message.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
}

extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reuseableCell, for: indexPath) as! MessageCell
        
        cell.label.text = message[indexPath.row].message
        return cell
    }
    
    
}

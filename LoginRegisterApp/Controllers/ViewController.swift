//
//  ViewController.swift
//  LoginRegisterApp
//
//  Created by Акбала Тлеугалиева on 4/18/22.
//  Copyright © 2022 Akbala Tleugaliyeva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserData()
        // Do any additional setup after loading the view.
    }

    @IBAction func signOutButtonDidTapped(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
             let viewcontroller = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
                      viewcontroller?.modalPresentationStyle = .fullScreen
                      self.present(viewcontroller!, animated: true, completion: nil)
        }catch let error {
            print("Failed to  signout", error)
        }
    }

    func loadUserData(){
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        Database.database().reference().child("users").child(uid).child("username").observeSingleEvent(of: .value){
            (snapshot) in
            guard let username = snapshot.value as? String else {
                return
            }
            self.usernameLabel.text = username
        }
    }
    
}


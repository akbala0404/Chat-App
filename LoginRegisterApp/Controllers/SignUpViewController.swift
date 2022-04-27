//
//  SignUpViewController.swift
//  LoginRegisterApp
//
//  Created by Акбала Тлеугалиева on 4/18/22.
//  Copyright © 2022 Akbala Tleugaliyeva. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var passwordTextFiel: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()

        // Do any additional setup after loading the view.
    }
    func configureViews() {
            signUpButton.layer.cornerRadius = 12.0
        }

    @IBAction func SignUpButtonDidTapped(_ sender: UIButton) {
        if emailTextField.text?.isEmpty == true{
            errorLabel.text = "Invalid input"
            print("Invalid input")
            return
        }
        if passwordTextFiel.text?.isEmpty == true{
            errorLabel.text = "Invalid input"
            print("Invalid input")
            return
        }
        if nameTextField.text?.isEmpty == true{
            errorLabel.text = "Invalid input"
            print("Invalid input")
            return
        }
        SingUp(withEmail: emailTextField.text!, passwordTextFiel.text!, nameTextField.text! )

    }
    func SingUp(withEmail email: String, _ password: String, _ username: String){
        Auth.auth().createUser(withEmail : email , password: password) { (result,error ) in
            if let error = error {
                self.errorLabel.text = "Invalid input, \(error.localizedDescription)"

                print("Failed to sign ip", error.localizedDescription)
                return
            }
            guard let uid = result?.user.uid else {
                return
            }
            let values = ["email": email, "username": username]
            Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock:{(error, ref) in
                if let error = error {
                    self.errorLabel.text = "Invalid input, \(error.localizedDescription)"

                    print("Failed to update database", error.localizedDescription)
                    return
                }
                self.startApp()
            })
            
            
        }
        
    }
    
    @IBAction func SignInDidTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let SignInVC = storyboard
            .instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        SignInVC.modalPresentationStyle = .overFullScreen
        present(SignInVC, animated: true, completion: nil)
    }
    
    func startApp() {
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(identifier: "ViewController") as! ViewController
                            vc.modalPresentationStyle = .overFullScreen
                     self.present(vc, animated: true, completion: nil)
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

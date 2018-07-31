//
//  SignUpViewController.swift
//  Emily
//
//  Created by popCorn on 2018/07/29.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    //sign up text field
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupButton.layer.cornerRadius = 12.0
        // Do any additional setup after loading the view.
        let hideKeyboard = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        view.addGestureRecognizer(hideKeyboard)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
      //add user in auth firebase
            Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
                if error == nil && user != nil {
                    self.performSegue(withIdentifier: "toListBook", sender: self)
                    self.emailField.text = ""
                    self.passwordField.text = ""
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(alertAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            } 
    }
    //tap view to hide keyboard
    @objc func endEdit() {
        view.endEditing(true)
    }
    
    

   

}

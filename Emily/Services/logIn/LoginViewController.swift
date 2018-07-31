//
//  LoginViewController.swift
//  Emily
//
//  Created by popCorn on 2018/07/30.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 12.0
        // Do any additional setup after loading the view.
        let hideKeyboard = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        view.addGestureRecognizer(hideKeyboard)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if  Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "toListFromSignin", sender: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
            if error == nil && user != nil {
                self.performSegue(withIdentifier: "toListFromSignin", sender: self)
                self.emailField.text = ""
                self.passwordField.text = ""
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let alertDefault = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(alertDefault)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    // function tap view to hide keyboard
    @objc func endEdit() {
        view.endEditing(true)
    }

    @IBAction func anonymousUserMode(_ sender: Any) {
        //log in with anonymous func
        Auth.auth().signInAnonymously { (user, error) in
            if error == nil && user != nil {
                self.performSegue(withIdentifier: "toListFromSignin", sender: self)
                
                print(user)
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(alertAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
   

}

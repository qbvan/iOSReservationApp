//
//  EmailViewController.swift
//  Emily
//
//  Created by popCorn on 2018/07/01.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit
import MessageUI

class EmailViewController: UIViewController, UITextViewDelegate, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBOutlet weak var messageField: UITextView!
    
    @IBOutlet weak var button: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.layer.cornerRadius = 5.0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if  text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
    
    
    @IBAction func sendEmail(_ sender: Any) {
        if let mc: MFMailComposeViewController = MFMailComposeViewController() {
            mc.mailComposeDelegate = self
            let recipients = ["123@gmail.com"]
            mc.setToRecipients(recipients)
            mc.setSubject(nameField.text! + "")
            mc.setMessageBody("""
                Name: \(nameField.text!)
                Email: \(emailField.text!)
                Message: \(messageField.text!)
                """, isHTML: false)
            self.present(mc, animated: true, completion: nil)
        }
       
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    

}

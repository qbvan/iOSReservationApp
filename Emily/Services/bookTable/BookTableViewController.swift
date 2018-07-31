//
//  BookTableViewController.swift
//  Emily
//
//  Created by popCorn on 2018/07/10.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit
import FirebaseDatabase
import UserNotifications

class BookTableViewController: UIViewController, UITextFieldDelegate {
    // reference of database firebase
    var ref: DatabaseReference!
    
 
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var minusOne: UIButton!
    @IBOutlet weak var plusOne: UIButton!
    
    @IBOutlet weak var peopleValue: UILabel!
    
    @IBOutlet weak var pickDateButton: UIButton!
    
    
    @IBOutlet weak var bookNumber: UITextField!
    @IBOutlet weak var bookName: UITextField!
    //book the table info
    
    
    @IBOutlet weak var sendButton: UIButton!
    
    
    @IBOutlet weak var dateDataShow: UIDatePicker!
    
    // display data value change
    
    @IBOutlet weak var dateValueDisplay: UILabel!
    
    var peopleNum = 2
    var dateShow = false
    override func viewDidLoad() {
        super.viewDidLoad()
        //load database
        ref = Database.database().reference()
        //
        bookName.delegate = self
        
        //
        peopleValue.text = "\(peopleNum) people"
        minusOne.isEnabled = false
        minusOne.layer.opacity = 0.5
        sendButton.layer.cornerRadius = 15.0
        dateShow = false
        dateDataShow.isHidden = true
        dateDataShow.setValue(UIColor.white, forKey: "textColor")
        sendButton.isHidden = false
        minusOne.layer.cornerRadius = 5.0
        plusOne.layer.cornerRadius = 5.0
        pickDateButton.layer.cornerRadius = 5.0
        //set UIText field color
        //check empty
      
        // tap anywhere in view to hide keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    @IBAction func plusPeople(_ sender: Any) {
        peopleNum += 1
        peopleValue.text = "\(peopleNum) people"
        if peopleNum >= 10 {
            plusOne.isEnabled = false
            plusOne.layer.opacity = 0.5
            minusOne.isEnabled = true
            minusOne.layer.opacity = 1
        } else {
            minusOne.isEnabled = true
            minusOne.layer.opacity = 1
            plusOne.isEnabled = true
            plusOne.layer.opacity = 1
        }
    }
    
    @IBAction func minusPeople(_ sender: Any) {
        peopleNum -= 1
        peopleValue.text = "\(peopleNum) people "
        if peopleNum <= 2 {
            minusOne.isEnabled = false
            minusOne.layer.opacity = 0.5
            plusOne.isEnabled = true
            plusOne.layer.opacity = 1
        } else {
            minusOne.isEnabled = true
            minusOne.layer.opacity = 1
            plusOne.isEnabled = true
            plusOne.layer.opacity = 1
        }
    }
    
    
    @IBAction func pickButtonClicked(_ sender: Any) {
        if dateShow == true {
            dateDataShow.isHidden = true
            sendButton.isHidden = false
            pickDateButton.setTitle("Pick", for: .normal)
            pickDateButton.tag = 2
            dateShow = false
        } else {
            dateDataShow.isHidden = false
            sendButton.isHidden = true
            pickDateButton.setTitle("Get", for: .normal)
            pickDateButton.tag = 1
            dateShow = true
        }
    }
    
    @IBAction func getDateButtonClicked(_ sender: Any) {
        if pickDateButton.tag == 2
        {
            dateValueDisplay.text = "please choose date below"
        }
    }
    
    @IBAction func dateChangeS(_ sender: Any) {
        let datePicker = UIDatePicker()
        dateDataShow.datePickerMode = .dateAndTime
        //handle picker mode for date show
        dateDataShow.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateValueDisplay.text =  dateFormatter.string(from: sender.date)
    }
    
    
    
    @IBAction func sendAlert(_ sender: Any) {
        //send data to Firebase
        ref?.child("bookTable").childByAutoId().setValue("\(bookNumber.text ?? "no on else") and \(bookName.text ?? "name not found")" + "\(dateValueDisplay.text ?? "not found")" + "\(peopleValue.text ?? "not found")")
        createAlert(title: "Emily Restaurant", message: "Your reservation has been confirmed")
        createLocalNotifi()
    }
    
    
    
    func createLocalNotifi() {
        //create notifications after user send a request to book the table
        let content = UNMutableNotificationContent()
        
        //adding title, subtitle, body and badge
        content.title = "Emily Restaurant"
        content.subtitle = "Thank you for choosing our services"
        content.body = "We love our customers, and we think you'll love us too."
        content.badge = 1
        
        //getting the notification trigger
        //it will be called after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        //getting the notification request
        let request = UNNotificationRequest(identifier: "SimplifiedIOSNotification", content: content, trigger: trigger)
        
        //adding the notification to notification center
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    //alert function
    func createAlert(title: String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.mainTitle.text = "ありがとうございます"
            self.mainTitle.textColor = UIColor.white
            self.sendButton.isEnabled = false
            self.plusOne.isEnabled = false
            self.minusOne.isEnabled = false
            self.pickDateButton.isEnabled = false
            self.bookName.text = ""
            self.bookNumber.text = ""
            //set opacity
            self.minusOne.layer.opacity = 0.7
            self.plusOne.layer.opacity = 0.7
            self.pickDateButton.layer.opacity = 0.7
            self.sendButton.layer.opacity = 0.7
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //hide keyboard function
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    

}

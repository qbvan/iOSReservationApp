//
//  WriteNewCommentViewController.swift
//  Emily
//
//  Created by popCorn on 2018/07/25.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class WriteNewCommentViewController: UIViewController {
    var imagePicker: UIImagePickerController!
    var takenImage: UIImage!
    var currentDate: Date!
    
    @IBOutlet weak var tapToExit: UIView!
    var ref: DatabaseReference!
    
    @IBOutlet weak var imageViewComment: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var jobField: UITextField!
    @IBOutlet weak var commentField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewComment.image = UIImage(named: "avt2")
        imageViewComment.layer.cornerRadius = imageViewComment.frame.width / 2
        imageViewComment.clipsToBounds = true
        
        //taprecognizer function
        let tapView = UITapGestureRecognizer(target: self, action: #selector(hideView))
        tapToExit.addGestureRecognizer(tapView)
        let hideKeyboard = UITapGestureRecognizer(target: self, action: #selector(endEdit))
        view.addGestureRecognizer(hideKeyboard)
    }
    
    @objc func hideView() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func endEdit() {
        view.endEditing(true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //click image profile to choose user profile
    
    @IBAction func addProfileImage(_ sender: Any) {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        //check if camera is vailable to shoot image
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = .photo
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func writeCommentButton(_ sender: Any) {
        let cmtName = nameField.text
        let cmtJob = jobField.text
        let cmtComment = commentField.text
        ref = Database.database().reference()
        let key = ref.childByAutoId().key
   
        let commentArray = [
            "id": key,
            "name": cmtName!,
            "job": cmtJob!,
            "content": cmtComment!,
            "postDate": ServerValue.timestamp(),
            "avatar": "url!"
            ] as [String : Any]
        self.ref.child("Comments").child(key).setValue(commentArray)
        dismiss(animated: true, completion: nil)
    }
 
}
extension WriteNewCommentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //selected image in 2 type; original image and edited image
        var selectedImageFromPicker: UIImage?
        if let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage?  {
            selectedImageFromPicker = originalImage
        } else if let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage? {
            selectedImageFromPicker = editedImage
        }
        if let img = selectedImageFromPicker {
            self.takenImage = img
            self.imageViewComment.image = takenImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    //upload image function return url to asign value for avatarString;
    func uploadProfileImage(completion: @escaping (_ url: String?) -> Void ) {
        //save image to storage firebase
        //can create upload image function from here
        let storageRef = Storage.storage().reference().child("comment-avatar").child("\(Date().timeIntervalSince1970)avatar.jpeg")
        if let uploadAvatar = UIImageJPEGRepresentation(self.takenImage!, 0.3) {
            storageRef.putData(uploadAvatar, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error!)
                    completion(nil)
                } else {
                    storageRef.downloadURL(completion: { (url, error) in
                        if error != nil {
                            print(error!)
                        }
                        completion(url?.absoluteString)
                    })
                }
                
            }
          
        }
    }
}






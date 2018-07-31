//
//  ServicesViewController.swift
//  Emily
//
//  Created by popCorn on 2018/06/30.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseStorage
//import SDWebImage

class ServicesViewController: UIViewController {
    @IBOutlet weak var commentScrollViewController: UICollectionView!
    
    //image picker
    var imagePicker: UIImagePickerController!
    var takenImage: UIImage!
    var currentHeaderImage: UIImage!
    
    @IBOutlet weak var stack3: UIStackView!
    @IBOutlet weak var stack2: UIStackView!
    @IBOutlet weak var stack1: UIStackView!
    @IBOutlet weak var serviceTitle: UILabel!
    @IBOutlet weak var serviceTitle1: UILabel!
    @IBOutlet weak var imageServiceHeaders: UIImageView!
    @IBOutlet weak var servicesScrollView: UIScrollView!
    @IBOutlet weak var pickImageHeader: UIButton!
    
    var ref: DatabaseReference!
    //fetching comment data
    var listCommentArray = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        servicesScrollView.delegate = self
        commentScrollViewController.delegate = self
        commentScrollViewController.dataSource = self
        //get image from firebase database
        ref?.child("serviceHeaderImages").observe(.childAdded, with: { (snapshot) in
            //retrieve url image from firebase and display in view
            if let imageFromFB = snapshot.value as? [String: Any] {
                let getImg = imageFromFB["url"] as? String
                if let url =  URL(string: getImg!) {
                    do {
                        let data  = try  Data(contentsOf: url)
                        self.imageServiceHeaders.image = UIImage(data: data)
                    } catch let error {
                        print("error: \(error.localizedDescription)")
                    }
                }
            }
        })
        //fetching data from firebase database
        ref?.child("Comments").queryOrdered(byChild: "postDate").observe(.childAdded, with: {(snapshot) in
            if let comment = snapshot.value as? [String: Any] {
                //get data from snapshot and insert an array
                let id = comment["id"] as? String
                let name = comment["name"] as? String
                let job = comment["job"] as? String
                let content = comment["content"] as? String
                let avatar = comment["avatar"] as? String
                let postDate = comment["postDate"] as? String
                //create an array has include all element and append to Comment list
                let allComment = Comment(id: id, name: name, job: job, content: content, avatar: avatar, postDate: postDate)
//                self.listCommentArray.append(allComment)
                self.listCommentArray.insert(allComment, at: 0)
            }
            self.commentScrollViewController.reloadData()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // show event popUp
    
    //add new service header image
    
    
    @IBAction func getServiceHeaderImage(_ sender: Any) {
        //user photoLibary or camera to change header image in service view
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        //check if the source camera is available
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.cameraCaptureMode = .photo
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        self.present(imagePicker, animated: true, completion: nil)
    }
    
}
extension ServicesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listCommentArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as! CommentCollectionViewCell
        cell.layer.cornerRadius = 14
        cell.layer.shadowOpacity = 0.25
        cell.layer.shadowRadius = 20
        let comment = listCommentArray[indexPath.row]
        cell.commentName.text = comment.name
        cell.commentContent.text = comment.content
        cell.commentJob.text = comment.job
        cell.commentAvatar.image = #imageLiteral(resourceName: "avt1")
        
        return cell
    }
}
extension ServicesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //if the image was choose
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage? {
             selectedImageFromPicker = editedImage
        } else if let image = info[UIImagePickerControllerOriginalImage] as! UIImage? {
             selectedImageFromPicker = image
        }
        if let imagePicker = selectedImageFromPicker  {
            self.takenImage = imagePicker
            self.imageServiceHeaders.image = takenImage
        }
        //storage to save image to firebase
        let storageRef = Storage.storage().reference().child("service-Header").child("serviceHeaderImages.jpeg")
        if let uploadImage = UIImageJPEGRepresentation(self.takenImage!, 0.5) {
            storageRef.putData(uploadImage, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print(error!)
                    return
                }
                storageRef.downloadURL(completion: { (url, error) in
                    if error != nil {
                        print(error!)
                    }
                    let downloadURL  = url!
                    //insert downloadURL string into firebase realtime and display in our view
                    let keyImage = self.ref.childByAutoId().key
                    let imageUrl = ["url": downloadURL.absoluteString]
                    let headerImageChild = ["\(keyImage)": imageUrl]
                    //insert URL to realtime database
                self.ref?.child("serviceHeaderImages").setValue(headerImageChild)
                })
                })
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //else. cancel button was click
    @objc func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //create function to save header image to firebase database
}
//add animation for service view controller
extension ServicesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            imageServiceHeaders.transform = CGAffineTransform(translationX: 0, y: offsetY)
            
//            pickImageHeader.transform = CGAffineTransform(translationX: 0, y: -offsetY / 30)
            pickImageHeader.isHidden = true
            serviceTitle.transform = CGAffineTransform(translationX: 0, y: -offsetY / 5)
            serviceTitle1.transform = CGAffineTransform(translationX: 0, y: -offsetY / 5)
            stack1.transform = CGAffineTransform(translationX: 0, y: -offsetY / 2)
            stack2.transform = CGAffineTransform(translationX: 0, y: -offsetY / 3)
            stack3.transform = CGAffineTransform(translationX: 0, y: -offsetY / 4)
        } else {
            pickImageHeader.isHidden = false
        }
    }
}








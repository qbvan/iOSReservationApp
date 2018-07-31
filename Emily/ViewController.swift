//
//  ViewController.swift
//  Emily
//
//  Created by popCorn on 2018/06/30.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var blurTitle: UIVisualEffectView!
    @IBOutlet weak var emilyTitle: UILabel!
    
    @IBOutlet weak var adTitleChange: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
  
    // stop scroll image in middle
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
       
    }
    @IBOutlet weak var backgroundImage: UIImageView!
    var backgroundArray = ["top1", "top2", "top3", "top4", "top5", "top6"]
   // var slideBackgroundArray = ["slide1", "slide2", "slide3", "slide4", "slide5", "slide6", "slide7"]
    var adTitle = ["get free cupon 20%", "free drink for lunch", "get 50% free meal for family", "new season foods"]
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //user notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (didAllow, error) in
            if error != nil {
                print(error)
            }
        }
        // add blur effect 
        backgroundImage.layer.borderWidth = 7.0
        blurTitle.layer.cornerRadius = 15.0
        emilyTitle.layer.cornerRadius = 5.0
        adTitleChange.layer.shadowColor = UIColor.black.cgColor
        adTitleChange.layer.shadowOpacity = 0.7
        adTitleChange.layer.shadowOffset = CGSize.zero
        adTitleChange.layer.shadowRadius = 5
        backgroundImage.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5).cgColor
        scrollView.delegate = self
        runTime()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func runTime() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: (#selector(updateBackgroundImage)), userInfo: nil, repeats: true)
    }
    
    @objc func updateBackgroundImage() {
        backgroundImage.alpha = 0.4
        backgroundImage.transform = CGAffineTransform(scaleX: 1,y: 1)
        
        UIView.animate(withDuration: 0.8) {
            // add self before : -> in () {} bla bla
            self.backgroundImage.alpha = 1
            
            self.emilyTitle.textColor =  self.getRandomColor()
//            self.backgroundImage.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            // get random picture
            let randomPic = Int(arc4random_uniform(UInt32(self.backgroundArray.count)))
            self.backgroundImage.image = UIImage(named: self.backgroundArray[randomPic])
            //random text array
            let textRandom = Int(arc4random_uniform(UInt32(self.adTitle.count)))
            self.adTitleChange.text = String(self.adTitle[textRandom]).uppercased()
        }
    }
    //get random color for title
    func getRandomColor() -> UIColor {
        let randomRed: CGFloat = CGFloat(arc4random_uniform(UInt32(255.0)))
        let randomGreen: CGFloat = CGFloat(arc4random_uniform(UInt32(255.0)))
        let randomBlue: CGFloat = CGFloat(arc4random_uniform(UInt32(255.0)))
        
        return UIColor(red: randomRed/255.0, green: randomGreen/255.0, blue: randomBlue/255.0, alpha: 1)
    }
 
}

//get static data from another file using delegate -datasource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // horizontal slider
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SlideCell", for: indexPath) as! SlideCollectionViewCell
        let section = sections[indexPath.row]
        cell.titleCell.text = section["title"]
        cell.titleCell.layer.shadowColor = UIColor.black.cgColor
        cell.titleCell.layer.shadowOpacity = 1
        cell.titleCell.layer.shadowOffset = CGSize.zero
        cell.titleCell.layer.shadowRadius = 10
        cell.layer.cornerRadius = 15.0
        
        
        cell.descriptionCell.text = section["description"]
        cell.descriptionCell.layer.shadowColor = UIColor.black.cgColor
        cell.descriptionCell.layer.shadowOpacity = 1
        cell.descriptionCell.layer.shadowOffset = CGSize.zero
        cell.descriptionCell.layer.shadowRadius = 10
        
        cell.imageCellSlide.image = UIImage(named: section["image"]!)
        
        return cell
    }
}

//another way extention can be use UIScrollviewdelegate to provide extra functionalities to an existing class
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if  offsetY < 0 {
            //the Y position is alway negative
            backgroundImage.transform = CGAffineTransform(translationX: 0, y: offsetY)
            adTitleChange.transform = CGAffineTransform(translationX: -offsetY, y: offsetY)
            blurTitle.transform = CGAffineTransform(translationX: 0, y: -offsetY/7)
            emilyTitle.transform = CGAffineTransform(translationX: 0, y: -offsetY/7)
        }
        
        if let collectionView = scrollView as? UICollectionView {
            for cell in collectionView.visibleCells as! [SlideCollectionViewCell] {
                // get item (index position)
                let indexPath = collectionView.indexPath(for: cell)!
                // get attribute of the item in visible view cell
                let attributes = collectionView.layoutAttributesForItem(at: indexPath)!
                let cellFrame = collectionView.convert(attributes.frame, to: view)
                
                let translationX  = cellFrame.origin.x / 10
                
                cell.imageCellSlide.transform = CGAffineTransform(translationX: translationX, y: 0)
                
                cell.layer.transform = animateCell(cellFrame: cellFrame)
                
            }
        }
    }
    //3d transition
    func animateCell(cellFrame: CGRect) -> CATransform3D {
        //angle x axis
        let angleFromX = Double((-cellFrame.origin.x) / 10)
        let angle = CGFloat((angleFromX * Double.pi) / 180.0)
        //bien doi goc
        var transform =  CATransform3DIdentity
        transform.m34 = -1.0/1000
        let rotation = CATransform3DRotate(transform, angle, 0, 1, 0)
        
        var scaleFromX = (1000 - (cellFrame.origin.x - 200)) / 1000
        let scaleMax : CGFloat = 1.0
        let scaleMin : CGFloat = 0.8
        if scaleFromX > scaleMax {
            scaleFromX = scaleMax
        }
        if scaleFromX < scaleMin {
            scaleFromX = scaleMin
        }
        //how many time the image scaling
        let scale = CATransform3DScale(CATransform3DIdentity, scaleFromX, scaleFromX, 1)
        // return the value has including (rotation, scale) value
        return CATransform3DConcat(rotation, scale)
    }
}



//
//  AboutViewController.swift
//  Emily
//
//  Created by popCorn on 2018/07/01.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit
import FirebaseAuth

class AboutViewController: UIViewController {

    @IBOutlet weak var aboutImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.aboutImage.layer.cornerRadius = self.aboutImage.frame.size.width / 2
        self.aboutImage.clipsToBounds = true
        self.aboutImage.layer.borderWidth = 3.0
        self.aboutImage.layer.borderColor = UIColor.white.cgColor
        // add effec
        applyMotionEffect(toView: view, magnitude: 10)
        applyMotionEffect(toView: aboutImage, magnitude: -20)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //add emotion effect
    func applyMotionEffect (toView view: UIView, magnitude:	Float) {
        let xMotion = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
        xMotion.minimumRelativeValue = -magnitude
        xMotion.maximumRelativeValue = magnitude
        
        let yMotion = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
        yMotion.minimumRelativeValue = -magnitude
        yMotion.maximumRelativeValue = magnitude
        let group = UIMotionEffectGroup()
        group.motionEffects = [xMotion, yMotion]
        // add motion to view
        view.addMotionEffect(group)
    }
     
    @IBAction func logOutButtonPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let error {
            print(error)
        }
    }
    
}

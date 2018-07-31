//
//  DeliveryViewController.swift
//  Emily
//
//  Created by popCorn on 2018/07/06.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit

class DeliveryViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var slideSV: UIScrollView!
    
   // @IBOutlet weak var slidePageControl: UIPageControl!
    
    let pic1 = ["title": "Find out Restaurant", "desc":"Take your phone and find", "image": "direction", "butt": "skip"]
    let pic2 = ["title": "Choose your meal", "desc":"Choose your favorites meal", "image": "meal", "butt": "skip"]
    let pic3 = ["title": "Meal is on the way", "desc":"Get ready and comfortable. While our biker brings your meal to you", "image": "delivery", "butt": "Get start"]
    // create dictionary array
    
    var picArray = [Dictionary<String, String>]()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        picArray = [pic1, pic2, pic3]
//      slidePageControl.numberOfPages = picArray.count
        slideSV.isPagingEnabled = true
        //size of all content view slide
        slideSV.contentSize = CGSize(width: self.view.bounds.width * CGFloat(picArray.count), height: 554)
        
        slideSV.showsHorizontalScrollIndicator = false
        slideSV.delegate = self
        // create load image and text
        
        loadViews()
        
    }
    
    func loadViews() {
        for (index, deli) in picArray.enumerated() {
            // load xib file to merge the view
            if let deliView = Bundle.main.loadNibNamed("Delivery", owner: self, options: nil)?.first as? DeliveryView {
                // image view
                deliView.imageView.image = UIImage(named: deli["image"]!)
                // title view
                deliView.titleView.text = deli["title"]
                deliView.descView.text = deli["desc"]
                deliView.labelNext.text = deli["butt"]
                
                //add subview
                slideSV.addSubview(deliView)
                // set one view size
                deliView.frame.size.width = self.view.bounds.size.width
                //position
                deliView.frame.origin.x = CGFloat(index) * self.view.bounds.size.width
                
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 

}

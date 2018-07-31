//
//  MenuViewController.swift
//  Emily
//
//  Created by popCorn on 2018/06/30.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    
    @IBOutlet weak var sendFoodName: UILabel!
    @IBOutlet weak var imageDesc: UIImageView!
    
    @IBOutlet weak var sendPrice: UILabel!
    @IBOutlet weak var textDescription: UITextView!
    var section: [String: String]!
    var sections: [[String: String]]!
    var indexPath: IndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Emily Restaurant"
        self.sendFoodName.text = section["section"]
        self.sendPrice.text = section["chapter"]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeMenuButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}

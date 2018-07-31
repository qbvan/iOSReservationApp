//
//  MenuTableViewCell.swift
//  Emily
//
//  Created by popCorn on 2018/06/30.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
 
    
    @IBOutlet weak var titleCell: UILabel!  
    
    @IBOutlet weak var price: UILabel! 
    
    @IBOutlet weak var imageCell: UIImageView!
    
    @IBOutlet weak var like: UILabel!
    @IBOutlet weak var onSale: UILabel!
    @IBOutlet weak var ratingStar: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
     

}

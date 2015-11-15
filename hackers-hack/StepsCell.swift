//
//  StepsCell.swift
//  hackers-hack
//
//  Created by Mudasir Ahmed on 11/15/15.
//  Copyright © 2015 Mudasir Ahmed. All rights reserved.
//

import UIKit

class StepsCell: UITableViewCell {
    
    @IBOutlet weak var stepLabel:UILabel!
    @IBOutlet weak var storeImageView:UIImageView!
    
    func configureCell(label:String, image:UIImage) {
        self.stepLabel.text = label
        self.storeImageView.image = image
    }
}

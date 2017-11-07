//
//  ModInfoTableViewCell.swift
//  ModRank
//
//  Created by Nick Fisher on 11/5/17.
//  Copyright © 2017 Nick Fisher. All rights reserved.
//

import UIKit

class ModInfoTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var modImage: UIImageView!
    @IBOutlet weak var percentagesStack: PercentagesView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    } 
}

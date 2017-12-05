//
//  ModListTableViewCell.swift
//  ModRank
//
//  Created by Nick Fisher on 12/4/17.
//  Copyright © 2017 Nick Fisher. All rights reserved.
//

import UIKit


class ModListTableViewCell: UITableViewCell {
    
    var modList: [ModInfo]?
    @IBOutlet weak var cell: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.refresh()
    }
    
    func refresh() {
        
        // Clear subviews
        for i in cell.subviews {
            i.removeFromSuperview()
        }
        
        guard let mods = modList
            else {
                return
        }
        
        cell.axis = .horizontal
        cell.autoresizesSubviews = true
        for mod in mods {
            let img = UIImageView(image: UIImage(data: mod.img))
            cell.addArrangedSubview(img)
        }
    }
}


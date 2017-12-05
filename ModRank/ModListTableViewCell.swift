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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.refresh()
    }
    
    func refresh() {
        
        // Clear subviews
        for i in subviews {
            i.removeFromSuperview()
        }
        
        guard let mods = modList
            else {
                return
        }
        
        let stack = UIStackView()
        stack.axis = .horizontal
        for mod in mods {
            let img = UIImageView(image: UIImage(data: mod.img))
            img.contentMode = .scaleAspectFit
            
            stack.addSubview(img)
        }
        addSubview(stack)
    }
}


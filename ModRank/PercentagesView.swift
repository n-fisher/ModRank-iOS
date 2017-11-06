//
//  PercentagesView.swift
//  ModRank
//
//  Created by Nick Fisher on 11/5/17.
//  Copyright © 2017 Nick Fisher. All rights reserved.
//

import UIKit

class PercentagesView: UIStackView {

    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: Private Methods
    public func updatePercentages(favs: Float, views: Float, unsubs: Float, subs: Float, comments: Float) {
        for i in [favs, subs, views, comments, unsubs] {
            // Create the label
            let percent = UILabel()
            
            // Add constraints
            percent.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
            percent.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
            percent.adjustsFontSizeToFitWidth = true
            percent.text = String(format: "%.1f%%", i)
            
            // Add the percent to the stack
            addArrangedSubview(percent)
        }
    }
}

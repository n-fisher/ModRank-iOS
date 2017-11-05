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
        setupPercentages()
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupPercentages()
    }
    
    //MARK: Private Methods
    private func setupPercentages() {
        for i in ["favs", "subs", "views", "comments", "unsubscribes"] {
            // Create the label
            let percent = UILabel()
            
            // Add constraints
            percent.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
            percent.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
            percent.adjustsFontSizeToFitWidth = true
            percent.text = i
            
            // Add the percent to the stack
            addArrangedSubview(percent)
        }
    }
}

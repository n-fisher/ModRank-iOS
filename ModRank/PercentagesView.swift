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
    public func refresh(favs: Float, views: Float, unsubs: Float, subs: Float, comments: Float) {
        let labels =  ["⭐️", "💾", "👁", "🗨", "X"]
        let vals = [favs, subs, views, comments, unsubs]
        
        for subview in arrangedSubviews {
            subview.removeFromSuperview()
        }
        
        for i in 0..<vals.count {
            // Create the label
            let stack = UIStackView()
            let label = UILabel()
            let percent = UILabel()
            
            // Add constraints
            //percent.lineBreakMode = NSLineBreakMode.byWordWrapping
            //percent.heightAnchor.constraint(equalToConstant: 88.0).isActive = true
            //percent.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
            label.adjustsFontSizeToFitWidth = true
            percent.adjustsFontSizeToFitWidth = true
            stack.axis = .vertical
            stack.alignment = .center
            
            label.text = labels[i]
            percent.text = String(format: "%.1f%%", vals[i])
            
            switch(vals[i]) {
            case 0..<10:
                percent.textColor = UIColor.cyan
            case 10..<20:
                percent.textColor = UIColor.blue
            case 20..<35:
                percent.textColor = UIColor.green
            case 35..<60:
                percent.textColor = UIColor.yellow
            default:
                percent.textColor = UIColor.red
            }
            
            // Add the percent to the stack
            stack.addArrangedSubview(label)
            stack.addArrangedSubview(percent)
            addArrangedSubview(stack)
        }
    }
}

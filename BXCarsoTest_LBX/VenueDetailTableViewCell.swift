//
//  VenueDetailTableViewCell.swift
//  BXCarsoTest_LBX
//
//  Created by Luis on 12/04/16.
//  Copyright © 2016 Luis. All rights reserved.
//

import UIKit

class VenueDetailTableViewCell: UITableViewCell {

    let venueDetailLabel : UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clearColor()
        
        setupLabel()
        
        let separatorLine = UIView()
        separatorLine.backgroundColor = UIColor.lightGrayColor()
        separatorLine.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(separatorLine)
        
        let bottomConstraint = NSLayoutConstraint(item: separatorLine,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: -1.5)
        
        let centerXConstraint = NSLayoutConstraint(item: separatorLine,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0.0)
        
        let heightConstraint = NSLayoutConstraint(item: separatorLine,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Height,
            multiplier: 0.0,
            constant: 0.75)
        
        let widthConstraint = NSLayoutConstraint(item: separatorLine,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0.0)
        
        self.addConstraint(bottomConstraint)
        self.addConstraint(centerXConstraint)
        self.addConstraint(heightConstraint)
        self.addConstraint(widthConstraint)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupLabel() {
        
        venueDetailLabel.backgroundColor = UIColor.clearColor()
        venueDetailLabel.textColor = UIColor(white: 0.60, alpha: 1.0)
        venueDetailLabel.font = UIFont.systemFontOfSize(10.0)
        venueDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(venueDetailLabel)
        
        let topConstraint = NSLayoutConstraint(item: venueDetailLabel,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0.0)
        
        let leftConstraint = NSLayoutConstraint(item: venueDetailLabel,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Left,
            multiplier: 1.0,
            constant: 15.0)
        
        let bottomConstraint = NSLayoutConstraint(item: venueDetailLabel,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Height,
            multiplier: 0.75,
            constant: 0.0)
        
        let rightConstraint = NSLayoutConstraint(item: venueDetailLabel,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Width,
            multiplier: 0.90,
            constant: 0.0)
        
        self.addConstraint(topConstraint)
        self.addConstraint(leftConstraint)
        self.addConstraint(bottomConstraint)
        self.addConstraint(rightConstraint)
        
        
    }
    
    func cellLabel() -> UILabel {
        return venueDetailLabel
    }


}

//
//  VenueListTableViewCell.swift
//  BXCarsoTest_LBX
//
//  Created by Luis on 11/04/16.
//  Copyright © 2016 Luis. All rights reserved.
//

import UIKit
import CoreData

class VenueListTableViewCell: UITableViewCell {

    let venueNameLabel : UILabel = UILabel()
    var currentVenueId : String?
    var isFavoriteItem : Bool = false
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        self.backgroundColor = UIColor.clearColor()
        
        setupLabel()
        //setupFavoriteButton()
        
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
            constant: -1.0)
        
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
            constant: 0.5)
        
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
        
        venueNameLabel.backgroundColor = UIColor.clearColor()
        venueNameLabel.textColor = UIColor(white: 0.60, alpha: 1.0)
        venueNameLabel.font = UIFont.systemFontOfSize(12.0)
        venueNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(venueNameLabel)
        
        let topConstraint = NSLayoutConstraint(item: venueNameLabel,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0.0)
        
        let leftConstraint = NSLayoutConstraint(item: venueNameLabel,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Left,
            multiplier: 1.0,
            constant: 15.0)
        
        let bottomConstraint = NSLayoutConstraint(item: venueNameLabel,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Height,
            multiplier: 0.75,
            constant: 0.0)
        
        let rightConstraint = NSLayoutConstraint(item: venueNameLabel,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Width,
            multiplier: 0.65,
            constant: 0.0)
        
        self.addConstraint(topConstraint)
        self.addConstraint(leftConstraint)
        self.addConstraint(bottomConstraint)
        self.addConstraint(rightConstraint)

    }
    
    func cellLabel() -> UILabel {
        return venueNameLabel
    }
    
    func setupFavoriteButton() {
        
        let favButton = UIButton(type: .System)
        
        if isFavoriteItem{
            favButton.setBackgroundImage(UIImage(named: "favorite"), forState: .Normal)
            favButton.tag = 1
        }
        else{
            favButton.setBackgroundImage(UIImage(named: "add_fav"), forState: .Normal)
        }
        
        favButton.addTarget(self, action: "favoriteButtonPressed:", forControlEvents: .TouchUpInside)
        
        favButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(favButton)
        
        let topConstraint = NSLayoutConstraint(item: favButton,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0.0)
        
        let leftConstraint = NSLayoutConstraint(item: favButton,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Right,
            multiplier: 1.0,
            constant: -15.0)
        
        let bottomConstraint = NSLayoutConstraint(item: favButton,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Height,
            multiplier: 0.0,
            constant: 20.0)
        
        let rightConstraint = NSLayoutConstraint(item: favButton,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Width,
            multiplier: 0.0,
            constant: 20.0)
        
        self.addConstraint(topConstraint)
        self.addConstraint(leftConstraint)
        self.addConstraint(bottomConstraint)
        self.addConstraint(rightConstraint)
        
        
    }
    
    
    func favoriteButtonPressed(sender : UIButton) {
        
        sender.userInteractionEnabled = false
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("VenueCDModel",
            inManagedObjectContext:managedContext)
        let venue = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        if sender.tag == 0 {
            
            venue.setValue(currentVenueId, forKey: "id")
            venue.setValue(venueNameLabel.text, forKey: "name")
            
            do {
                try managedContext.save()
                
                UIView.animateWithDuration(0.25,
                    animations: {
                        sender.transform = CGAffineTransformMakeScale(0.6, 0.6)
                    },
                    completion: { finish in
                        sender.setBackgroundImage(UIImage(named: "favorite"), forState: .Normal)
                        UIView.animateWithDuration(0.25){
                            sender.transform = CGAffineTransformIdentity
                            sender.userInteractionEnabled = true
                        }
                })
                
                sender.tag = 1
                
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
                
            }
            
            
        }
        else{
            
            let fetchRequest = NSFetchRequest(entityName: "VenueCDModel")
            
            
            // Delete en modo YOLO
            do{
                let managedVenues = try managedContext.executeFetchRequest(fetchRequest)
                let venues = managedVenues as! [NSManagedObject]
                for venue in venues {
                    let venueIdCD = venue.valueForKey("id") as? String
                    
                    if venueIdCD == currentVenueId {
                        managedContext.deleteObject(venue)
                    }
                    
                }
            }
            catch{
            }
            
            do {
                try managedContext.save()
                
                UIView.animateWithDuration(0.25,
                    animations: {
                        sender.transform = CGAffineTransformMakeScale(0.6, 0.6)
                    },
                    completion: { finish in
                        sender.setBackgroundImage(UIImage(named: "add_fav"), forState: .Normal)
                        UIView.animateWithDuration(0.25){
                            sender.transform = CGAffineTransformIdentity
                            sender.userInteractionEnabled = true
                        }
                })
                sender.tag = 0
                
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
                
            }
            
        }
        
        
        
    }

}

//
//  VenueDetailViewController.swift
//  BXCarsoTest_LBX
//
//  Created by Luis on 11/04/16.
//  Copyright © 2016 Luis. All rights reserved.
//

import UIKit


class VenueDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var venueModel : VenueModel?
    var shouldLoadData : Bool = false
    let detailTableView = UITableView()
    var centerConstrain : NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view = UIView()
        
        setupBackground()
        setupDetailTableView()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        centerConstrain!.constant = 30.0
        UIView.animateWithDuration(0.30, animations: {
            self.view.layoutIfNeeded()
            },
            completion: { finish in
                self.centerConstrain!.constant = -30
                UIView.animateWithDuration(0.25, animations: {
                    self.view.layoutIfNeeded()
                    }, completion: { finish in
                        self.centerConstrain!.constant = 0.0
                        
                        UIView.animateWithDuration(0.25, animations: {
                            self.view.layoutIfNeeded()
                            }, completion: { finish in
                                self.shouldLoadData = true
                                self.detailTableView.reloadData()
                            })
                        
                })
        })
        
        
    }
    
    func setupBackground() {
        
        let backgroundIV = UIImageView(image: UIImage(named: "detail_background"))
        //backgroundIV.alpha = 0.7
        backgroundIV.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backgroundIV)
        
        let topConstraint = NSLayoutConstraint(item: backgroundIV,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Top,
            multiplier: 1.0,
            constant: 0.0)
        
        let leftConstraint = NSLayoutConstraint(item: backgroundIV,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Left,
            multiplier: 1.0,
            constant: 0.0)
        
        let bottomConstraint = NSLayoutConstraint(item: backgroundIV,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 0.0)
        
        let rightConstraint = NSLayoutConstraint(item: backgroundIV,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Right,
            multiplier: 1.0,
            constant: 0.0)
        
        view.addConstraint(topConstraint)
        view.addConstraint(leftConstraint)
        view.addConstraint(bottomConstraint)
        view.addConstraint(rightConstraint)
        
        let blurredView = UIView()
        blurredView.backgroundColor = UIColor(white: 1.0, alpha: 0.4)
        blurredView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(blurredView)
        
        let topBVConstraint = NSLayoutConstraint(item: blurredView,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Top,
            multiplier: 1.0,
            constant: 0.0)
        
        let leftBVConstraint = NSLayoutConstraint(item: blurredView,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Left,
            multiplier: 1.0,
            constant: 0.0)
        
        let bottomBVConstraint = NSLayoutConstraint(item: blurredView,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 0.0)
        
        let rightBVConstraint = NSLayoutConstraint(item: blurredView,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Right,
            multiplier: 1.0,
            constant: 0.0)
        
        view.addConstraint(topBVConstraint)
        view.addConstraint(leftBVConstraint)
        view.addConstraint(bottomBVConstraint)
        view.addConstraint(rightBVConstraint)

    }
    
    
    func setupDetailTableView() {
        
        //Create containerView
        let containerView:UIView = UIView()
        containerView.backgroundColor = UIColor.clearColor()
        containerView.layer.shadowColor = UIColor.darkGrayColor().CGColor
        containerView.layer.shadowOffset = CGSizeMake(-2, 2); //Left-Bottom shadow
        containerView.layer.shadowOpacity = 1.0
        containerView.layer.shadowRadius = 2
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerView)
        
        let topConstraint = NSLayoutConstraint(item: containerView,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0.0)
        
        centerConstrain = NSLayoutConstraint(item: containerView,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: -400.0)
        
        let bottomConstraint = NSLayoutConstraint(item: containerView,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Width,
            multiplier: 0.80,
            constant: 0.0)
        
        let rightConstraint = NSLayoutConstraint(item: containerView,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Height,
            multiplier: 0.50,
            constant: 0.0)
        
        view.addConstraint(topConstraint)
        view.addConstraint(centerConstrain!)
        view.addConstraint(bottomConstraint)
        view.addConstraint(rightConstraint)
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        detailTableView.separatorStyle = .None
        detailTableView.showsVerticalScrollIndicator = false
        
        detailTableView.layer.borderColor = UIColor .grayColor().CGColor
        detailTableView.layer.borderWidth = 0.75
        detailTableView.layer.cornerRadius = 10
        detailTableView.layer.masksToBounds = true
        detailTableView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(detailTableView)
        
        let topTVConstraint = NSLayoutConstraint(item: detailTableView,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: containerView,
            attribute: .Top,
            multiplier: 1.0,
            constant: 0.0)
        
        let leftTVConstraint = NSLayoutConstraint(item: detailTableView,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: containerView,
            attribute: .Left,
            multiplier: 1.0,
            constant: 0.0)
        
        let bottomTVConstraint = NSLayoutConstraint(item: detailTableView,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: containerView,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: 0.0)
        
        let rightTVConstraint = NSLayoutConstraint(item: detailTableView,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: containerView,
            attribute: .Right,
            multiplier: 1.0,
            constant: 0.0)
        
        containerView.addConstraint(topTVConstraint)
        containerView.addConstraint(leftTVConstraint)
        containerView.addConstraint(bottomTVConstraint)
        containerView.addConstraint(rightTVConstraint)
        
    }
    
    //MARK: UITableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !shouldLoadData {
            return 0
        }
        
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = VenueDetailTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "defaultCell")
        //let venue = venueViewModel?.venuesData()[indexPath.row]
        cell.cellLabel().text = venueViewModel!.venueValuesForIndex(indexPath.row, selectedModel: venueModel!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  VenueListViewController.swift
//  BXCarsoTest_LBX
//
//  Created by Luis on 10/04/16.
//  Copyright © 2016 Luis. All rights reserved.
//

import UIKit
import Alamofire

var venueListTableView : UITableView?
var venueViewModel : VenueViewModel?



let fourSquareClientId = "T4ENGEWTXNOKH52LB2EHJKE34CMYTSBCESDJYZCZSJH24NHM"
let fourSquareClientSecret = "CF2NAL4BL0J0YXYBT4F3RSSBBVC242PQUFHZAPSFSN2SD5A0"

class VenueListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"

        // Do any additional setup after loading the view.
        self.view = UIView()
        
        view.backgroundColor = UIColor.blackColor()
        setUpTableView()
        
        promptForLocation()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setUpTableView() {
        
        venueListTableView = UITableView()
        venueListTableView?.delegate = self
        venueListTableView?.dataSource = self
        venueListTableView?.backgroundColor = UIColor.clearColor()
        venueListTableView?.translatesAutoresizingMaskIntoConstraints = false
        venueListTableView?.separatorStyle = .None
        
        view.addSubview(venueListTableView!)
        
        let topConstraint = NSLayoutConstraint(item: venueListTableView!,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Top,
            multiplier: 1.0,
            constant: 20.0)
        
        let leftConstraint = NSLayoutConstraint(item: venueListTableView!,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Left,
            multiplier: 1.0,
            constant: 0.0)
        
        let bottomConstraint = NSLayoutConstraint(item: venueListTableView!,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Bottom,
            multiplier: 1.0,
            constant: -20.0)
        
        let rightConstraint = NSLayoutConstraint(item: venueListTableView!,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: self.view,
            attribute: .Right,
            multiplier: 1.0,
            constant: 0.0)
        
        view.addConstraint(topConstraint)
        view.addConstraint(leftConstraint)
        view.addConstraint(bottomConstraint)
        view.addConstraint(rightConstraint)
        
        
        
    }

    
    
    // MARK: - UITableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if let venueVM = venueViewModel {
            return venueVM.venuesQuantity()
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = VenueListTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "defaultCell")
        
        let venue = venueViewModel?.venuesData()[indexPath.row]
        cell.currentVenueId = venue?.id
        cell.isFavoriteItem = (venue?.savedInFavorite)!
        cell.setupFavoriteButton()
        
        cell.cellLabel().text = venue?.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let venue = venueViewModel?.venuesData()[indexPath.row]
        
        let venueDetailVC = VenueDetailViewController()
        venueDetailVC.title = venue?.name
        venueDetailVC.venueModel = venue
        
        
        self.navigationController?.pushViewController(venueDetailVC, animated: true)
        
    }

    
    func promptForLocation() {
        
        let textPrompt = UIAlertController(title: "Atención", message: "Ingresa un nombre de ciudad", preferredStyle: UIAlertControllerStyle.Alert)
        textPrompt.addTextFieldWithConfigurationHandler({(cityTextField: UITextField!) in
            cityTextField.placeholder = "Ciudad"
            cityTextField.secureTextEntry = true
        })
        
        textPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        
        let okAction = UIAlertAction(title: "Buscar", style: UIAlertActionStyle.Default) { (yAction) -> Void in
            
            if textPrompt.textFields?.first?.text?.characters.count > 0{
                self.getVenuesData(textPrompt.textFields?.first?.text)
            }
            else{
                self.getVenuesData("Ciudad de Mexico")
            }
            
            
        }
        textPrompt.addAction(okAction)
        
        presentViewController(textPrompt, animated: true, completion: nil)
        
    }
    
    func getVenuesData(searchString : String?) {
        
        Alamofire.request(.GET, "https://api.foursquare.com/v2/venues/search", parameters: ["near": searchString!, "client_id": fourSquareClientId, "client_secret": fourSquareClientSecret, "v": "20151231", "limit": "30"])
            .responseJSON { response in
                
                switch response.result {
                case .Success(let jsonResult):
                    print("Downloaded JSON structure: \(jsonResult)")
                    
                    venueViewModel = VenueViewModel(modelData: response.data!)
                    
                    venueViewModel?.checkCoreDataPersistence()
                    
                    /*let alert = UIAlertController(title: "Aviso", message: "Se obtuvieron \(venueViewModel?.venuesQuantity()) registros", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (yAction) -> Void in
                    
                    }
                    
                    alert.addAction(okAction)
                    self.presentViewController(alert, animated: true, completion: nil)*/
                    
                    venueListTableView?.reloadData()
                    
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    
                    let alert = UIAlertController(title: "Error", message: "Hubo un error al obtener los datos", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { (yAction) -> Void in
                        //Reintentar?
                    }
                    
                    alert.addAction(okAction)
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
                
        }
        
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

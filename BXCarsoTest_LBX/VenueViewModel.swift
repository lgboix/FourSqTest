//
//  VenueViewModel.swift
//  BXCarsoTest_LBX
//
//  Created by Luis on 10/04/16.
//  Copyright © 2016 Luis. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

var venuesArray : Array<VenueModel>!

class VenueViewModel: NSObject {
    
    let venueDetailArray = ["Categoria:","Resumen de gente:","Lugar:","Latitud:","Longitud:","Checkins:"]
    
    init(modelData: NSData) {
        
        let json = JSON(data: modelData)
        var venuesDLArray = Array<VenueModel>()
        
        if let venueArray = json["response"]["venues"].array {
            
            for venue in venueArray {
                let venueModel = VenueModel(modelData: venue)
                venuesDLArray.append(venueModel)
                
            }
            
            if venuesDLArray.count > 0 {
                venuesArray = venuesDLArray
            }
            
        }
        else{
            
            
        }
        
    }
    
    func getVenuesData() {
        
        
        Alamofire.request(.GET, "https://api.foursquare.com/v2/venues/search", parameters: ["near": "Chicago, IL"])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
        
    }
    
    
    func venuesData() -> Array<VenueModel> {
        
        return venuesArray!
        
    }
    
    
    func venuesQuantity() -> Int {
        
        return venuesArray.count
    }

    
    func venueValuesForIndex(currentIndex: Int, selectedModel : VenueModel) -> String {
        
        switch (currentIndex){
        
        case 0:
            var catDict = selectedModel.categories![0]
            
            if let venueCategory = catDict["name"].string
            {
                return "\(venueDetailArray[currentIndex]) \(venueCategory)"
            }
        
        case 1:
            if let venueCategory = selectedModel.hereNow!["summary"].string {
                return "\(venueDetailArray[currentIndex]) \(venueCategory)"
            }
        
        case 2:
            if let venueCategory = selectedModel.location!["formattedAddress"].array {
                
                var stringM : String = ""
                for value in venueCategory {
                    stringM = stringM + " \(value)"
                }
                
                return "\(venueDetailArray[currentIndex]) \(stringM)"
            }
        
        case 3:
            if let venueCategory = selectedModel.location!["lat"].number {
                return "\(venueDetailArray[currentIndex]) \(venueCategory)"
            }

        case 4:
            if let venueCategory = selectedModel.location!["lng"].number {
                return "\(venueDetailArray[currentIndex]) \(venueCategory)"
            }

        case 5:
            if let venueCategory = selectedModel.stats!["checkinsCount"].int {
                return "\(venueDetailArray[currentIndex]) \(venueCategory)"
            }
            
        default:
            return selectedModel.name

        }
        
        return ""
        
    }
    
    //MARK: Core Data
    
    func checkCoreDataPersistence() {
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "VenueCDModel")
        
        do {
            let managedVenues =
            try managedContext.executeFetchRequest(fetchRequest)
            
            let venues = managedVenues as! [NSManagedObject]
            for venue in venues {
                let venueIdCD = venue.valueForKey("id") as? String
                for venueMod in venuesArray {
                    if venueMod.id == venueIdCD {
                        venueMod.savedInFavorite = true
                    }
                }
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    
    func saveValue(venueId: String, name: String, completion: (success: Bool) -> Void)
    {
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("VenueCDModel",
            inManagedObjectContext:managedContext)
        
        let venue = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        //3
        venue.setValue(venueId, forKey: "id")
        venue.setValue(name, forKey: "name")
        
        //4
        do {
            try managedContext.save()
            
            completion(success: true)
            
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
            
            completion(success: false)
        }
        
        
        
    }

    
}


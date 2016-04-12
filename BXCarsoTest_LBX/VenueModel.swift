//
//  VenueModel.swift
//  BXCarsoTest_LBX
//
//  Created by Luis on 10/04/16.
//  Copyright © 2016 Luis. All rights reserved.
//

import UIKit

class VenueModel: NSObject {

    
    //Aqui ponemos los valores que nos regrese el venues de 4SQ
    var allowMenuUrlEdit : NSNumber?
    var categories : JSON?
    var contact : JSON!
    var hereNow : JSON!
    var id : String!
    var location : JSON!
    var name : String!
    var referralId : String!
    var specials : JSON!
    var stats : JSON!
    var venueChains : JSON!
    var verified : Bool = false
    var savedInFavorite : Bool = false
    
    init(modelData: JSON) {
        
        allowMenuUrlEdit = modelData["allowMenuUrlEdit"].number
        categories = modelData["categories"]
        contact = modelData["contact"]
        hereNow = modelData["hereNow"]
        id = modelData["id"].string
        location = modelData["location"]
        name = modelData["name"].string
        referralId = modelData["referralId"].string
        specials = modelData["specials"]
        stats = modelData["stats"]
        venueChains = modelData["venueChains"]
        verified = modelData["verified"].boolValue
        
        
    }
    
    
    
}

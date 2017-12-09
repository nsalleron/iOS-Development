//
//  UneCellule.swift
//  MesActivites
//
//  Created by Nicolas Salleron on 08/11/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit

class UneCellule: NSObject,NSCoding {
    
    var label = ""
    var lat = 0.0
    var lng = 0.0
    var compteur = 0
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(label, forKey:"label")
        aCoder.encode(String(lat), forKey: "lat")
        aCoder.encode(String(lng), forKey: "lng")
        aCoder.encode(String(compteur), forKey: "compteur")
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init()
        label = aDecoder.decodeObject(forKey: "label") as! String
        lat = Double(aDecoder.decodeObject(forKey: "lat") as! String)!
        lng = Double(aDecoder.decodeObject(forKey: "lng") as! String)!
        compteur = Int(aDecoder.decodeObject(forKey: "compteur") as! String)!
    }
    

    init(c : Int, l : String,lat: Double, lng : Double){
        super.init()
        compteur = c;
        label = l;
        self.lat = lat;
        self.lng = lng;
    }
}

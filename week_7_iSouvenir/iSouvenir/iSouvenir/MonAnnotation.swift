//
//  MonAnnotation.swift
//  iSouvenir
//
//  Created by Nicolas Salleron on 06/11/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit
import MapKit

class MonAnnotation: NSObject,MKAnnotation{
    
    var coordinate: CLLocationCoordinate2D
    var title : String?
    var subtitle: String?
    
    init(c : CLLocationCoordinate2D){
        coordinate = c
        super.init()
    }
    
    convenience init(c: CLLocationCoordinate2D, t: String) {
        self.init(c: c)
        title = t
    }
    
    convenience init(c:CLLocationCoordinate2D, t:String, st : String) {
        self.init(c: c)
        title = t
        subtitle = st
    }
    
    func updateTitle(t : String) -> Void {
        subtitle = t
    }
}

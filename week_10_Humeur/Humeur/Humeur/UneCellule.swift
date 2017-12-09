//
//  UneCellule.swift
//  MesActivites
//
//  Created by Nicolas Salleron on 08/11/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit

class UneCellule: NSObject {
    
    var label = ""
    var humeur = ""
    
    init(l : String){
        label = l;
        humeur = "happy"
    }
    
    func changeHumeur(l : String){
        humeur = l
    }
}

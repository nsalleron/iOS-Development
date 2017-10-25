//
//  RocketBullet.swift
//  RocketMario
//
//  Created by Nicolas Salleron on 22/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import Foundation
import UIKit

class RocketBullet: UIImageView {
    

    var x = 0.0, y = 0.0;
    var deplacement = 0.0
    var alongAxisX = 0.0
    var size = CGSize()
    var tooManyTime = 0;
    var bonus = false
    
    init(posRocket : CGSize, deplacement : Int){
        var randomPositionStart = arc4random_uniform(UInt32(6 - 0)) + 0
        switch randomPositionStart {
        case 1:
            super.init(image: #imageLiteral(resourceName: "gold_bullet"))
        case 2:
            super.init(image: #imageLiteral(resourceName: "normal_bullet"))
        case 3:
            super.init(image: #imageLiteral(resourceName: "Brick"))
        case 4:
            super.init(image: #imageLiteral(resourceName: "fantom"))
        case 5:
            randomPositionStart = arc4random_uniform(UInt32(3))
            if(randomPositionStart == 0){
                super.init(image: #imageLiteral(resourceName: "etoile"))
                bonus = true
            }else{
                super.init(image: #imageLiteral(resourceName: "normal_bullet"))
            }
            
           
        default:
            super.init(image: #imageLiteral(resourceName: "normal_bullet"))
        }
        randomPositionStart = arc4random_uniform(UInt32(7 - 0)) + 0
        switch randomPositionStart {
        case 1:
            alongAxisX = 1
        case 2:
            alongAxisX = 1.5
        case 3:
            alongAxisX = 2
        case 4:
            alongAxisX = -1
        case 5:
            alongAxisX = -1.5
        case 6:
            alongAxisX = -2
        default:
            alongAxisX = 0.5
        }
        size = posRocket
        self.deplacement = Double(deplacement)
        
        var tmpX = Int(arc4random_uniform(UInt32((posRocket.width))) + 151)
        if (tmpX > 468){
            tmpX -= tmpX - 150
        }

        self.location(x: tmpX, y: 0)
        //NSLog("pos : %lf NEW BULLET x : %lf y: %lf",posRocket.width,x,y)
        self.transform = CGAffineTransform(rotationAngle: -1.5708);
    }
    
    func reRand(){
        self.location(x: Int(arc4random_uniform(UInt32((size.width)))), y: 0)
    }
    
    
    
    func changeLocation(){
        //NSLog("DEPLACEMENT BULLET !!!!")
        y += deplacement
        x += alongAxisX
    }
    
    func location(x: Int,y: Int){
        self.x = Double(x);
        self.y = Double(y);
    }
    
    func changeXaxis(){
            alongAxisX = -1 * alongAxisX
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   

       
}

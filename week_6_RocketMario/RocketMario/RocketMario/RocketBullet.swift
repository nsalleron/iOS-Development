//
//  RocketBullet.swift
//  RocketMario
//
//  Created by Nicolas Salleron on 22/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class RocketBullet: UIImageView {
    

    var x = 0.0, y = 0.0;
    var deplacement = 0.0
    var alongAxisX = 0.0
    var alongAxisY = 0.0
    var life = 10
    var size = CGSize()
    var tooManyTime = 15;
    var typeRocket = 0
    var bonus = false
    var explosion = false
    var player: AVAudioPlayer?
    
    init(marioFire: CGSize, x: Int, y: Int){
        var tailleMario = Double(Double(marioFire.height / 3) - 36.666667)
        var tailleBoules = Double(Double(marioFire.height / 4) - 50.0)
        
        if tailleMario > 170 {
            tailleMario = 140
        }
        if tailleBoules > 100 {
            tailleBoules = 50
        }

        
        
        
        
        super.init(image: #imageLiteral(resourceName: "fireball"))
        alongAxisY = 6
        self.location(x: x + Int(((tailleMario - tailleBoules) + tailleBoules/2)), y: y)
        self.transform = CGAffineTransform(rotationAngle: -1.5708);
        
        
    }
    
    init(posRocket : CGSize, deplacement : Int){
        var randomPositionStart = arc4random_uniform(UInt32(6 - 0)) + 0
        switch randomPositionStart {
        case 1:
            super.init(image: #imageLiteral(resourceName: "gold_bullet"))
            typeRocket = 1
        case 2:
            super.init(image: #imageLiteral(resourceName: "normal_bullet_0"))
            typeRocket = 2
        case 3:
            super.init(image: #imageLiteral(resourceName: "Brick_0"))
            typeRocket = 3
        case 4:
            super.init(image: #imageLiteral(resourceName: "fantom_0"))
            typeRocket = 4
        case 5:
            randomPositionStart = arc4random_uniform(UInt32(3))
            if(randomPositionStart == 0){
                super.init(image: #imageLiteral(resourceName: "etoile"))
                bonus = true
                typeRocket = 10
            }else{
                super.init(image: #imageLiteral(resourceName: "normal_bullet_0"))
                typeRocket = 2
            }
            
           
        default:
            super.init(image: #imageLiteral(resourceName: "normal_bullet_0"))
            typeRocket = 2
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
        if (CGFloat(tmpX) > (posRocket.width - 150)){
            tmpX -= tmpX - 150
        }

        self.location(x: tmpX, y: 0)
        //NSLog("pos : %lf NEW BULLET x : %lf y: %lf",posRocket.width,x,y)
        self.transform = CGAffineTransform(rotationAngle: -1.5708);
        
    }
    
    func reRand(){
        self.location(x: Int(arc4random_uniform(UInt32((size.width)))), y: 0)
    }
    
    func explosionFire(){
        
        let randomPositionStart = arc4random_uniform(UInt32(4))
        switch randomPositionStart {
        case 1:
            super.image = #imageLiteral(resourceName: "explosion")
        case 2:
            super.image = #imageLiteral(resourceName: "explosion1")
        case 3:
            super.image = #imageLiteral(resourceName: "explosion2")
        case 4:
            super.image = #imageLiteral(resourceName: "explosion3")
        default:
           super.image = #imageLiteral(resourceName: "explosion2")
        }
        if(self.explosion == false){
            let randomSound = arc4random_uniform(UInt32(5 - 1))+1
            NSLog(String.init(format: "explode_%d", randomSound))
            let url = Bundle.main.url(forResource: String.init(format: "explode_%d", randomSound), withExtension: "mp3")
            playSound(url: url!)
        }
        self.explosion = true
        
    }
    
    func kaboom(){
        life -= 1
        
        if( life >= 5){
            switch typeRocket {
            case 1:
                super.image = #imageLiteral(resourceName: "gold_bullet")
            case 2:
                super.image = #imageLiteral(resourceName: "normal_bullet_1")
            case 3:
                 super.image = #imageLiteral(resourceName: "Brick_1")
            case 4:
                super.image = #imageLiteral(resourceName: "fantom_1")
            default:
                ()
            }
        }else{
            switch typeRocket {
            case 1:
                super.image = #imageLiteral(resourceName: "normal_bullet_2")
            case 2:
                super.image = #imageLiteral(resourceName: "normal_bullet_2")
            case 3:
                 super.image = #imageLiteral(resourceName: "Brick_2")
            case 4:
                super.image = #imageLiteral(resourceName: "fantom_1")
            default:
                ()
            }
        }
    }
    
    func changeLocationFire(){
        y -= alongAxisY
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
    
    func endSound(){
        player?.stop()
    }
    
    func playSound(url : URL) -> Void{
        
        DispatchQueue.global().async {
            
            //print(self.description)
            if(self.player != nil){
                if((self.player?.isPlaying)!){
                    NSLog("PLAYING")
                    self.player?.stop()
                }
            }
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                try AVAudioSession.sharedInstance().setActive(true)
                
                self.player = try AVAudioPlayer(contentsOf: url)
                guard let player = self.player else { return }
                
                player.play()
                
            } catch let error {
                print(error.localizedDescription)
            }
        }

        
    }
    
}

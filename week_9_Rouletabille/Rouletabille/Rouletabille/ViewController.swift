//
//  ViewController.swift
//  Rouletabille
//
//  Created by Nicolas Salleron on 03/12/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit
import CoreMotion
import AVFoundation

class ViewController: UIViewController,AVAudioPlayerDelegate {
    
    let ecran = UIView()
    let v1 = UIImageView(image: #imageLiteral(resourceName: "rouletabille-fond-eau"))
    let v2 = UIImageView(image: #imageLiteral(resourceName: "rouletabille-fond-phobos"))
    let v3 = UIImageView(image: #imageLiteral(resourceName: "rouletabille-fond-voutes"))
    let v4 = UIImageView(image: #imageLiteral(resourceName: "rouletabille-fond-mosaique"))
    let bille = UIImageView(image: #imageLiteral(resourceName: "bille"))
    let etoile = UIImageView(image: #imageLiteral(resourceName: "etoile-96"))
    var tabFondIndex = 0
    var tabFond:[UIImageView] = []
    var crMtnMngr = CMMotionManager()
    var acceleroX = 0.0
    var acceleroY = 0.0
    var updateData : Timer?
    var updateScreen : Timer?
    var updateSecond : Timer?
    var startGameTimer : Timer?
    var collisionBord : Bool?
    var collisionCoin : Bool?
    
    var score = 0
    var secondLeft = 60
    var timerStart = 4
    var labelSecond = UILabel()
    
    let scoreLabel = UILabel()
    let scoreImage = UIImageView(image: #imageLiteral(resourceName: "etoile-96"))
    let screenEnd = UIView()
    let screenStart = UIView()
    let btnRestart = UIButton(type: UIButtonType.system)
    let labelBravo = UILabel()
    let labelScore = UILabel()
    let labelStart = UILabel()
    
    var tmpView : UIView?
    
    var colBord : Bool?
    var colCoin : Bool?
    var firstTime = true
    var coinPlayer : AVAudioPlayer?
    var etoilePlayer : AVAudioPlayer?
    var fondPlayer : AVAudioPlayer?
    var precX = 0
    var precY = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        /* Fond d'écran + secousses */
        v1.frame = UIScreen.main.bounds
        v2.frame = UIScreen.main.bounds
        v3.frame = UIScreen.main.bounds
        v4.frame = UIScreen.main.bounds
        tabFond = [v1,v2,v3,v4]
        
        self.becomeFirstResponder()
        
        
        
        if(crMtnMngr.isDeviceMotionAvailable){
            if(crMtnMngr.isAccelerometerAvailable){
                crMtnMngr.startAccelerometerUpdates()
            }
        }
        
        /* Bille */
        bille.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        /* Etoile */
        etoile.frame = CGRect(x: (UIScreen.main.bounds.width - 25 )/2, y: (UIScreen.main.bounds.height - 25 )/2, width: 50, height: 50)
       
        
        /* Secondleft */
        labelSecond.text = "0:\(secondLeft)"
        labelSecond.font = UIFont.systemFont(ofSize: 60, weight: UIFontWeightHeavy)
        labelSecond.frame = CGRect(x: (UIScreen.main.bounds.width/2) - 60, y: 10, width: 150, height: 70)
        labelSecond.textColor = UIColor.white
        
        
        /* Score */
        scoreImage.frame = CGRect(x: (UIScreen.main.bounds.width - 50), y: 10, width: 15, height: 15)
        scoreLabel.frame = CGRect(x: (UIScreen.main.bounds.width - 25), y: 10, width: 30, height: 15)
        scoreLabel.text = "\(score)"
        scoreLabel.textColor = UIColor.white
        
        
        /* Ecran de début */
        
        screenStart.alpha = 0.9
        screenStart.backgroundColor = UIColor.darkGray
        screenStart.frame = CGRect(x: Int(10),
                                 y: Int(UIScreen.main.bounds.height/3) + 10,
                                 width: Int(UIScreen.main.bounds.width - 20),
                                 height: Int(UIScreen.main.bounds.height/3))

        
        labelStart.text = "Ramassez un maximum d'étoile en 1 minute\n\n Bonne chance !\n \(timerStart)"
        labelStart.font = UIFont.systemFont(ofSize: 20)
        labelStart.numberOfLines = 6
        labelStart.textColor = UIColor.white
        labelStart.frame = CGRect(x: 10,
                                y: 10,
                                width: Int(screenStart.frame.width - 20),
                                height: Int(screenStart.frame.height - 20))
        labelStart.textAlignment = NSTextAlignment.center
        screenStart.addSubview(labelStart)
       
       
        
        
        
        /* Ecran de fin */
        screenEnd.alpha = 0.9
        screenEnd.backgroundColor = UIColor.darkGray
        screenEnd.frame = CGRect(x: Int(10),
                                 y: Int(UIScreen.main.bounds.height/3) + 10,
                                 width: Int(UIScreen.main.bounds.width - 20),
                                 height: Int(UIScreen.main.bounds.height/3))
        
        
        
        labelBravo.textColor = UIColor.white
        labelBravo.numberOfLines = 2
        labelBravo.layer.borderColor = UIColor.red.cgColor
        labelBravo.text = "Bravo !"
        labelBravo.frame = CGRect(x: Int(screenEnd.bounds.width/2 - 30),
                                  y: 10,
                                  width: 100,
                                  height: 30)
        
        
        
        
        labelScore.textColor = UIColor.white
        labelScore.numberOfLines = 2
        labelScore.font = UIFont.systemFont(ofSize: 20)
        labelScore.text = "  Score: \(score)"
        labelScore.frame = CGRect(x: Int(screenEnd.bounds.width/2 - 50),
                                  y: 40,
                                  width: 100,
                                  height: 30)
        
        btnRestart.addTarget(self, action: #selector(self.btnRefresh), for: .touchUpInside)
        btnRestart.setImage(#imageLiteral(resourceName: "refresh"), for: UIControlState.normal)
        btnRestart.frame = CGRect(x: Int(screenEnd.bounds.width/2 - 50),
                                  y: 60,
                                  width: 100,
                                  height: 100)
        
        screenEnd.addSubview(labelBravo)
        screenEnd.addSubview(labelScore)
        screenEnd.addSubview(btnRestart)
        
        
        
        
        
        ecran.addSubview(tabFond[tabFondIndex])
        ecran.addSubview(scoreLabel)
        ecran.addSubview(scoreImage)
        ecran.addSubview(labelSecond)
        ecran.addSubview(etoile)
        ecran.addSubview(bille)
        ecran.addSubview(screenEnd)
        ecran.addSubview(screenStart)
        
        self.view = ecran
        
        screenEnd.isHidden = true
        screenStart.isHidden = false
        
        startGameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(self.startGameTimerFunc), userInfo: nil, repeats: true)
        
        
    }
    
    func btnRefresh(){
        timerStart = 4
        labelStart.text = "Ramassez un maximum d'étoile en 1 minute\n\n Bonne chance !\n \(timerStart)"
        screenEnd.isHidden = true
        screenStart.isHidden = false
        
        startGameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(self.startGameTimerFunc), userInfo: nil, repeats: true)
    }
  
    func startGameTimerFunc(){
        screenEnd.isHidden = true
        screenStart.isHidden = false
        timerStart -= 1
        labelStart.text = "Ramassez un maximum d'étoile en 1 minute\n\n Bonne chance !\n \(timerStart)"
        if(timerStart == 0){
            screenStart.isHidden = true
            startGameTimer?.invalidate()
            let sonCol = Bundle.main.path(forResource: "midnight-ride-01a", ofType: ".mp3")
            let ficURL = URL(fileURLWithPath: sonCol!)
            do {
                fondPlayer = try AVAudioPlayer(contentsOf: ficURL)
            } catch _ {
                
            }
            if(!(fondPlayer?.isPlaying)!){
                fondPlayer?.delegate = self
                fondPlayer?.play()
            }
            self.startGame(sender:nil)
        }
    }
    
    
    func updateSecondFunc() {
        secondLeft -= 1
        if(secondLeft < 10){
            labelSecond.text = "0:0\(secondLeft)"
        }else{
            labelSecond.text = "0:\(secondLeft)"
        }
        
        
        if(secondLeft == 0){
            //ending
            
            updateSecond?.invalidate()
            updateData?.invalidate()
            updateScreen?.invalidate()
            screenEnd.isHidden = false
        }
        
    }
    
  
    
    
    func startGame(sender:UIButton?){
        NSLog("start")
        screenEnd.isHidden = true
        updateData?.invalidate()
        updateScreen?.invalidate()
        updateSecond?.invalidate()
        score = 0
        secondLeft = 60
        
        updateSecond = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateSecondFunc), userInfo: nil, repeats: true)
        updateData = Timer.scheduledTimer(timeInterval: 1/60, target: self, selector: #selector(self.updateDataFunc), userInfo: nil, repeats: true)
        updateScreen = Timer.scheduledTimer(timeInterval: 1/60, target: self, selector: #selector(self.updateScreenFunc), userInfo: nil, repeats: true)
    }
    
    
    func updateScreenFunc(){
        /*Calcul du déplacement de la bille */
        let tmpX = bille.frame.origin.x
        let tmpY = bille.frame.origin.y
        
        precX = Int(tmpX)
        precY = Int(tmpY)
        
        
        bille.frame.origin.x = tmpX + CGFloat(acceleroX * 10)
        bille.frame.origin.y = tmpY + -1*CGFloat(acceleroY * 10)
        
        if(bille.frame.origin.x < 0){
            bille.frame.origin.x = 0
        }
        if((bille.frame.origin.x + 50) > UIScreen.main.bounds.size.width){
            bille.frame.origin.x = (UIScreen.main.bounds.size.width - 50)
        }
        
        if(bille.frame.origin.y < 0){
            bille.frame.origin.y = 0
        }
        if((bille.frame.origin.y + 50) > UIScreen.main.bounds.size.height){
            bille.frame.origin.y = (UIScreen.main.bounds.size.height - 50)
        }
        
        /* Son collision */
        if(bille.frame.origin.y == 0 ||
            bille.frame.origin.y + 50 == UIScreen.main.bounds.size.height ||
            bille.frame.origin.x == 0 ||
            bille.frame.origin.x + 50 == UIScreen.main.bounds.size.width){
            
            let bX = bille.frame.origin.x
            let bY = bille.frame.origin.y
            
            let mX = UIScreen.main.bounds.width
            let mY = UIScreen.main.bounds.height
            
            if(bX == 0 && bY == 0){
                colCoin = true
            }else if(bX == mX && bY == 0){
                colCoin = true
            }else if(bX == mX && bY == mY){
                colCoin = true
            }else if(bX == 0 && bY == mY){
                colCoin = true
            }else{
                colBord = true
            }
            
            
        }else{
            colCoin = false
            colBord = false
        }
        
        if(colCoin == true || colBord == true){
            
            if(firstTime == true){
                let sonCol = Bundle.main.path(forResource: "son", ofType: ".mp3")
                let ficURL = URL(fileURLWithPath: sonCol!)
                
                do {
                    coinPlayer = try AVAudioPlayer(contentsOf: ficURL)
                } catch _ {
                        
                }
                
                if(!(coinPlayer?.isPlaying)!){
                   coinPlayer?.delegate = self
                   coinPlayer?.play()
                }
                firstTime = false
            }
        }
        
        
        if(precX == Int(bille.frame.origin.x) || precY == Int(bille.frame.origin.y)){
            firstTime = false
        }else{
            firstTime = true
        }
        
        
        /* Collision entre étoile et bille */
        if((etoile.frame.origin.x + 25) > (bille.frame.origin.x) &&
            bille.frame.origin.y < (etoile.frame.origin.y + 25) &&
            bille.frame.origin.x > etoile.frame.origin.x &&
            bille.frame.origin.y > etoile.frame.origin.y){
            
            //Collision bas droite
            NSLog("BAS DROITE")
            self.generateNewStar()
        }
        
        if((etoile.frame.origin.x + 25) > (bille.frame.origin.x) &&
            bille.frame.origin.y < (etoile.frame.origin.y + 25) &&
            bille.frame.origin.x + 50 > etoile.frame.origin.x &&
            bille.frame.origin.y > etoile.frame.origin.y){
            
            //Collision bas gauche
            NSLog("BAS GAUCHE")
            self.generateNewStar()
        }
        
        if((etoile.frame.origin.x) < (bille.frame.origin.x + 25) &&
            (bille.frame.origin.y + 25) > (etoile.frame.origin.y) &&
            bille.frame.origin.x < etoile.frame.origin.x &&
            bille.frame.origin.y < etoile.frame.origin.y){
            
            //Collision haut gauche
            NSLog("HAUT GAUCHE")
            self.generateNewStar()        }
        
        if((etoile.frame.origin.x + 25) > (bille.frame.origin.x) &&
            (bille.frame.origin.y + 25) > (etoile.frame.origin.y) &&
            bille.frame.origin.x > (etoile.frame.origin.x) &&
            bille.frame.origin.y < etoile.frame.origin.y){
            
            //Collision haut droite
            NSLog("HAUT DROITE")
            self.generateNewStar()
        }
        
        
        
    }
    
    func updateDataFunc(){
        if crMtnMngr.isAccelerometerAvailable {
            acceleroX = (crMtnMngr.accelerometerData?.acceleration.x)!
            acceleroY = (crMtnMngr.accelerometerData?.acceleration.y)!
            //NSLog("x : \(acceleroX), y : \(acceleroY)")
        }else{
            NSLog("false")
        }
        
    }
    
    
    func generateNewStar(){
        etoile.removeFromSuperview()
        
        let randomNumberX = Int(arc4random_uniform(UInt32(UIScreen.main.bounds.width-50) - 50) + 50)
        let randomNumberY = Int(arc4random_uniform(UInt32(UIScreen.main.bounds.height-50) - 50) + 50)
    
        score += 1
        scoreLabel.text = "\(score)"
        etoile.frame = CGRect(x: randomNumberX, y: randomNumberY, width: 50, height: 50)
        self.view.addSubview(etoile)
        
        let sonCol = Bundle.main.path(forResource: "squeeze-toy-1", ofType: ".mp3")
        let ficURL = URL(fileURLWithPath: sonCol!)
        
        do {
           etoilePlayer = try AVAudioPlayer(contentsOf: ficURL)
        } catch _ {
    
        }
        
        
        if(!(etoilePlayer?.isPlaying)!){
            etoilePlayer?.delegate = self
            etoilePlayer?.play()
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    //Les secousses
    
    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        //NSLog("Début motion")
        
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        tabFondIndex = (tabFondIndex+1)%4
        ecran.addSubview(tabFond[tabFondIndex])
        ecran.addSubview(scoreLabel)
        ecran.addSubview(scoreImage)
        ecran.addSubview(labelSecond)
        ecran.addSubview(etoile)
        ecran.addSubview(bille)
        ecran.addSubview(screenEnd)
        ecran.addSubview(screenStart)
    }

    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        NSLog("End of \(String(describing: player.url?.absoluteURL))")
    }
    
   
}


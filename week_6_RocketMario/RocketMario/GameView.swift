//
//  GameView.swift
//  RocketMario
//
//  Created by Nicolas Salleron on 22/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit

class GameView: UIView {
    
    
    
    var mario = UIImageView(image: UIImage(named: "mario"))
    var imageStart = UIImageView(image: UIImage(named: "3"))
    let labelVie = UIButton()
    let labelScore = UIButton()
    let btnG = UIButton()
    let btnD = UIButton()
    let btnContinue = UIButton()
    let marioBulletValue = UISlider()
    var size = CGRect();
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     */
    var xMax = 0.0, yMax = 0.0, marioX = 0.0, marioY = 0.0;
    var DEPLACEMENT = 2.0
    var NIVEAU = 3
    //var bullet = 0
    var nbBulletTotal = 0
    var vitesseVertical = 0
    var marioLeft = false
    var marioRight = false
    var marioCollision = false
    var marioFire = false
    var marioVie = 3
    var timerStart = 4
    var timer = Timer()
    
    var tabBullet = Array<UIImageView>()
    var tabMarioBullet = Array<UIImageView>()
    
    var tailleMario = 0.0
    var tailleEnemies = 0.0;
    var tailleBoules = 0.0;
    
    init(frame : CGRect, val : Int){
        super.init(frame: frame);
        //NSLog("Difficulty : %d",val)
        self.NIVEAU = val
        if(NIVEAU == 4){
            self.DEPLACEMENT = 6
        }else if(NIVEAU == 5){
            self.DEPLACEMENT = 8
        }else if(NIVEAU == 6){
            self.DEPLACEMENT = 10
        }else{
            self.DEPLACEMENT = Double(2 * NIVEAU)
        }
        
        self.backgroundColor = UIColor.white
        size = frame
        
        //btnG.backgroundColor = UIColor.green
        btnG.addTarget(super.superview, action: #selector(ViewController.marioLeftPosition), for: .touchDown)
        btnG.addTarget(super.superview, action: #selector(ViewController.marioLeftPosition), for: .touchUpInside)
        
        //btnD.backgroundColor = UIColor.red
        btnD.addTarget(super.superview, action: #selector(ViewController.marioRightPosition), for: .touchDown)
        btnD.addTarget(super.superview, action: #selector(ViewController.marioRightPosition), for: .touchUpInside)
        
        labelVie.setTitle(String(format: " Vie : %d ", marioVie),for: .normal)
        labelVie.setTitleColor(UIColor.white, for: .normal)
        labelVie.layer.cornerRadius = 10
        labelVie.clipsToBounds = true
        labelVie.layer.borderWidth = 5
        labelVie.layer.borderColor = UIColor.black.cgColor
        labelVie.backgroundColor = UIColor.red
        
        
        labelScore.setTitle(String(format: "  Score : %d ", nbBulletTotal),for: .normal)
        labelScore.setTitleColor(UIColor.white, for: .normal)
        labelScore.layer.cornerRadius = 10
        labelScore.clipsToBounds = true
        labelScore.layer.borderWidth = 5
        labelScore.layer.borderColor = UIColor.black.cgColor
        labelScore.backgroundColor = UIColor.red
       
        
        btnContinue.setTitle(String(format: " Boules ", marioVie), for: .normal)
        //btnContinue.setTitle(String(format: "  ", marioVie), for: .highlighted)
        btnContinue.setTitleColor(UIColor.white, for: .normal)
        btnContinue.layer.cornerRadius = 10
        btnContinue.clipsToBounds = true
        btnContinue.layer.borderWidth = 5
        btnContinue.layer.borderColor = UIColor.black.cgColor
        btnContinue.backgroundColor = UIColor.red
        btnContinue.addTarget(super.superview, action: #selector(ViewController.endGame), for: .touchUpInside)
        btnContinue.isEnabled = false
        
        
        marioBulletValue.tintColor = UIColor.red
        marioBulletValue.thumbTintColor = UIColor.red
        marioBulletValue.maximumValue = 25
        marioBulletValue.minimumValue = 0
        marioBulletValue.value = 25
        marioBulletValue.isUserInteractionEnabled = false
        marioBulletValue.transform = CGAffineTransform(rotationAngle: -1.5708);
        
        self.generateEnvironement(f: frame.size)
        self.addSubview(btnG)
        self.addSubview(btnD)
        self.addSubview(labelVie)
        self.addSubview(labelScore)
        self.addSubview(btnContinue)
        self.addSubview(marioBulletValue)
        self.addSubview(mario)
        self.addSubview(imageStart)
        
        
        tailleMario = Double(Double(frame.size.height / 3) - 36.666667)
        tailleEnemies = Double(Double(frame.size.height / 4) - 30.0)
        tailleBoules = Double(Double(frame.size.height / 4) - 50.0)
        
        
        if tailleMario > 170 {
            tailleMario = 140
        }
        if tailleEnemies > 150 {
            tailleEnemies = 100
        }
        if tailleBoules > 100 {
            tailleBoules = 50
        }
        
        marioX = Double(CGFloat(frame.size.width / 2) - CGFloat(tailleMario/2.0))
        
        tabBullet.append(RocketBullet(posRocket: frame.size, deplacement : Int(DEPLACEMENT)))
        
        self.addSubview(tabBullet[0])
        
        self.DessineDansFormat(f: frame.size)
        
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(GameView.startTimer), userInfo: nil, repeats: true)
        
        
       
    }
    
    
    
    func startTimer(){
        timer.invalidate()
        /*
         *   Using a dispatch_after block is in most cases better than using sleep(time)
         *   as the thread on which the sleep is performed is blocked from doing other work. 
         *   when using dispatch_after the thread which is worked on does not get blocked so it can do other work in the meantime.
         *   If you are working on the main thread of your application, using sleep(time) is bad for the user experience
         *   of your app as the UI is unresponsive during that time.
         *   Dispatch after schedules the execution of a block of code instead of freezing the thread:
         *  Source : https://stackoverflow.com/questions/27517632/how-to-create-a-delay-in-swift
         */
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.timerStart -= 1
            self.imageStart.removeFromSuperview()
            switch self.timerStart {
            case 4:
                self.imageStart = UIImageView(image: UIImage(named: "3"))
            case 3:
                self.imageStart = UIImageView(image: UIImage(named: "2"))
            case 2:
                self.imageStart = UIImageView(image: UIImage(named: "1"))
            case 1:
                self.imageStart = UIImageView(image: UIImage(named: "go"))
            case 0:
                self.timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(GameView.updateMainView), userInfo: nil, repeats: true)
                return
            default:
                ()
            }
            self.addSubview(self.imageStart)
            self.DessineDansFormat(f: self.size.size)
            self.timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(GameView.startTimer), userInfo: nil, repeats: true)
            

        })
        
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.DessineDansFormat(f: rect.size)
        
        
    }
    
    
    func updateMainView(){
        
        /* Déplacement de Mario */
        if(marioLeft){
            marioX = marioX - DEPLACEMENT
            if(marioX < 75){
                marioX = 75
            }
            
        }
        if(marioRight){
            marioX = marioX + DEPLACEMENT
            if(marioX > (Double(size.width) - 160)){
                marioX = Double(size.width) - 160
            }
        }
        
        if(marioRight && marioLeft){
            marioFire = true
        }else{
            marioFire = false
        }
        
        /* Mario tire des bouboules */
        if(marioFire){
            let tmpMarioFire = RocketBullet(marioFire: size.size, x: Int(marioX), y: Int(marioY+(tailleMario/2)))
            var collision = false
            for marioFire in tabMarioBullet{
                let tmpBulletCol = (marioFire as! RocketBullet)
                if((tmpMarioFire.y + tailleBoules) > tmpBulletCol.y && (tmpMarioFire.y + tailleBoules) < (tmpBulletCol.y + tailleBoules)){
                    collision = true;
                }
                if(tmpBulletCol.y + tailleBoules > tmpMarioFire.y && (tmpMarioFire.y + tailleBoules ) > (tmpBulletCol.y + tailleBoules)){
                    collision = true;
                }
            }
            if(collision == false && marioBulletValue.value > 0){
                //NSLog("COLLISION")
                marioBulletValue.value -= 1
                tabMarioBullet.append(tmpMarioFire)
                self.addSubview(tmpMarioFire)
                let url = Bundle.main.url(forResource: String.init(format: "laser_gun"), withExtension: "mp3")
                tmpMarioFire.playSound(url: url!)
            }
           
        }
        
        
        
        /* Ajouts de bullets */
        if(tabBullet.count < NIVEAU){
            
            let tmpRocket = RocketBullet(posRocket: size.size, deplacement : Int(DEPLACEMENT))
            //On estime qu'il peut y avoir une collision
            var collision = false
            for bulletCol in tabBullet{
                let tmpBulletCol = (bulletCol as! RocketBullet)
                if((tmpRocket.y + 40) > tmpBulletCol.y && (tmpRocket.y + 40) < (tmpBulletCol.y + 40) ){
                    collision = true;
                    //NSLog("COLLISION")
                }
                if(tmpBulletCol.y + 40 > tmpRocket.y && (tmpRocket.y + 40 ) > (tmpBulletCol.y + 40)){
                    collision = true;
                    //NSLog("COLLISION")
                }
            }
            if(collision == false){
                //NSLog("COLLISION")
                tabBullet.append(tmpRocket)
                self.addSubview(tmpRocket)
            }
        
        }
        
        
        /* Génération des déplacements de bullets */
        for bullet in tabBullet{
            (bullet as! RocketBullet).changeLocation()
        }
        
        /* Génération des déplacements des bouboules */
        for bouboule in tabMarioBullet{
            (bouboule as! RocketBullet).changeLocationFire()
        }
        
        /* Vérification collision avec Mario */
        var collision = false
        var i = 0;
        for bullet in tabBullet{
            let tmpBulletCol = (bullet as! RocketBullet)
            
            collision = false
            
            
            
            /*
            
            if((tmpBulletCol.y - 40) == marioY &&
                tmpBulletCol.x > marioX &&
                tmpBulletCol.x < (marioX + 70)){
                collision = true
            }
            */
            
            /*
             * C'est ce cas.
             * [B]
             *  [ M ]
             */
            if((tmpBulletCol.y - 40) == marioY && (marioX + tailleMario) > (tmpBulletCol.x + 50) && marioX  < (tmpBulletCol.x + 50)){
                NSLog("CAS 1");
                collision = true
            }
            
            /*
             * C'est ce cas.
             *     [B]
             *  [ M ]
             */
            if((tmpBulletCol.y - 40) == marioY && (marioX + tailleMario) < (tmpBulletCol.x+50) && (marioX + tailleMario) > tmpBulletCol.x){
                NSLog("CAS 2");
                collision = true
            }
            
            /* 
            * C'est ce cas.
            *   [B]
            *  [ M ]
            */
            if((tmpBulletCol.y - 40) == marioY && (marioX + tailleMario) > tmpBulletCol.x && (marioX + tailleMario) < (tmpBulletCol.x + 50)){
                 NSLog("CAS 3");
                 collision = true
            }
            
            /*
            * C'est ce cas
            * [   ]
            * | M[B]
            * [   ]
            */
            if((tmpBulletCol.y - 40 > marioY) && (tmpBulletCol.y - 40) < (marioY+tailleMario)
                && tmpBulletCol.x > marioX && tmpBulletCol.x < (marioX + tailleMario)){
                 NSLog("CAS 4");
                collision = true
            }
            
            
            /*
             * C'est ce cas
             * [   ]
             *[B]M |
             * [   ]
             */
            if((tmpBulletCol.y - 40 > marioY) && (tmpBulletCol.y - 40) < (marioY+tailleMario)
                && (marioX) > (tmpBulletCol.x + 50) && (marioX + tailleMario) < (tmpBulletCol.x + 50)){
                 NSLog("CAS 5");
                collision = true
            }
            
            if((tmpBulletCol.y - 40) > marioY && tmpBulletCol.y < marioY && tmpBulletCol.x > marioX && tmpBulletCol.x < (marioX + tailleMario)){
                NSLog("CAS 6")
                collision = true
            }
            
            if(collision){
                tabBullet.remove(at: i)
                tmpBulletCol.removeFromSuperview();
                i -= 1;
                nbBulletTotal -= 1
                if(!marioCollision){
                    if(tmpBulletCol.bonus == true){
                        marioVie += 1
                        labelVie.setTitle(String(format: " Vie : %d ", marioVie),for: .normal)
                    }else{
                        marioVie -= 1
                        marioCollision = true
                        mario.removeFromSuperview()
                        mario = UIImageView(image: UIImage(named: "drunk"))
                        self.addSubview(mario)
                        
                        if(marioVie != 0){
                            Timer.scheduledTimer(timeInterval: Double(6/NIVEAU), target: self , selector: #selector(GameView.updateMario), userInfo: nil, repeats: false)
                        }else{
                            btnContinue.setTitle(" Continue? ", for: .normal)
                            btnContinue.setTitle("  ", for: .highlighted)
                            btnContinue.isEnabled = true
                            timer.invalidate()
                            
                        }
                    }
                    labelVie.setTitle(String(format: " Vie : %d ", marioVie),for: .normal)
                    self.DessineDansFormat(f: size.size)
                }
            }
            i += 1
        }



        /* Vérification des bullets hors de l'écran et bullet contre bullet */
        i = 0;
        for bullet in tabBullet{
            
            let tmpBullet = (bullet as! RocketBullet)

            if (tmpBullet.life <= 0){
                tabBullet.remove(at: i)
                bullet.removeFromSuperview();
                i -= 1;
                nbBulletTotal += 1
                labelScore.setTitle(String(format: "  Score : %d ", nbBulletTotal),for: .normal)
            }
            if (tmpBullet.y > Double(size.size.height+100)){ //Hors écran
                tabBullet.remove(at: i)
                bullet.removeFromSuperview();
                i -= 1;
                nbBulletTotal += 1
                labelScore.setTitle(String(format: "  Score : %d ", nbBulletTotal),for: .normal)
                //NSLog("REMOVE")
            }else if (tmpBullet.x  < 100) ||         //Collision contre les murs
                    tmpBullet.x > (Double(size.size.width ) - 100.0){
                    tmpBullet.changeXaxis();
            }else{                                  //Collision entre les éléments
                for bulletCol in tabBullet{
                    
                    let tmpBulletCol = (bulletCol as! RocketBullet)
                    
                    if((tmpBullet.x + 40) > tmpBulletCol.x  && tmpBullet.y < (tmpBulletCol.y + 50)){
                        tmpBullet.changeXaxis()
                    }
                    if(tmpBulletCol.x < tmpBullet.x + 40){
                        tmpBulletCol.changeXaxis()
                    }
                }
            }
            
            i += 1
        }
        
        i = 0
        
        /* Vérification des bouboules hors de l'écran */
        for bullet in tabMarioBullet{
            let tmpBullet = (bullet as! RocketBullet)

            if (tmpBullet.y < Double(-100)){ //Hors écran
                tabMarioBullet.remove(at: i)
                bullet.removeFromSuperview();
                i -= 1
            }
            i += 1
        }
        /* Vérification entre bullet et bouboules */
        i = 0
        for bullet in tabMarioBullet{
            let b = (bullet as! RocketBullet)
            if(b.explosion == true && b.tooManyTime <= 0){
                //tabMarioBullet.remove(at: i)
                b.removeFromSuperview()
                //i -= 1
            }else if (b.explosion){
                b.tooManyTime -= 1
                print("Val : %d",b.tooManyTime)
            }
            
            for bulletCol in tabBullet{
                collision = false
                let bt = (bulletCol as! RocketBullet)
                
                if((b.y + 10) > bt.y && (b.y + 10) < (bt.y + 10)){
                    if(b.x >= bt.x && b.x < (bt.x+50) ){
                        collision = true;
                       
                    }else if(b.x < bt.x && b.x+30 > bt.x && b.x + 30 < bt.x + 50){
                        collision = true;
                        
                    }
                }
                if(bt.y + 10 > b.y && (b.y + 10 ) > (bt.y + 10)){
                    if(b.x >= bt.x && b.x < (bt.x+50) ){
                        collision = true;
                       
                    }else if(b.x < bt.x && b.x+30 > bt.x && b.x + 30 < bt.x + 50){
                        collision = true;
                         
                    }
                }
                
                
                if(collision && b.tooManyTime > 0)
                {
                    b.explosionFire()
                    bt.kaboom()
                }
            }
            i += 1
        }
        
        
        if(nbBulletTotal % 5 == 0){
            marioBulletValue.value += 0.03
        }
        
        
        /* Mise en place de l'affichage */
        self.DessineDansFormat(f: size.size)
    }
    
    func updateMario(){
        
        mario.removeFromSuperview()
        mario = UIImageView(image: UIImage(named: "mario"))
        addSubview(mario)
        marioCollision = false
        DessineDansFormat(f: UIScreen.main.bounds.size)
    }
    
    func DessineDansFormat(f : CGSize) -> Void {
        
        marioY = (Double(f.height) - tailleMario)
        mario.frame = CGRect(x: CGFloat(marioX), y: CGFloat(marioY), width: CGFloat(tailleMario), height: CGFloat(tailleMario))
        imageStart.frame = CGRect(x: f.width/2 - 100/2, y: f.height/2 - 100/2, width: 100, height: 100)
        btnG.frame = CGRect(x: 0, y: 0, width: f.width/2, height: f.height)
        btnD.frame = CGRect(x: f.width/2, y: 0, width: f.width/2, height: f.height)
        
        /* Les ennemies */
        for bullet in tabBullet{
            let myBullet =  (bullet as! RocketBullet)
            
            myBullet.frame = CGRect(x: myBullet.x-tailleEnemies,
                                    y: myBullet.y-tailleEnemies,
                                    width: tailleEnemies,
                                    height: tailleEnemies)
            if(myBullet.bonus == true){
                myBullet.transform = CGAffineTransform(rotationAngle: -1.58)
            }
        }
        /* les boules */
        for bullet in tabMarioBullet{
            let myBullet =  (bullet as! RocketBullet)
            
            if(myBullet.explosion == true){
                myBullet.frame = CGRect(x: myBullet.x-2*tailleEnemies,
                                        y: myBullet.y-2*tailleEnemies,
                                        width: 2*tailleEnemies,
                                        height: 2*tailleEnemies)
            }else{
                
                myBullet.frame = CGRect(x: myBullet.x-tailleBoules,
                                    y: myBullet.y-tailleBoules,
                                    width: tailleBoules,
                                    height: tailleBoules)
            }
        }
        
        labelVie.frame = CGRect(x: 10, y: 10, width: 2*tailleEnemies, height: tailleEnemies)
        labelScore.frame = CGRect(x: 10, y: (tailleEnemies + 20), width: 2*tailleEnemies, height: tailleEnemies)
        btnContinue.frame = CGRect(x: Double(f.width) - 2*tailleEnemies - 10.0, y: 10, width: 2*tailleEnemies, height: tailleEnemies)
        
        marioBulletValue.frame = CGRect(x:Double(f.width) - tailleMario, y: tailleMario, width : tailleEnemies,height: Double(f.height) - tailleMario)
        

        
    }
    
    func generateEnvironement(f : CGSize) -> Void{
        let Hauteur = f.height / 20
        var i = 0
        var side1 = false
        var side2 = false
        
        let grass = UIImageView(image: #imageLiteral(resourceName: "anime_grass4"))
        
        var effectV = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongVerticalAxis)
        effectV.minimumRelativeValue = -tailleMario
        effectV.maximumRelativeValue = tailleMario
        
        var effectH = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongHorizontalAxis)
        effectH.minimumRelativeValue = -tailleMario
        effectH.maximumRelativeValue = tailleMario
        
        grass.addMotionEffect(effectV)
        grass.addMotionEffect(effectH)
        grass.frame = CGRect(x: -tailleMario, y: -tailleMario, width: Double(f.width+100), height: Double(f.height+100))
        self.addSubview(grass)
        
        while (i != 21) {
            var randomPositionStart = arc4random_uniform(UInt32(5 - 1)) + 1
            
            effectV = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongVerticalAxis)
            effectH = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongHorizontalAxis)
            
            effectH.minimumRelativeValue = -1 * Int((arc4random_uniform(UInt32(70 - 30)) + 30))
            effectH.maximumRelativeValue = 1 * (arc4random_uniform(UInt32(70 - 30)) + 30)
            effectV.minimumRelativeValue = -1  * Int((arc4random_uniform(UInt32(70 - 30)) + 30))
            effectV.maximumRelativeValue = 1  * (arc4random_uniform(UInt32(70 - 30)) + 30)
            
            
            var imgtemp = UIImageView(image: UIImage(named: NSString.init(format: "t%d",randomPositionStart) as String))
            imgtemp.addMotionEffect(effectH)
            imgtemp.addMotionEffect(effectV)
            
            self.addSubview(imgtemp)
            if(side1){
                imgtemp.frame = CGRect(x: -50 + Int(arc4random_uniform(UInt32(25 - 10))+10),
                                       y: i*Int(Hauteur) - 30,
                                       width: 75,
                                       height: 75)
                side1 = false
            }else{
                imgtemp.frame = CGRect(x: -15 + Int(arc4random_uniform(UInt32(50 - 10))+10),
                                       y: i*Int(Hauteur) - 30 ,
                                       width: 75,
                                       height: 75)
                side1 = true
            }
            
            randomPositionStart = arc4random_uniform(UInt32(5 - 1)) + 1
            imgtemp = UIImageView(image: UIImage(named: NSString.init(format: "t%d",randomPositionStart) as String))
            
            imgtemp.addMotionEffect(effectH)
            imgtemp.addMotionEffect(effectV)
            self.addSubview(imgtemp)
            
            if(side2){
                imgtemp.frame = CGRect(x: Int(f.width) - 80 + (-1)*(Int(arc4random_uniform(UInt32(50 - 10))+10)),
                                       y: i*Int(Hauteur) - 30,
                                       width: 75,
                                       height: 75)
                side2 = false
            }else{
                imgtemp.frame = CGRect(x: Int(f.width) - 50 + (-1)*(Int(arc4random_uniform(UInt32(20 - 10))+10)) ,
                                       y: i*Int(Hauteur) - 30,
                                       width: 75,
                                       height: 75)
                side2 = true
            }
            
            i += 1
        }
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
}

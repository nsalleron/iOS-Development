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
    let labelVie = UILabel()
    let labelScore = UILabel()
    let btnG = UIButton()
    let btnD = UIButton()
    let btnContinue = UIButton()
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
    var marioVie = 3
    var timer = Timer()
    var timerBullet = 0
    
    

    
    var tabBullet = Array<UIImageView>()
    
    init(frame : CGRect, val : Int){
        super.init(frame: frame);
        //NSLog("Difficulty : %d",val)
        self.NIVEAU = val
        if(NIVEAU == 4){
            self.DEPLACEMENT = 6.5
        }else if(NIVEAU == 5){
            self.DEPLACEMENT = 7
        }else if(NIVEAU == 6){
            self.DEPLACEMENT = 7.5
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
        
        labelVie.text = String(format: "     Vie : %d", marioVie)
        labelVie.textColor = UIColor.white
        labelVie.layer.cornerRadius = 10
        labelVie.clipsToBounds = true
        labelVie.layer.borderWidth = 5
        labelVie.layer.borderColor = UIColor.black.cgColor
        labelVie.backgroundColor = UIColor.red
        
        
        labelScore.text = String(format: "  Score : %d", nbBulletTotal)
        labelScore.textColor = UIColor.white
        labelScore.layer.cornerRadius = 10
        labelScore.clipsToBounds = true
        labelScore.layer.borderWidth = 5
        labelScore.layer.borderColor = UIColor.black.cgColor
        labelScore.backgroundColor = UIColor.red
       
        
        btnContinue.setTitle(String(format: " Continue? ", marioVie), for: .normal)
        btnContinue.setTitle(String(format: "  ", marioVie), for: .highlighted)
        btnContinue.setTitleColor(UIColor.white, for: .normal)
        btnContinue.layer.cornerRadius = 10
        btnContinue.clipsToBounds = true
        btnContinue.layer.borderWidth = 5
        btnContinue.layer.borderColor = UIColor.black.cgColor
        btnContinue.backgroundColor = UIColor.red
        btnContinue.isHidden = true
        btnContinue.addTarget(super.superview, action: #selector(ViewController.endGame), for: .touchUpInside)
        
        
        self.generateEnvironement(f: frame.size)
        self.addSubview(btnG)
        self.addSubview(btnD)
        self.addSubview(labelVie)
        self.addSubview(labelScore)
        self.addSubview(btnContinue)
        self.addSubview(mario)
        
        marioX = Double((frame.size.width / 2) - (70.0/2.0))
        
        tabBullet.append(RocketBullet(posRocket: frame.size, deplacement : Int(DEPLACEMENT)))
        
        self.addSubview(tabBullet[0])
        
        self.DessineDansFormat(f: frame.size)
        timer = Timer.scheduledTimer(timeInterval: 0.02, target: self, selector: #selector(GameView.updateMainView), userInfo: nil, repeats: true)
        
       
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
        /* Ajouts de bullets */
        if(tabBullet.count < NIVEAU && timerBullet == 0){
            //timerBullet = 100
            let  tmpRocket = RocketBullet(posRocket: size.size, deplacement : Int(DEPLACEMENT))
            //On estime qu'il peut y avoir une collision
            var collision = false
            for bulletCol in tabBullet{
                let tmpBulletCol = (bulletCol as! RocketBullet)
                if((tmpRocket.x + 40) > tmpBulletCol.x && (tmpRocket.x + 40) < (tmpBulletCol.x + 40) ){
                    collision = true;
                }
                if(tmpBulletCol.x + 40 > tmpRocket.x && (tmpRocket.x + 40 ) > (tmpBulletCol.x + 40)){
                    collision = true;
                }
            }
            if(collision == false){
                tabBullet.append(tmpRocket)
                self.addSubview(tmpRocket)
            }
        
        }
        
        
        /* Génération des déplacements de bullets */
        for bullet in tabBullet{
            (bullet as! RocketBullet).changeLocation()
        }
        
        
        
        /* Vérification collision avec Mario */
        var collision = false
        var i = 0;
        for bullet in tabBullet{
            let tmpBulletCol = (bullet as! RocketBullet)
            
            collision = false
            if((tmpBulletCol.y - 40) == marioY && tmpBulletCol.x > marioX && tmpBulletCol.x < (marioX + 70)){
                collision = true
            }
            
            if((tmpBulletCol.y - 40) == marioY && (marioX + 70) > tmpBulletCol.x && (marioX + 70) < (tmpBulletCol.x + 50)){
                 collision = true
            }
            
            if((tmpBulletCol.y - 40 > marioY) && (tmpBulletCol.y - 40) < (marioY+70)
                && tmpBulletCol.x > marioX && tmpBulletCol.x < (marioX + 70)){
                collision = true
            }
            
            if((tmpBulletCol.y - 40 > marioY) && (tmpBulletCol.y - 40) < (marioY+70)
                && (marioX + 70) > tmpBulletCol.x && (marioX + 70) < (tmpBulletCol.x + 50)){
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
                        labelVie.text = String(format: "     Vie : %d", marioVie)
                    }else{
                        marioVie -= 1
                        marioCollision = true
                        mario.removeFromSuperview()
                        mario = UIImageView(image: UIImage(named: "drunk"))
                        self.addSubview(mario)
                        
                        if(marioVie != 0){
                            Timer.scheduledTimer(timeInterval: Double(6/NIVEAU), target: self , selector: #selector(GameView.updateMario), userInfo: nil, repeats: false)
                        }else{
                            timer.invalidate()
                            btnContinue.isHidden = false
                        }
                    }
                    labelVie.text = String(format: "     Vie : %d", marioVie)
                    self.DessineDansFormat(f: size.size)
                }
            }
            i += 1
        }



        /* Vérification des bullets hors de l'écran et bullet contre bullet */
        i = 0;
        for bullet in tabBullet{
            
            let tmpBullet = (bullet as! RocketBullet)

            if (tmpBullet.y > Double(size.size.height+50)){ //Hors écran
                tabBullet.remove(at: i)
                bullet.removeFromSuperview();
                i -= 1;
                nbBulletTotal += 1
                labelScore.text = String(format: "  Score : %d", nbBulletTotal)
                //NSLog("REMOVE")
            }else if (tmpBullet.x  < 100) ||         //Collision contre les murs
                    tmpBullet.x > (Double(size.size.width )-100.0){
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
                    
                    
                    //if((tmpBulletCol.x + 40)< tmpBulletCol.x || (tmpBullet.x + 40)< tmpBulletCol.x  )
                }
            }
            
            i += 1
            
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
        marioY = (Double(f.height) - 70)
        mario.frame = CGRect(x: CGFloat(marioX), y: CGFloat(marioY), width: 70, height: 70)
        btnG.frame = CGRect(x: 0, y: 0, width: f.width/2, height: f.height)
        btnD.frame = CGRect(x: f.width/2, y: 0, width: f.width/2, height: f.height)
        
        
        for bullet in tabBullet{
            let myBullet =  (bullet as! RocketBullet)
            myBullet.frame = CGRect(x: Int(myBullet.x)-50,
                                    y: Int(myBullet.y)-50,
                                    width: 50,
                                    height: 50)
        }
        
        labelVie.frame = CGRect(x: 10, y: 10, width: 100, height: 50)
        labelScore.frame = CGRect(x: 10, y: (10 + 60), width: 100, height: 50)
        btnContinue.frame = CGRect(x: f.width - 110, y: 10, width: 100, height: 50)
        
    }
    
    
    func generateEnvironement(f : CGSize) -> Void{
        let Hauteur = f.height / 20
        var i = 0
        var side1 = false
        var side2 = false
        
        let grass = UIImageView(image: #imageLiteral(resourceName: "anime_grass4"))
        
        var effectV = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongVerticalAxis)
        effectV.minimumRelativeValue = -70
        effectV.maximumRelativeValue = 70
        
        var effectH = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongHorizontalAxis)
        effectH.minimumRelativeValue = -70
        effectH.maximumRelativeValue = 70
        
        grass.addMotionEffect(effectV)
        grass.addMotionEffect(effectH)
        grass.frame = CGRect(x: -70, y: -70, width: f.width+100, height: f.height+100)
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

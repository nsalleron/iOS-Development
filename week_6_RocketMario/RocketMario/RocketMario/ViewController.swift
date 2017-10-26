//
//  ViewController.swift
//  RocketMario
//
//  Created by Nicolas Salleron on 22/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let hv = HomeView(frame : UIScreen.main.bounds)
    var tabScore = Array<String>()
    var tabJoueurs = Array<String>()
    var difficult: Int = 3;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view = hv;
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    func gotoHomeView(){
        let view = self.view as! ScoreView
        self.tabScore = view.tabScore
        self.tabJoueurs = view.tabJoueur
        let gv = HomeView(frame : UIScreen.main.bounds)
        self.view = gv
    }
    
    func gotoHomeViewFromConfig(){
        let view = self.view as! ConfigView
        difficult = view.currentDifficult
        //NSLog("difficulty view %d ",difficult);
        let gv = HomeView(frame : UIScreen.main.bounds)
        self.view = gv
    }
    
    func gotoGameViewFromScore(){
        let view = self.view as! ScoreView
        self.tabScore = view.tabScore
        self.tabJoueurs = view.tabJoueur
        var i = 0
        for string in self.tabJoueurs{
            if(string == "!???"){
                NSLog("AVANT => %@",string)
                self.tabJoueurs[i] = "-???"
                NSLog("APRES => %@",tabJoueurs[i])
            }
            i += 1
        }
        
        
        
        let gv = GameView(frame : UIScreen.main.bounds, val: difficult)
        self.view = gv
    }
    
    func gotoHomeViewFromScore(){
        let view = self.view as! ScoreView
        self.tabScore = view.tabScore
        self.tabJoueurs = view.tabJoueur
        var i = 0
        for string in self.tabJoueurs{
            if(string == "!???"){
                NSLog("AVANT => %@",string)
                self.tabJoueurs[i] = "-???"
                NSLog("APRES => %@",tabJoueurs[i])
            }
            i += 1
        }
        
        let gv = HomeView(frame : UIScreen.main.bounds)
        self.view = gv
    }
    
    
    func gotoGameView(){
        let gv = GameView(frame : UIScreen.main.bounds, val: difficult)
        self.view = gv
    }
    
    func gotoScoreView(){
        let sv = ScoreView(frame: UIScreen.main.bounds,tabJoueur: tabJoueurs, tabScore: tabScore, finDePartie: false)
        self.view = sv
    }
    
    func gotoConfigView(){
        let cv = ConfigView(frame : UIScreen.main.bounds)
        self.view = cv
    }
    
    public func endGame(){
        let view = self.view as! GameView
        tabJoueurs.append("!???")
        tabScore.append(String(format: "%d", view.nbBulletTotal))
        let sv = ScoreView(frame: UIScreen.main.bounds,tabJoueur: tabJoueurs, tabScore: tabScore, finDePartie: true)
        self.view = sv
        //NSLog("Mario !")
    }
    
    
    
    func marioLeftPosition(){
        let view = self.view as! GameView
        if(view.marioLeft){
            view.marioLeft = false
        }else{
            view.marioLeft = true
        }
    }
    
    func marioRightPosition(){
        let view = self.view as! GameView
        if(view.marioRight){
            view.marioRight = false
        }else{
            view.marioRight = true
        }
    }
    
    
    override var shouldAutorotate: Bool{
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .landscape
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


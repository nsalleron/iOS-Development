//
//  ViewController.swift
//  QuizzProg
//
//  Created by Nicolas Salleron on 09/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var QR : QuestionsReponses? = nil
    var Q:String = ""
    var R:String = ""
    var index = 0
    var maxIndex = 0
    var reponseVue = [-1]


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ecran = UIScreen.main
        let rect = ecran.bounds
        let v = QuizzView(frame : rect)
        self.view = v
        
        QR = QuestionsReponses()
        maxIndex = (QR?.getNbMax())!
        Q = (QR?.getQuestion(index: index))![1];
        
        NSLog("Total : \(reponseVue)")
        self.affichage()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeMode(_ sender: Any) {
        NSLog("PASSAGE CHANGEMODE")
        if((QR?.getQuestion(index: index))![0] == "HARD" &&
            (self.view as! QuizzView).swtchBalaise.isOn == false){
            self.changeQuestion(nil);
        }
        NSLog("Valeur de switch \((self.view as! QuizzView).swtchBalaise.isOn)");
        
    }
    
    func changeQuestion(_ sender: UIButton?) {
        var rechQuestion = false
        
        if(sender === (self.view as! QuizzView).imgD){
            index += 1
           

            
            UIView.animate(withDuration: 7.0, animations: {
                let animation = CATransition()
                animation.duration = 1.2
                animation.startProgress = 0.0
                animation.endProgress = 1
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                animation.type = "pageCurl"
                animation.subtype = "fromRight"
                animation.isRemovedOnCompletion = true
                animation.fillMode = "extended"
                self.view.layer.add(animation, forKey: "pageFlipAnimation")
            })
            
           
            
            
        }else if(sender === (self.view as! QuizzView).imgG){
            index -= 1
            if(index < 0){
                index = maxIndex - 1
            }
            NSLog("Valeur de index \(index)")
            UIView.animate(withDuration: 7.0, animations: {
                let animation = CATransition()
                animation.duration = 1.2
                animation.startProgress = 0.0
                animation.endProgress = 1
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                animation.type = "pageCurl"
                animation.subtype = "fromLeft"
                animation.isRemovedOnCompletion = true
                animation.fillMode = "extended"
                self.view.layer.add(animation, forKey: "pageFlipAnimation")
            })
        }else{
            index += 1 //Mode changement btn switch
            NSLog("Passage après switch")
        }
        
        index = index % maxIndex
        NSLog("Valeur de index après modulo \(index)")
        while (rechQuestion == false) {
            
            Q = (QR?.getQuestion(index: index))![0]
            if(!(self.view as! QuizzView).swtchBalaise.isOn){
                
                if(Q == "HARD"){
                    index = Int(arc4random_uniform(UInt32(12) - UInt32(0)))
                    NSLog("HARD DETECTED \(index)")
                }else{
                    NSLog("SOFT DETECTED")
                    rechQuestion = true;
                    Q = (QR?.getQuestion(index: index))![1]
                }
            }else{
                
                rechQuestion = true;
                Q = (QR?.getQuestion(index: index))![1]
            }
        }
        
        self.affichage()
    }
    func afficheReponse(_ sender: UIButton) {
        NSLog("ReponseVue : \(reponseVue)")
        if(reponseVue.contains(index) == false){
            QR?.incNbQuestion()
            reponseVue.append(index);
        }
        self.affichage()
    }
    
    func affichage(){
        (self.view as! QuizzView).labelQvariable.text = Q
        
        if(reponseVue.contains(index)){
            (self.view as! QuizzView).labelRvariable.text = (QR?.getReponse(question: index))!
        }else{
            (self.view as! QuizzView).labelRvariable.text = ""
        }
        
        if((self.view as! QuizzView).swtchBalaise.isOn && (QR?.getQuestion(index: index))![0] == "HARD"){
            (self.view as! QuizzView).labelQvariable.textColor = UIColor.red
        }else{
            (self.view as! QuizzView).labelQvariable.textColor = UIColor.blue
        }
        (self.view as! QuizzView).labelRepVu.text = "Réponses vues : \((QR?.getNbReponseVue())!)"
    }



}


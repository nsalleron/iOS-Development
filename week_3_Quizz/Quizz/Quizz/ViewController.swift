//
//  ViewController.swift
//  Quizz
//
//  Created by Nicolas Salleron on 01/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelReponse: UILabel!
    @IBOutlet weak var switchBalaise: UISwitch!
    @IBOutlet weak var labelReponseVue: UILabel!
    @IBOutlet weak var btnG: UIButton!
    @IBOutlet weak var btnD: UIButton!
    var QR : QuestionsReponses? = nil
    var Q:String = ""
    var R:String = ""
    var index = 0
    var maxIndex = 0
    var reponseVue = [-1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

    @IBAction func changeMode(_ sender: Any) {
        NSLog("PASSAGE CHANGEMODE")
        if((QR?.getQuestion(index: index))![0] == "HARD" && switchBalaise.isOn == false){
            self.changeQuestion(nil);
        }
        
    }
    
    @IBAction func changeQuestion(_ sender: UIButton?) {
        var rechQuestion = false
        
        if(sender === btnD){
            index += 1
        }else if(sender === btnG){
            index -= 1
            if(index < 0){
                index = maxIndex - 1
            }
            NSLog("Valeur de index \(index)")
        }else{
            index += 1 //Mode changement btn switch
        }
        
        index = index % maxIndex
        NSLog("Valeur de index après modulo \(index)")
        while (rechQuestion == false) {
           
            Q = (QR?.getQuestion(index: index))![0]
            if(!switchBalaise .isOn){
                
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
    @IBAction func afficheReponse(_ sender: UIButton) {
        NSLog("ReponseVue : \(reponseVue)")
        if(reponseVue.contains(index) == false){
            QR?.incNbQuestion()
            reponseVue.append(index);
        }
        
        self.affichage()
        return
    }
    
    func affichage(){
        labelQuestion.text = Q
        
        if(reponseVue.contains(index)){
            labelReponse.text = (QR?.getReponse(question: index))!
        }else{
            labelReponse.text = ""
        }
        
        if(switchBalaise.isOn && (QR?.getQuestion(index: index))![0] == "HARD"){
            labelQuestion.textColor = UIColor.red
        }else{
            labelQuestion.textColor = UIColor.blue
        }
        labelReponseVue.text = "Réponses vues : \((QR?.getNbReponseVue())!)"
        
    }

}


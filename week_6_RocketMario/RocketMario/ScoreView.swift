//
//  ScoreView.swift
//  RocketMario
//
//  Created by Nicolas Salleron on 22/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit

class ScoreView: UIView, UITextFieldDelegate {
    
    
    
    let fondImage = UIImageView(image: UIImage(named: "fond-asteroides"))
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
    var blurEffectView = UIVisualEffectView()
    
    let btnRetour = UIButton()
    let btnRecommencer = UIButton()
    let tfScore = UITextField()
    
    let labelScore = UILabel()
    let labelScoreAffichage = UILabel()
    var tabScore = Array<String>()
    var tabJoueur = Array<String>()
    var tabtemp = Array<String>()
    
    var finDePartie = false
    var f = CGRect();
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     */
    
    init(frame : CGRect, tabJoueur: Array<String>,tabScore: Array<String>, finDePartie: Bool) {
        super.init(frame: frame);
        
        
        fondImage.backgroundColor = UIColor.white
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.tabScore = tabScore;
        self.tabJoueur = tabJoueur;
        self.finDePartie = finDePartie;
        self.frame = frame;
        
        //NSLog("TAILLE : %d",self.tabScore.count);
        
        /* Configuration du premier button */
        btnRetour.setTitle(" => Accueil", for: .normal)
        btnRetour.setTitle("", for: .highlighted)
        btnRetour.layer.cornerRadius = 10
        btnRetour.clipsToBounds = true
        btnRetour.layer.borderWidth = 5
        btnRetour.layer.borderColor = UIColor.black.cgColor
        btnRetour.backgroundColor = UIColor.red
        btnRetour.tintColor = UIColor.white
        btnRetour.addTarget(self.superview, action: #selector(ViewController.gotoHomeViewFromScore), for: .touchUpInside)
        
        labelScore.text = "Meilleurs scores"
        labelScore.textColor = UIColor.black
        labelScore.textAlignment = NSTextAlignment.center
        labelScore.font = UIFont.init(name: "Optima", size: 20)
        
        labelScoreAffichage.text = ""
        labelScoreAffichage.textColor = UIColor.black
        labelScoreAffichage.textAlignment = NSTextAlignment.center
        labelScoreAffichage.numberOfLines = 6
        labelScoreAffichage.font = UIFont.init(name: "Optima", size: 20)
        
        
        var i = 0
        if(tabScore.count == 0 || tabJoueur.count == 0){
            
            while i != 4 {
                labelScoreAffichage.text = labelScoreAffichage.text!+"??? : 0\n"
                i += 1
            }
        }else{
            for string in tabScore {
                if (i == 4){
                    break;
                }
                if(self.tabJoueur[i] == "!???" || self.tabJoueur[i] == "-???"){
                    
                    labelScoreAffichage.text = labelScoreAffichage.text! + "???" + " : "+string+"\n"
                }else{
                    labelScoreAffichage.text = labelScoreAffichage.text! + self.tabJoueur[i] + " : "+string+"\n"
                    
                }
                i += 1
            }
        }
        
        
        
        
        /* Configuration du button recommencer */
        if(finDePartie){
            btnRecommencer.setTitle(" <= Play ! ", for: .normal)
            btnRecommencer.setTitle("", for: .highlighted)
            btnRecommencer.layer.cornerRadius = 10
            btnRecommencer.clipsToBounds = true
            btnRecommencer.layer.borderWidth = 5
            btnRecommencer.layer.borderColor = UIColor.black.cgColor
            btnRecommencer.backgroundColor = UIColor.red
            btnRecommencer.tintColor = UIColor.white
            btnRecommencer.addTarget(self.superview, action: #selector(ViewController.gotoGameViewFromScore), for: .touchUpInside)
            
            tfScore.backgroundColor = UIColor.white
            tfScore.placeholder = "Entrez votre score ici :)"
            tfScore.font = UIFont.init(name: "Optima", size: 15)
            tfScore.borderStyle = UITextBorderStyle.roundedRect
            tfScore.autocorrectionType = UITextAutocorrectionType.no
            tfScore.keyboardType = UIKeyboardType.default
            tfScore.returnKeyType = UIReturnKeyType.done
            tfScore.clearButtonMode = UITextFieldViewMode.whileEditing;
            tfScore.contentVerticalAlignment = UIControlContentVerticalAlignment.center
            tfScore.delegate = self
            //tfScore.keyboardType = .asci
        }else{
            tfScore.isHidden = true
        }
        
        self.addSubview(fondImage)
        self.addSubview(blurEffectView)
        self.addSubview(labelScore)
        self.addSubview(btnRetour)
        self.addSubview(btnRecommencer)
        self.addSubview(tfScore)
        self.addSubview(labelScoreAffichage)
        self.DessineDansFormat(f: f.size, editingTf: false)
        
        
    }
    
    
    
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.DessineDansFormat(f: rect.size,editingTf: false)
        
        
    }
    
    func DessineDansFormat(f : CGSize,editingTf : Bool) -> Void {
        let size = Int(f.width/3) - 30
        if(editingTf == true){
            fondImage.frame = CGRect(x: 0, y: 0, width: f.width, height: f.height)
            blurEffectView.frame = CGRect(x: 0, y: 0, width: f.width, height: f.height)
            btnRetour.frame = CGRect(x: Int(f.width) - Int(Double(size)/1.4), y: Int(f.height/2) - size/2, width: 110, height: 70)
            labelScoreAffichage.frame = CGRect(x: (f.width/2)-75, y: 90 - 200, width: 150, height: 140)
            btnRecommencer.frame = CGRect(x: 10, y: Int(f.height/2) - size/2, width: 100, height: 70)
            if(finDePartie){
                tfScore.frame = CGRect(x: Int(f.width/2)-200/2, y: Int(f.height/2) - size/2, width: 200, height: 70)
            }
        }else{
            fondImage.frame = CGRect(x: 0, y: 0, width: f.width, height: f.height)
            blurEffectView.frame = CGRect(x: 0, y: 0, width: f.width, height: f.height)
            btnRetour.frame = CGRect(x: Int(f.width) - Int(Double(size)/1.4), y: Int(f.height) - size/2, width: 110, height: 70)
            labelScoreAffichage.frame = CGRect(x: (f.width/2)-75, y: 90, width: 150, height: 140)
            btnRecommencer.frame = CGRect(x: 10, y: Int(f.height) - size/2, width: 100, height: 70)
            labelScore.frame = CGRect(x: (f.width/2)-75, y: 10, width: 150, height: 70)
            if(finDePartie){
                tfScore.frame = CGRect(x: Int(f.width/2)-200/2, y: Int(f.height) - size/2, width: 200, height: 70)
            }
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //print("TextField did end editing method called %@",textField.text!)
        let tmp = textField.text!
        labelScoreAffichage.text = ""
        var i = 0
        for string in tabScore {
            print(tmp)
            if (i == 5) {
                break
            }
            if(self.tabJoueur[i] == "!???"){
                self.tabJoueur[i] = tmp
            }
            if(self.tabJoueur[i] == "-???"){
                labelScoreAffichage.text = labelScoreAffichage.text! + "???" + " : "+string+"\n"
            }else{
                labelScoreAffichage.text = labelScoreAffichage.text! + self.tabJoueur[i] + " : "+string+"\n"
            }
            
            i += 1
            
        }
        self.DessineDansFormat(f: self.frame.size, editingTf: false)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //print("TextField should begin editing method called")
        self.DessineDansFormat(f: self.frame.size, editingTf: true)
        return true;
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        //print("TextField should clear method called")
        return true;
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //print("TextField should snd editing method called")
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //print("While entering the characters this method gets called")
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

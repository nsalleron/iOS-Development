//
//  QuizzView.swift
//  QuizzProg
//
//  Created by Nicolas Salleron on 09/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit

class QuizzView: UIView {
    
    public let imgG = UIButton();
    public let imgD = UIButton();
    public let btnRep = UIButton();
    public let labelQ = UILabel();
    public let labelQvariable = UILabel();
    public let labelR = UILabel();
    public let labelRvariable = UILabel();
    public let labelRepVu = UILabel();
    public let swtchBalaise = UISwitch();
    public let labelBalaise = UILabel();
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgG.setBackgroundImage(#imageLiteral(resourceName: "gauche"), for: UIControlState.normal)
        imgD.setBackgroundImage(#imageLiteral(resourceName: "droite"), for: UIControlState.normal)
        btnRep.setTitle("La réponse", for: .normal)
        btnRep.setTitle("", for: .highlighted)
        btnRep.setTitleColor(UIColor.green, for: .normal)
        
        labelQ.text = "La question";
        labelQ.textAlignment = NSTextAlignment.center;
        labelQvariable.text = "nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now ";
        labelQvariable.textAlignment = NSTextAlignment.center;
        labelQvariable.numberOfLines = 3;
        labelR.text = "La réponse";
        labelR.textAlignment = NSTextAlignment.center;
        labelRvariable.text = "nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now nothing for now ";
        labelRvariable.textAlignment = NSTextAlignment.center;
        labelRvariable.numberOfLines = 3;
        labelRepVu.text = "Réponses vues : 0";
        swtchBalaise.isOn = false;
        labelBalaise.text = "mode balaise";
        labelBalaise.font = UIFont(name: "Helvetica", size: 10);
        
        //Mise en place des targets;
        imgG.addTarget(self.superview, action: #selector(ViewController.changeQuestion(_:)), for: UIControlEvents.touchDown)
        imgD.addTarget(self.superview, action: #selector(ViewController.changeQuestion(_:)), for: UIControlEvents.touchDown)
        btnRep.addTarget(self.superview, action: #selector(ViewController.afficheReponse(_:)), for: UIControlEvents.touchDown)
        swtchBalaise.addTarget(self.superview, action: #selector(ViewController.changeMode(_:)), for: UIControlEvents.valueChanged)
        
        
        self.backgroundColor = UIColor.white;
        
        self.addSubview(imgG);
        self.addSubview(imgD);
        self.addSubview(btnRep);
        self.addSubview(labelQ);
        self.addSubview(labelQvariable);
        self.addSubview(labelR);
        self.addSubview(labelRvariable);
        self.addSubview(labelRepVu);
        self.addSubview(labelBalaise);
        self.addSubview(swtchBalaise);
       
    }
 
 
    override func draw(_ rect: CGRect) {
        // Drawing code
        let padding = 20
        
        imgG.frame = CGRect(x: padding, y: padding*2, width: 50, height: 50);
        
        imgD.frame = CGRect(x: Int(rect.size.width) - 50 - padding, y: padding*2, width: 50, height: 50)
        
        btnRep.frame = CGRect(x: Int(rect.size.width / 4),
                              y: padding,
                              width: Int(rect.size.width/2), height: 50)
        
        labelQ.frame = CGRect(x: Int(rect.size.width / 4),
                              y: padding*3,
                              width: Int(rect.size.width/2), height: 50)
        
        labelQvariable.frame = CGRect(x: padding,
                             y: padding*5,
                             width: Int(rect.size.width) - 2*padding, height: Int(rect.size.height/5))
        
        labelR.frame = CGRect(x: Int(rect.size.width / 4),
                              y: padding*5 + Int(rect.size.height/5),
                              width: Int(rect.size.width/2), height: 50)
        
        labelRvariable.frame = CGRect(x: padding,
                                      y: padding*7 + Int(rect.size.height/5),
                                      width: Int(rect.size.width) - 2*padding, height: Int(rect.size.height/5))
        
        labelRepVu.frame = CGRect(x: padding,
                                  y: Int(rect.size.height - 50) ,
                                  width: Int(rect.size.width/2),
                                  height: 50);
        
        swtchBalaise.frame = CGRect(x: Int(rect.size.width - 50) - padding,
                                    y: Int(rect.size.height - 40) ,
                                    width: Int(rect.size.width/2),
                                    height: 50);
        
        labelBalaise.frame = CGRect(x: Int(rect.size.width - 50) - padding,
                                    y: Int(rect.size.height - 70) ,
                                    width: Int(rect.size.width/2),
                                    height: 50);
        
    }
 

}

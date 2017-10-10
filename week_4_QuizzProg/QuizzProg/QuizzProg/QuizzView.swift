//
//  QuizzView.swift
//  QuizzProg
//
//  Created by Nicolas Salleron on 09/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit

class QuizzView: UIView {
    
    let imgG = UIButton();
    let imgD = UIButton();
    let btnRep = UIButton();
    let labelQ = UILabel();
    let labelQvariable = UILabel();
    let labelR = UILabel();
    let labelRvariable = UILabel();
    let labelRepVu = UILabel();
    let swtchBalaise = UISwitch();
    let labelBalaise = UILabel();
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgG.setBackgroundImage(#imageLiteral(resourceName: "gauche"), for: UIControlState.normal)
        imgD.setBackgroundImage(#imageLiteral(resourceName: "droite"), for: UIControlState.normal)
        btnRep.setTitle("La réponse", for: UIControlState.normal)
        labelQ.text = "La question";
        labelQvariable.text = "nothing for now";
        labelR.text = "La réponse";
        labelRvariable.text = "nothing for now";
        
        self.backgroundColor = UIColor.white;
        
        self.addSubview(imgG);
        self.addSubview(imgD);
        self.addSubview(btnRep);
        self.addSubview(labelQ);
        self.addSubview(labelQvariable);
        self.addSubview(labelR);
        self.addSubview(labelRvariable);
       
    }
 
 
    override func draw(_ rect: CGRect) {
        // Drawing code
        let padding = 20
        imgG.frame = CGRect(x: padding, y: padding, width: 50, height: 50);
        imgD.frame = CGRect(x: Int(rect.size.width) - 50 - padding, y: padding, width: 50, height: 50)
        btnRep.frame = CGRect(x: Int(rect.size.width/4) + padding,
                              y: padding,
                              width: Int(rect.size.width/4), height: 50)
    }
 

}

//
//  MainView.swift
//  RocketMario
//
//  Created by Nicolas Salleron on 22/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit

class HomeView: UIView {

    
    
    let fondImage = UIImageView(image: UIImage(named: "fond-asteroides"))
    let btnPlay = UIButton()
    let btnScore = UIButton()
    let btnConfiguration = UIButton()
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
     */
    
    override init(frame : CGRect) {
        super.init(frame: frame);
        
        fondImage.backgroundColor = UIColor.white
        
        /* Configuration du premier button */
        btnPlay.setTitle("Play !", for: .normal)
        btnPlay.setTitle("", for: .highlighted)
        btnPlay.layer.cornerRadius = 10
        btnPlay.clipsToBounds = true
        btnPlay.layer.borderWidth = 5
        btnPlay.layer.borderColor = UIColor.black.cgColor
        btnPlay.backgroundColor = UIColor.red
        btnPlay.tintColor = UIColor.white
        btnPlay.addTarget(self.superview, action: #selector(ViewController.gotoGameView), for: .touchUpInside)
        
        /* Configuration du premier button */
        btnScore.setTitle("Score", for: .normal)
        btnScore.setTitle("", for: .highlighted)
        btnScore.layer.cornerRadius = 10
        btnScore.clipsToBounds = true
        btnScore.layer.borderWidth = 5
        btnScore.layer.borderColor = UIColor.black.cgColor
        btnScore.backgroundColor = UIColor.red
        btnScore.tintColor = UIColor.white
        btnScore.addTarget(self.superview, action: #selector(ViewController.gotoScoreView), for: .touchUpInside)
        
        /* Configuration du premier button */
        btnConfiguration.setTitle("Config.", for: .normal)
        btnConfiguration.setTitle("", for: .highlighted)
        btnConfiguration.layer.cornerRadius = 10
        btnConfiguration.clipsToBounds = true
        btnConfiguration.layer.borderWidth = 5
        btnConfiguration.layer.borderColor = UIColor.black.cgColor
        btnConfiguration.backgroundColor = UIColor.red
        btnConfiguration.tintColor = UIColor.white
        btnConfiguration.addTarget(self.superview, action: #selector(ViewController.gotoConfigView), for: .touchUpInside)
        
        self.addSubview(fondImage)
        self.addSubview(btnPlay)
        self.addSubview(btnScore)
        self.addSubview(btnConfiguration)
        
        self.DessineDansFormat(f: frame.size)
        
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.DessineDansFormat(f: rect.size)
        
        
    }
    
    func DessineDansFormat(f : CGSize) -> Void {
        let size = Int(f.width/5) - 30
        fondImage.frame = CGRect(x: 0, y: 0, width: f.width, height: f.height)
        btnPlay.frame = CGRect(x: Int(f.width) - Int(size) - 20, y: Int(f.height) - Int(size/2) - 20,  width: Int(size), height: Int(size/2))
        btnScore.frame = CGRect(x: 40 + size, y: Int(f.height) - Int(size/2) - 20, width: Int(size), height: Int(size/2))
        btnConfiguration.frame = CGRect(x: 20 , y: Int(f.height) - Int(size/2) - 20, width: Int(size), height: Int(size/2))
        
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

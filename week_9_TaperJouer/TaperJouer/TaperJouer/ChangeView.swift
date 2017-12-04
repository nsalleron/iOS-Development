//
//  DetailView.swift
//  MesActivites
//
//  Created by Nicolas Salleron on 08/11/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit


class ChangeView: UIView{

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let progressBar = UIProgressView()
    let labelStatus = UILabel()
    let labelName = UILabel()
    let labelNumber = UILabel()
    
    var controller : ChangeController?
    var playing = false
    var current = 1
    var maxMusique = 0;
    
    
    //TODO
    override init(frame: CGRect) {
        super.init(frame: frame)
       

        
        self.backgroundColor = UIColor.white
        
        
        /*gesture */
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(tabDetection(ugr:)))
        doubleTap.numberOfTapsRequired = 2
        self.addGestureRecognizer(doubleTap)
 
 
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeDetection(ugr:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeDetection(ugr:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.addGestureRecognizer(swipeRight)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDetection(ugr:)))
        swipeDown.direction = UISwipeGestureRecognizerDirection.down
        self.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeDetection(ugr:)))
        swipeUp.direction = UISwipeGestureRecognizerDirection.up
        self.addGestureRecognizer(swipeUp)
        
        
        
        progressBar.progress = 0
        progressBar.frame = CGRect(x: 10,
                                   y: Int((UIScreen.main.bounds.height/2)) - 20,
                                   width: Int(UIScreen.main.bounds.width - 20),
                                   height: 30)
        
        
        
        labelStatus.text = "À l'arrêt"
        labelStatus.frame = CGRect(x: 10,
                                   y: Int((UIScreen.main.bounds.height/3)) - 40,
                                   width: Int(UIScreen.main.bounds.width - 20),
                                   height: 30)
        labelStatus.textAlignment = NSTextAlignment.center
        
        
        labelName.text = ""
        labelName.frame = CGRect(x: 10,
                                   y: Int((UIScreen.main.bounds.height/3)),
                                   width: Int(UIScreen.main.bounds.width - 20),
                                   height: 30)
        labelName.textAlignment = NSTextAlignment.center
        
        
        labelNumber.text = "0/0"
        labelNumber.frame = CGRect(x: 10,
                                   y: Int((UIScreen.main.bounds.height/2)) + 20,
                                   width: Int(UIScreen.main.bounds.width - 20),
                                   height: 30)
        labelNumber.textAlignment = NSTextAlignment.center
        
        self.addSubview(progressBar)
        self.addSubview(labelNumber)
        self.addSubview(labelStatus)
        self.addSubview(labelName)
        
        
        /* DEBUG
        for view in self.subviews{
            view.layer.borderColor = UIColor.red.cgColor
            view.layer.borderWidth = 3
        }
        */
        
    }
    
    func swipeDetection(ugr : UISwipeGestureRecognizer){
        NSLog("SWIPE")
        switch ugr.direction {
        case UISwipeGestureRecognizerDirection.left:
            controller?.playerPrevious()
        case UISwipeGestureRecognizerDirection.right:
            controller?.playerNext()
        case UISwipeGestureRecognizerDirection.down:
            controller?.playerPrevious()
        case UISwipeGestureRecognizerDirection.up:
            controller?.playerNext()
        default:
            ()
        }
        
        
    }
    
    
    func tabDetection(ugr : UITapGestureRecognizer){
        NSLog("PLAYING")
        if(playing){
            controller?.playerStop()
            playing = false
        }else{
            controller?.playerStart()
            playing = true
        }
    }
    
    func setCountMusic(nb : Int){
        maxMusique = nb
        NSLog("MAXIMUM : \(nb)")
    }
    
    func updateMusic(){
        labelNumber.text = "\(current)/\(maxMusique)"
        progressBar.progress = Float(current)/Float(maxMusique)
    }
    
    func updateStatus(status: String){
         labelStatus.text = status
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
   
    
}

//
//  ConfigView.swift
//  RocketMario
//
//  Created by Nicolas Salleron on 22/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit

class ConfigView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    let fondImage = UIImageView(image: UIImage(named: "fond-asteroides"))
    let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
    var blurEffectView = UIVisualEffectView()
    let btnAccueil = UIButton()
    var pickerDifficult: UIPickerView = UIPickerView()
    let valDifficult: Array<String> = ["I'm too young to die","Can I play, Daddy?", "Don't hurt me", "Bring 'em on!", "Nightmare", "Ultra-Nightmare"]
    var currentDifficult : Int = 1
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     */
    
    override init(frame : CGRect) {
        super.init(frame: frame);
        
        fondImage.backgroundColor = UIColor.white
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        btnAccueil.setTitle("Accueil", for: .normal)
        btnAccueil.setTitle("", for: .highlighted)
        btnAccueil.layer.cornerRadius = 10
        btnAccueil.clipsToBounds = true
        btnAccueil.layer.borderWidth = 5
        btnAccueil.layer.borderColor = UIColor.black.cgColor
        btnAccueil.backgroundColor = UIColor.red
        btnAccueil.tintColor = UIColor.white
        btnAccueil.addTarget(self.superview, action: #selector(ViewController.gotoHomeViewFromConfig), for: .touchUpInside)
        
        self.pickerDifficult.dataSource = self
        self.pickerDifficult.delegate = self
        
        //self.pickerDifficult.backgroundColor = UIColor.black
        //self.pickerDifficult.layer.borderColor = UIColor.red.cgColor
        //self.pickerDifficult.layer.borderWidth = 1

        
        self.addSubview(fondImage)
        self.addSubview(blurEffectView)
        self.addSubview(pickerDifficult)
        self.addSubview(btnAccueil)
                
        self.DessineDansFormat(f: frame.size)
        
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.DessineDansFormat(f: rect.size)
        
        
    }
    
    func DessineDansFormat(f : CGSize) -> Void {
       
        let size = Int(f.width/5) - 30
        fondImage.frame = CGRect(x: 0, y: 0, width: f.width, height: f.height)
        blurEffectView.frame = CGRect(x: 0, y: 0, width: f.width, height: f.height)
        btnAccueil.frame = CGRect(x: Int(f.width) - Int(size) - 20, y: Int(f.height) - Int(size/2) - 20,  width: Int(size), height: Int(size/2))
        pickerDifficult.frame = CGRect(x: 0, y: 10, width: f.width, height: f.height)

    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 5
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
   
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return valDifficult.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return valDifficult[row] as String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        currentDifficult = row + 1
        //NSLog("CurrenDifficult : %d",currentDifficult)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

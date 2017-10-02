//
//  ViewController.swift
//  Dizainier
//
//  Created by Nicolas Salleron on 01/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scDizaines: UISegmentedControl!
    @IBOutlet weak var btnStepper: UIStepper!
    @IBOutlet weak var scUnites: UISegmentedControl!
    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet weak var sdSlider: UISlider!
    @IBOutlet weak var labelResult: UILabel!
    
    @IBOutlet weak var btnraz: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        labelResult.text = "";
        btnStepper.value = 0;
        btnSwitch.isOn = false;
        
        scDizaines.selectedSegmentIndex = Int(btnStepper.value/10.0);
        scUnites.selectedSegmentIndex = Int(fmod(btnStepper.value, 10.0));
    
        
    }

    @IBAction func actionSW(_ sender: Any) {
        self.affichageResult()
    }
    
    
    
    @IBAction func btnRAZ(_ sender: Any) {
        btnStepper.value = 0;
        sdSlider.value = 0
        scUnites.selectedSegmentIndex = 0
        scDizaines.selectedSegmentIndex = 0
        self.affichageResult()
    }
    
    @IBAction func actionStepper(_ sender: UIStepper) {
        self.calcul(nil);
    }
    
    
    @IBAction func actionSC(_ sender: UISegmentedControl) {
        self.calcul(sender)
    }
    
    @IBAction func actionSlider(_ sender: Any) {
        btnStepper.value = Double(Int(sdSlider.value))
        self .calcul(nil)
        
        
    }
    
    func calcul(_ sender: UISegmentedControl?){
        
        if( sender === scDizaines){
            let unites = Int(fmod(btnStepper.value, 10))
            let dizaine = Int((sender?.selectedSegmentIndex)! * 10)
            btnStepper.value = Double(dizaine+unites)
        }else if (sender === scUnites) {

            let dizaine = Int((btnStepper.value/10))
            let unites = Int((sender?.selectedSegmentIndex)!)
            btnStepper.value = Double(Double(dizaine)*10+Double(unites))
            
        }else{
            scDizaines.selectedSegmentIndex = Int(btnStepper.value/10)
            scUnites.selectedSegmentIndex = Int(fmod(btnStepper.value, 10.0))
            btnStepper.value = Double(scDizaines.selectedSegmentIndex*10 + scUnites.selectedSegmentIndex);
            sdSlider.setValue(Float(btnStepper.value), animated: true)
            
        }
        
        self.affichageResult()
        
    }
    
    
    func affichageResult () {
        let result = btnStepper.value
        
        if (btnSwitch.isOn){
            let hex = String(format:"%02X",Int(result))
            labelResult.text = hex
        }else{
            labelResult.text = "\(Int(result))"
        }
        
        if(result == 42){
            labelResult.textColor = UIColor.red
        }else{
            labelResult.textColor = UIColor.black
        }
        
        sdSlider.setValue(Float(result), animated: true)
        
      
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


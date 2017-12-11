//
//  changeView.swift
//  Humeur
//
//  Created by Nicolas Salleron on 06/12/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit

class changeView: UIView, UIPickerViewDelegate, UIPickerViewDataSource {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var pickerDifficult: UIPickerView = UIPickerView()
    let valDifficult: Array<String> = ["happy","sad", "blues", "angry"]
    var currentDifficult : Int = 1
    var cel : UneCellule?
    var humeurService : NetService?
    var connectedController : ConnectedController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.pickerDifficult.dataSource = self
        self.pickerDifficult.delegate = self
        
        
        self.addSubview(pickerDifficult)
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.DessineDansFormat(f: rect.size)
        
        
    }
    
    func DessineDansFormat(f : CGSize) -> Void {
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
        //humeurService?.stop()
        cel?.humeur = valDifficult[row]
        humeurService = NetService(domain: "local", type: "_change._tcp.", name: (cel?.label)!+";"+(cel?.humeur)!, port: 9090)
        humeurService?.delegate = connectedController
        humeurService?.includesPeerToPeer = true
        humeurService?.publish()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

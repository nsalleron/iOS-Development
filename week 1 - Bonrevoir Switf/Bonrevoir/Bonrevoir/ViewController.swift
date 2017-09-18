//
//  ViewController.swift
//  Bonrevoir
//
//  Created by Nicolas Salleron on 18/09/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var labelDis: UILabel!
    @IBOutlet weak var buttonChange: UIButton!
    var change = false;
    @IBAction func changeLabel(_ sender: Any) {
        
        if(!change){
            labelDis.text = "Bonjour !!!"
            buttonChange.setTitle("Dis au revoir !", for: UIControlState.normal)
            change = true;
        }else{
            labelDis.text = "Au revoir !!!"
            buttonChange.setTitle("Dis bonjour !", for: UIControlState.normal)
            change = false;
        }
        
        
        
        
    }
}


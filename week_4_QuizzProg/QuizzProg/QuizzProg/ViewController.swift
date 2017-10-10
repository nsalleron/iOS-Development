//
//  ViewController.swift
//  QuizzProg
//
//  Created by Nicolas Salleron on 09/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let ecran = UIScreen.main
        let rect = ecran.bounds
        let v = QuizzView(frame : rect)
        self.view = v
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  demo
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

    @IBOutlet weak var monLabel: UILabel!

    var nb = 0;
    @IBAction func monBouton(_ sender: UIButton) {
        monLabel.text = " WESH LES POTOS v: \(nb)"
        nb = nb+1;
        
    }
}


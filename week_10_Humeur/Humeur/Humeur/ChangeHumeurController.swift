//
//  DetailViewController.swift
//  MesActivites
//
//  Created by Nicolas Salleron on 08/11/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit


class ChangeHumeurController: UIViewController {

   
    var firstTime = true
    var cel : UneCellule?
    var humeurService : NetService?
    var connectedController : ConnectedController?
    var mnvc : UINavigationController?
    var v :changeView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        v = changeView(frame: UIScreen.main.bounds)
        v?.cel = cel
        v?.humeurService = humeurService
        v?.connectedController = connectedController
        v?.backgroundColor = UIColor.white
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(popView))
        self.view = v
    }
    
    func popView(){
        mnvc?.popViewController(animated: true)
    }
    
    func updateCelAndServ(a : UneCellule, b:NetService){
        v?.cel = cel
        v?.humeurService = humeurService
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
       v?.DessineDansFormat(f: size)
    }
    
  
    

   


}

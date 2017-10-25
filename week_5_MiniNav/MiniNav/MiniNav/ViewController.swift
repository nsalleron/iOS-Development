//
//  ViewController.swift
//  MiniNav
//
//  Created by Nicolas Salleron on 16/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    let AlertVC = UIAlertController(title:"URL",
                                    message:"Entrez l'URL à taper",
                                    preferredStyle: .alert)
    
    let AlertPreferenceVC = UIAlertController(title:"URL",
                                    message:"Entrez l'URL à taper",
                                    preferredStyle: .alert)
    
    let AlertPreference = UIAlertController(title:"Votre Home : ",
                                    message:"Entrez l'URL à taper",
                                    preferredStyle: .actionSheet)

    var tfAlertPreference = UITextField()
    var tfAlertTemp = UITextField()
 
    let v = MaVue(frame : UIScreen.main.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view = v;
        AlertVC.addTextField(configurationHandler: {(a)-> Void in
            a.textColor = UIColor.blue;
            a.text = "https://www.google.fr"
            self.tfAlertTemp = a
            }
        )
        AlertPreferenceVC.addTextField(configurationHandler: {(a)-> Void in
            a.textColor = UIColor.blue;
            a.text = "https://www.google.fr"
            self.tfAlertPreference = a
        }
        )

        tfAlertTemp.text = "https://www.google.fr"
        tfAlertPreference.text = "https://www.nasa.gov"
        
        AlertVC.addAction(UIAlertAction(title:"C'est parti !",style : .default,handler:lireURL));
        AlertVC.addAction(UIAlertAction(title:"Retour",style : .cancel,handler:nil));
        AlertPreferenceVC.addAction(UIAlertAction(title:"Valider",style : .default,handler:validerURL));
        AlertPreferenceVC.addAction(UIAlertAction(title:"Retour",style : .cancel,handler:nil));
        
        AlertPreference.addAction(UIAlertAction(title:"Modifier les préférences",style : .destructive,handler:nouvelleURL))
        AlertPreference.addAction(UIAlertAction(title:"Ne rien faire",style : .cancel,handler:nil))
       // self.nouvelleURL();
        
    }

    
    func actionButton(sender:UIBarButtonItem) -> Void {
        if sender == v.back{
            v.goBack()
        }else{
            v.goFoward()
        }
     
    }
    
    override var prefersStatusBarHidden: Bool{
        return true;
    }
    
    func validerURL(send : UIAlertAction){
       self.tfAlertPreference.text = self.tfAlertPreference.text
    }
    func lireURL(sender : UIAlertAction){
        v.loadURL(string: tfAlertTemp.text!)
    }
    
    func changePref(){
        self.present(AlertPreference, animated: true, completion: {})
    }
    
    func nouvelleURL(sender :UIAlertAction){
        if(sender == AlertPreference.actions[0]){
                NSLog("Je suis là");
                self.present(AlertPreferenceVC, animated: true, completion: {})
        }else{
                NSLog("Je ne suis pas là")
                self.present(AlertVC, animated: true, completion: {
                   // self.v.loadURL(string: self.AlertTemp.text!)
                })
        }
       
    }
    
    func loadHomeURL(){
        
            v.loadURL(string: tfAlertPreference.text!)
        
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        v.dessineDansFormat(frame: size)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


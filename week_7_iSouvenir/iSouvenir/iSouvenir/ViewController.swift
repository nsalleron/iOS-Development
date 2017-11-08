//
//  ViewController.swift
//  iSouvenir
//
//  Created by Nicolas Salleron on 06/11/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    let v = mainView(frame: UIScreen.main.bounds)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view, typically from a nib.
        
        if CLLocationManager.locationServicesEnabled() {
            v.myControler = self
            self.view = v
        }else{
            self.view = UIView()
            self.view.backgroundColor = UIColor.white
            let alert = UIAlertController(title: "Erreur",
                                          message: "Localisation désactivée",
                                          preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        v.dessineDansFormat(frame: size)
    }
    
    override var prefersStatusBarHidden: Bool{
        return true;
    }
    
    func changeMapType(sender: UISegmentedControl){
        var tmp = ""
        switch sender.selectedSegmentIndex {
        case 0:
            v.carte.mapType = .satelliteFlyover
            var lat = CLLocationDegrees(0)
            var lng = CLLocationDegrees(0)
            if(v.lastLocation != nil){
                lat = v.lastLocation.latitude
                lng = v.lastLocation.longitude
            }else{
                lat = CLLocationDegrees(48.846830)
                lng = CLLocationDegrees(2.356312)
            }
           
            
            let ouAller = CLLocationCoordinate2DMake(lat,lng)
            
            
            v.camera = MKMapCamera(lookingAtCenter: ouAller, fromDistance: 15, pitch: 30, heading: 90)
            v.carte.setCamera(v.camera, animated: true)
            
            tmp = "3D"
            
        case 1:
            v.carte.mapType = .standard
            tmp = NSLocalizedString("txt-Plan", tableName: "mesmessages", bundle: Bundle.main, value: "", comment: "")
        case 2:
            v.carte.mapType = .satellite
            tmp = NSLocalizedString("txt-Satellite", tableName: "mesmessages", bundle: Bundle.main, value: "", comment: "")
        case 3:
            v.carte.mapType = .hybrid
            tmp = NSLocalizedString("txt-Mixte", tableName: "mesmessages", bundle: Bundle.main, value: "", comment: "")
        default:
            v.carte.mapType = .standard
        }
        
        v.labelInfo.text = String(format: "%@ %@ \t Epingle : %d",NSLocalizedString("txt-Visu", tableName: "mesmessages", bundle: Bundle.main, value: "", comment: ""),tmp,v.compteur)
        
        
        
    }
}


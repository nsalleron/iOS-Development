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
import WatchConnectivity


class MapViewController: UIViewController, WCSessionDelegate {

    let v = mainView(frame: UIScreen.main.bounds)
    var history : HistoryController?
    let session = WCSession.default();
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Do any additional setup after loading the view, typically from a nib.
        self.tabBarItem = UITabBarItem(title: "Localisation", image: #imageLiteral(resourceName: "icone-terre"), tag: 0)
        self.navigationItem.title = "Localisation"
        
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
        
        
        session.delegate = self
        session.activate()
    }
    
    
    func sendWatchMessage() {
        let message = ["Message": "48.846469;2.356602"]
        session.sendMessage(message, replyHandler: nil, errorHandler: nil)
        NSLog("Print of message %@",message)
        
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
        switch sender.selectedSegmentIndex {
        case 0:
            v.carte.mapType = .standard
        case 1:
            v.carte.mapType = .satellite
        case 2:
            v.carte.mapType = .hybrid
        case 3:
            v.localiseMoi()
        default:
            v.carte.mapType = .standard
        }
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        self.sendWatchMessage()
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
}


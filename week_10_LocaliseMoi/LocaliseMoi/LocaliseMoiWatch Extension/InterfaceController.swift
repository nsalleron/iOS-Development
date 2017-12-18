//
//  InterfaceController.swift
//  LocaliseMoiWatch Extension
//
//  Created by Nicolas Salleron on 18/12/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    @IBOutlet var map: WKInterfaceMap!
    @IBOutlet var slider: WKInterfaceSlider!
    
    var tabRegion = [MKCoordinateRegion]()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        if WCSession.isSupported() {
            let session = WCSession.default()
            session.delegate = self
            session.activate()
        }
        
        let span = MKCoordinateSpanMake(0.035, 0.035)
        let region = MKCoordinateRegionMake(CLLocationCoordinate2D(latitude: CLLocationDegrees(0),
                                                                   longitude: CLLocationDegrees(0)), span)
        
        map.setRegion(region)

        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let coordonnees = message["Message"] as? String
        let cooTab = coordonnees?.components(separatedBy: ";")
        NSLog((cooTab?.description)!)
        let span = MKCoordinateSpanMake(0.010, 0.010)
        let region = MKCoordinateRegionMake(CLLocationCoordinate2D(latitude: CLLocationDegrees(cooTab![0])!,
                                                                   longitude: CLLocationDegrees(cooTab![1])!), span)
        
        map.setRegion(region)
        tabRegion.append(region)
        //slider.setNumberOfSteps(tabRegion.count - 1 )
        //label.setText(coordonnees)
    }
    @IBAction func changeRegion(_ value: Float) {
        //map.setRegion(tabRegion[Int(value)])
    }
}

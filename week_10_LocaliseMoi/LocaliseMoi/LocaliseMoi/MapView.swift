//
//  mainView.swift
//  iSouvenir
//
//  Created by Nicolas Salleron on 06/11/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Contacts
import ContactsUI
import MobileCoreServices

class mainView: UIView, MKMapViewDelegate,
                CLLocationManagerDelegate,
                UINavigationControllerDelegate,
                UITextFieldDelegate,
                XMLParserDelegate
                {
    
    fileprivate let it = ["Carte", "Satellite","Hybride","Moi !"]
    
    var segment : UISegmentedControl!
    var lastLocation : CLLocationCoordinate2D!
    
    let carte = MKMapView()
    var camera = MKMapCamera()
    var compteur = 1
    var myControler : MapViewController?
    
    let CLmngr = CLLocationManager()
    let textf = UITextField()
    
    var lat = 0.0
    var lng = 0.0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        
       
        /* Gestion de la localisation */
        CLmngr.distanceFilter = 1.0
        CLmngr.delegate = self
    
        segment = UISegmentedControl(items: it)
        segment.backgroundColor = UIColor.white
        segment.selectedSegmentIndex = 0
        segment.addTarget(super.superview, action: #selector(MapViewController.changeMapType(sender:)), for: UIControlEvents.valueChanged)
        
        /* Carte */
        carte.isScrollEnabled = true
        carte.isZoomEnabled = true
        carte.delegate = self
        
        /* TextField */
        textf.borderStyle = .roundedRect
        textf.keyboardType = .webSearch
        textf.delegate = self
        textf.placeholder = "Votre adresse ? :)"
        textf.textColor = UIColor.red
        textf.font = UIFont.systemFont(ofSize: 20)
        
        /* Camera */
        self.addSubview(carte)
        self.addSubview(segment)
        self.addSubview(textf)
        
        
        
        self.dessineDansFormat(frame: frame.size)
    }
    
    
    func dessineDansFormat(frame : CGSize) -> Void {
        
        if( frame.height <= 736 ){ //Portrait iphone 5S
           
                carte.frame = CGRect(x: 0, y: 0, width: Int(frame.width), height: Int(frame.height))
                segment.frame = CGRect(x: Int((frame.width/2) - ((frame.width/1.3)/2)) , y: 20 + 100 , width: Int(frame.width/1.3), height: Int(30))
                textf.frame = CGRect(x: 0, y: 40, width: frame.width, height: 60)
            
        }else{
            
                carte.frame = CGRect(x: 0, y: 60, width: Int(frame.width), height: (Int(frame.height) - 60))
                segment.frame = CGRect(x: 20 , y: 20 + 120, width: Int(frame.width/2), height: Int(30))
                textf.frame = CGRect(x: 0, y: 60, width: frame.width, height: 60)
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func localiseMoi() -> Void {
        CLmngr.requestWhenInUseAuthorization()
        CLmngr.startUpdatingLocation()
    }

    /* Delegate concernant la geolocalisation */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLmngr.stopUpdatingLocation()   //On ne récupère qu'une seule valeur
        lastLocation = (manager.location?.coordinate)!
        //Mise à jour de la carte
        let span = MKCoordinateSpanMake(0.035, 0.035)
        let region = MKCoordinateRegionMake((manager.location?.coordinate)!, span)
        
        carte.setRegion(region, animated: true)
        
     
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textf.textColor = UIColor.red
        textf.font = UIFont.systemFont(ofSize: 20)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        NSLog("End of editing")
        
        /* Lancement de la recherche */
        var textURL = "https://maps.googleapis.com/maps/api/geocode/xml?address=\(textField.text!)&sensor=false"
        
        let textURL2 = textURL.components(separatedBy: " ")
        /*
        for s in textURL2{
            NSLog("String : "+s)
        }
        */
        textURL = textURL2.joined(separator: "%20")
        NSLog("Completed : %@",textURL)
        
        let url = URL(string: textURL)
        let session = URLSession(configuration: URLSessionConfiguration.default,
                                 delegate: nil, delegateQueue: nil)
        if (url != nil){
            let tache = session.dataTask(with: url!){(d:Data?,r:URLResponse?,e:Error?) -> Void in
                if e != nil {
                    let a = UIAlertController(title: "Problème !", message: e?.localizedDescription, preferredStyle: .alert)
                    a.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.myControler?.present(a, animated: true, completion: nil)
                }else{
                    let parser = XMLParser(data: d!)
                    parser.delegate = self
                    if parser.parse() == false{
                        let a = UIAlertController(title: "Problème !", message: e?.localizedDescription, preferredStyle: .alert)
                        a.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                        self.myControler?.present(a, animated: true, completion: nil)
                    }
                }
                
            }
            
            tache.resume()

        }else{
            let a = UIAlertController(title: "Aïe!", message: "Il semblerait que l'URL soit nil (sûrement un problème d'accent)", preferredStyle: .alert)
            a.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.myControler?.present(a, animated: true, completion: nil)
        }
    }
    
    
    func parserDidStartDocument(_ parser: XMLParser) {
        lat = 0
        lng = 0
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        DispatchQueue.main.sync(execute: {
            
            NSLog("Valeur de lat : %f, lng : %f", lat,lng)
            //Mise à jour de la carte
            let span = MKCoordinateSpanMake(0.035, 0.035)
            let region = MKCoordinateRegionMake(CLLocationCoordinate2D(latitude: CLLocationDegrees(lat),
                                                                       longitude: CLLocationDegrees(lng)),
                                                span)
            carte.setRegion(region, animated: true)
            
            
         
          
                    // this is a meaningless message, but it's enough for our purposes
            let message = ["Message": "\(lat);\(lng)"]
            
            myControler?.session.sendMessage(message, replyHandler: nil, errorHandler: nil)
            NSLog("Print of message %@",message)
          
            
            
            textf.textColor = UIColor.black
            textf.font = UIFont.boldSystemFont(ofSize: 20)
            
            
            /* Historique */
            myControler?.history?.addCell(cel: UneCellule(c: compteur, l: textf.text!, lat: lat, lng: lng))
            compteur += 1
        })
    }
    
    func loadMapAt(desti : UneCellule){
        let span = MKCoordinateSpanMake(0.035, 0.035)
        let region = MKCoordinateRegionMake(CLLocationCoordinate2D(latitude: CLLocationDegrees(desti.lat),
                                                                   longitude: CLLocationDegrees(desti.lng)),
                                            span)
        carte.setRegion(region, animated: true)
        textf.text = desti.label
        textf.textColor = UIColor.black
        
    }
    
    
    func parser(_ parser: XMLParser, validationErrorOccurred validationError: Error) {
        let a = UIAlertController(title: "Problème XML !", message: validationError.localizedDescription, preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.myControler?.present(a, animated: true, completion: nil)
    }
    var readLat = false
    var readLng = false
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        //NSLog("DidStartElement : %@",elementName)
        if(elementName == "lat" && lat == 0){
            readLat = true
        }
        if(elementName == "lng" && lng == 0){
            readLng = true
        }
    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        //NSLog("FoundCharacters : %@", string)
        if(readLat){
            //NSLog("Passage lat")
            lat = Double(string)!
            readLat = false
        }
        if(readLng){
            //NSLog("Passage lng")
            lng = Double(string)!
            readLng = false
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        //NSLog("DidEndElement : %@",elementName)
    }
    
    
}





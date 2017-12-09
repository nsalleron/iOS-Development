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
                CNContactPickerDelegate,
                CNContactViewControllerDelegate,
                UIImagePickerControllerDelegate,
                UINavigationControllerDelegate
                {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    fileprivate let tb = UIToolbar()
    fileprivate let btnPlus = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: nil, action: nil)
    fileprivate let btnDel = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.trash, target: nil, action: nil)
    fileprivate let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    fileprivate let btnActu = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: nil, action: nil)
    fileprivate let btnBook = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.bookmarks, target: nil, action: nil)
    fileprivate let btnPhoto = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.camera, target: nil, action: nil)
    fileprivate let btnLibrary = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.organize, target: nil, action: nil)
    fileprivate let smallSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil);
    let labelInfo = UILabel()
    
    
    fileprivate let it = ["3D", NSLocalizedString("txt-Plan", tableName: "mesmessages", bundle: Bundle.main, value: "", comment: ""), NSLocalizedString("txt-Satellite", tableName: "mesmessages", bundle: Bundle.main, value: "", comment: ""),NSLocalizedString("txt-Mixte", tableName: "mesmessages", bundle: Bundle.main, value: "", comment: "")]
    
    var segment : UISegmentedControl!
    var lastLocation : CLLocationCoordinate2D!
    
    let carte = MKMapView()
    var camera = MKMapCamera()
    fileprivate let cible = UIImageView(image: #imageLiteral(resourceName: "target"))
    var compteur = 0
    var myControler : UIViewController?
    
    /* Contacts */
    fileprivate let ContactPickerCtlr = CNContactPickerViewController()
    fileprivate let ContactStore = CNContactStore()
    fileprivate var ContactVC : CNContactViewController?
    
    let CLmngr = CLLocationManager()
    var currentViewEpingle : MKAnnotationView?
    
    /* Image */
    var image  = UIImageView()
    var imagePresente = false
    
    /* Image picker */
    var imagePicker : UIImagePickerController?
    
    var tabColor = [UIColor.black,UIColor.blue,UIColor.brown,UIColor.cyan,UIColor.darkGray,UIColor.darkText,UIColor.green,UIColor.gray,UIColor.magenta,UIColor.orange,UIColor.purple,UIColor.red,UIColor.white,UIColor.yellow]
    
    override init(frame: CGRect) {
        super.init(frame: frame);
       
        /* Gestion de la localisation */
        CLmngr.distanceFilter = 1.0
        CLmngr.delegate = self
        
        /*Espace*/
        smallSpace.width = 10
        
        /* Configuration des boutons */
        tb.items = [ btnPlus, smallSpace, btnDel, space, btnActu,smallSpace, btnBook,smallSpace,btnPhoto,smallSpace,btnLibrary]
        tb.backgroundColor = UIColor.white
        segment = UISegmentedControl(items: it)
        segment.backgroundColor = UIColor.white
        segment.selectedSegmentIndex = 1
        segment.addTarget(super.superview, action: #selector(ViewController.changeMapType(sender:)), for: UIControlEvents.valueChanged)
        
        /* Configuration du label */
        labelInfo.font = UIFont.boldSystemFont(ofSize: 10)
        labelInfo.text = String(format: "%@ %@ \t %@ : %d",NSLocalizedString("txt-Visu", tableName: "mesmessages", bundle: Bundle.main, value: "", comment: ""),NSLocalizedString("txt-Plan", tableName: "mesmessages", bundle: Bundle.main, value: "", comment: ""),NSLocalizedString("txt-Epingle", tableName: "mesmessages", bundle: Bundle.main, value: "", comment: ""),compteur)
        
        btnPlus.action = #selector(self.ajouterEpingle(sender:))
        btnActu.action = #selector(self.localiseMoi)
        btnBook.action = #selector(self.chercher)
        btnDel.action = #selector(self.deleteEpingle)
        btnLibrary.action = #selector(self.selectionner)
        btnPhoto.action = #selector(self.photographier)
        
        /*Configuration des boutons */
        btnDel.isEnabled = false
        btnBook.isEnabled = false
        btnPhoto.isEnabled = false
        btnLibrary.isEnabled = false
        
        /* Contacts */
        ContactPickerCtlr.delegate = self
        
        /* Carte */
        carte.isScrollEnabled = true
        carte.isZoomEnabled = true
        carte.delegate = self
        
        /* Camera */
        
        
        self.addSubview(image)
        self.addSubview(carte)
        self.addSubview(cible)
        self.addSubview(tb)
        self.addSubview(segment)
        self.addSubview(labelInfo)
        
        
        self.dessineDansFormat(frame: frame.size)
    }
    
    
    func dessineDansFormat(frame : CGSize) -> Void {
        
        if( frame.height > 400 ){ //Portrait iphone 5S
            if(imagePresente){
                image.isHidden = false
                carte.frame = CGRect(x: 0, y: 0, width: Int(frame.width), height: (Int(frame.height/2) ))
                image.frame = CGRect(x: 0, y: (Int(frame.height/2)), width: Int(frame.width), height: (Int(frame.height/2) - 60))
                cible.frame = CGRect(x: Int(frame.width/2 - 50/2), y: Int(frame.height/4 - 50/2), width: 50, height: 50)
                labelInfo.frame = CGRect(x: Int(frame.width/2) - Int(frame.width/3), y: Int(frame.height - 60 ), width: Int(frame.width) - Int(frame.width/5), height: 10)
                tb.frame = CGRect(x: 0, y: Int(frame.height - 60 ), width: Int(frame.width), height: Int(10+50))
                segment.frame = CGRect(x: Int((frame.width/2) - ((frame.width/1.3)/2)), y: 20, width: Int(frame.width/1.3), height: Int(30))
                
            }else{
                image.isHidden = true
                carte.frame = CGRect(x: 0, y: 0, width: Int(frame.width), height: (Int(frame.height) - 60))
                cible.frame = CGRect(x: Int(frame.width/2 - 50/2), y: Int(frame.height/2 - 50/2), width: 50, height: 50)
                labelInfo.frame = CGRect(x: Int(frame.width/2) - Int(frame.width/3), y: Int(frame.height - 60 ), width: Int(frame.width) - Int(frame.width/5), height: 10)
                tb.frame = CGRect(x: 0, y: Int(frame.height - 60 ), width: Int(frame.width), height: Int(10+50))
                segment.frame = CGRect(x: Int((frame.width/2) - ((frame.width/1.3)/2)), y: 20, width: Int(frame.width/1.3), height: Int(30))
            }
        }else{
            if(imagePresente){
                image.isHidden = false
                image.frame = CGRect(x: Int(frame.width/2), y: 0, width: Int(frame.width/2), height: (Int(frame.height)))
                carte.frame = CGRect(x: 0, y: 0, width: Int(frame.width/2), height: (Int(frame.height)))
                
                cible.frame = CGRect(x: Int(frame.width/4 - 50/2), y: Int(frame.height/2 - 50/2), width: 50, height: 50)
                labelInfo.frame = CGRect(x: Int(frame.width/2) - Int(frame.width/3), y: Int(frame.height - 60 ), width: Int(frame.width) - Int(frame.width/5), height: 10)
                tb.frame = CGRect(x: 0, y: Int(frame.height - 60 ), width: Int(frame.width), height: Int(10+50))
                segment.frame = CGRect(x: Int((frame.width/2) - ((frame.width/1.3)/2)), y: 20, width: Int(frame.width/1.3), height: Int(30))
                
            }else{
                image.isHidden = true
                carte.frame = CGRect(x: 0, y: 0, width: Int(frame.width), height: (Int(frame.height) - 60))
                cible.frame = CGRect(x: Int(frame.width/2 - 50/2), y: Int(frame.height/2 - 50/2), width: 50, height: 50)
                labelInfo.frame = CGRect(x: Int(frame.width/2) - Int(frame.width/3), y: Int(frame.height - 60 ), width: Int(frame.width) - Int(frame.width/5), height: 10)
                tb.frame = CGRect(x: 0, y: Int(frame.height - 60 ), width: Int(frame.width), height: Int(10+50))
                segment.frame = CGRect(x: Int((frame.width/2) - ((frame.width/1.3)/2)), y: 20, width: Int(frame.width/1.3), height: Int(30))
            }
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func localiseMoi() -> Void {
        CLmngr.requestWhenInUseAuthorization()
        CLmngr.startUpdatingLocation()
    }
    
    func chercher(){
       
        ContactStore.requestAccess(for: .contacts, completionHandler: { (access : Bool , error : Error?) -> () in
            if !access {
                let a = UIAlertController(title: "ERREUR FATALE DE LA MORT", message: "ATTENTION", preferredStyle: UIAlertControllerStyle.actionSheet)
                a.addAction(UIAlertAction(title: "OK MEC ! ", style: UIAlertActionStyle.default, handler: nil))
                self.myControler?.present(a, animated: true, completion: nil)
            }else{
                self.myControler?.present(self.ContactPickerCtlr, animated: true, completion: nil)
            }
        })
        
    }
    
    
    
    
    func ajouterEpingle(sender : UIBarButtonItem){
        let a = MonAnnotation(c:carte.centerCoordinate,
                              t: String(format:"Contact %d", compteur),
                              st: NSLocalizedString("txt-Contact", tableName: "mesmessages", bundle: Bundle.main, value: "", comment: ""))
        compteur += 1
        carte.addAnnotation(a)
        
    }
    
    func deleteEpingle(){
        carte.removeAnnotation((currentViewEpingle?.annotation)!)
        self.dessineDansFormat(frame: UIScreen.main.bounds.size)
    }
    
    func updateEpingle(sender : MKAnnotation, t : String, st : String){
        let a = MonAnnotation(c:sender.coordinate,
                              t: t,
                              st: st)
        
        compteur += 1
        carte.addAnnotation(a)
        
    }
    
    func selectionner(){
        if (!(imagePicker != nil)){
            imagePicker = UIImagePickerController()
            imagePicker?.delegate = self
        }
        imagePicker?.sourceType = .photoLibrary
        imagePicker?.allowsEditing = true
        myControler?.present(imagePicker!, animated: true, completion: nil)
    }
    
    func photographier(){
        if (!(imagePicker != nil)){
            imagePicker = UIImagePickerController()
            imagePicker?.delegate = self
        }
        imagePicker?.sourceType = .camera
        imagePicker?.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
        imagePicker?.allowsEditing = true
        myControler?.present(imagePicker!, animated: true, completion: nil)
    }

    
    
    /* Delegate concernant la geolocalisation */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLmngr.stopUpdatingLocation()   //On ne récupère qu'une seule valeur
        lastLocation = (manager.location?.coordinate)!
        //Mise à jour de la carte
        let span = MKCoordinateSpanMake(0.035, 0.035)
        let region = MKCoordinateRegionMake((manager.location?.coordinate)!, span)
        
        carte.setRegion(region, animated: true)
        
        /* Affichage coordonnées */
        
        labelInfo.text = String(format: "%@  %f, %f \t %@ : %d",
                                NSLocalizedString("txt-Pos", tableName: "mesmessages", bundle: Bundle.main, value: "", comment: ""),
                                lastLocation.latitude,
                                lastLocation.longitude,
                                NSLocalizedString("txt-Epingle", tableName: "mesmessages", bundle: Bundle.main, value: "", comment: ""),
                                compteur)
        
        
        
    }
    
    /* Delegate concernant map */
    
    /* Permet de reconstruire l'épingle, d'afficher sa couleur et son callout*/
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let epingleTmp = MKPinAnnotationView(annotation: annotation,
                                          reuseIdentifier: "ppm")
        
        epingleTmp.pinTintColor = tabColor[compteur%tabColor.count]
        epingleTmp.canShowCallout = true
        epingleTmp.leftCalloutAccessoryView = UIButton(type: .detailDisclosure)
        epingleTmp.rightCalloutAccessoryView = UIImageView(image: #imageLiteral(resourceName: "target"))
        
        
        return epingleTmp
    }
    
    /* C'est ce qui se passe quand on tape sur le callout d'une épingle */
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let epingle = view
        
        labelInfo.text = String(format: "%@ %@ %f, %f \t %@",
                                NSLocalizedString("txt-Epingle", tableName: "mesmessages", bundle: Bundle.main, value: "", comment: ""),
                                NSLocalizedString("txt-Sur", tableName: "mesmessages", bundle: Bundle.main, value: "", comment: ""),
                                (epingle.annotation?.coordinate.latitude)!,
                                (epingle.annotation?.coordinate.longitude)!,
                                ((epingle.annotation?.title!)!))
    }
    
    /* Affiche l'annotation qui est sélectionné */
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        
        btnDel.isEnabled = true
        btnBook.isEnabled = true
        btnPhoto.isEnabled = true
        btnLibrary.isEnabled = true
        
        currentViewEpingle = view
        
        if((currentViewEpingle?.rightCalloutAccessoryView as! UIImageView).image != #imageLiteral(resourceName: "target")){
            imagePresente = true
            
        }else{
            imagePresente = false
        }
        dessineDansFormat(frame: UIScreen.main.bounds.size)
       
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        btnDel.isEnabled = false
        btnBook.isEnabled = false
        btnPhoto.isEnabled = false
        btnLibrary.isEnabled = false
        
        currentViewEpingle = view
        imagePresente = false;
        self.dessineDansFormat(frame: UIScreen.main.bounds.size)
    }
    
    /* Delegate concernant les contacts */
    /* C'est quand on clique sur un contact */
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        
        var nomPrenom = ""
        if(contact.familyName == "" || contact.givenName == ""){
            nomPrenom = NSLocalizedString("txt-Contact", tableName: "mesmessages", bundle: Bundle.main, value: "", comment: "")
        }else{
            nomPrenom = String(format: "%@ %@", contact.familyName, contact.givenName)
        }
        
        
       
    
        //carte.removeAnnotation((currentViewEpingle?.annotation)!)
        let tmp = (currentViewEpingle?.annotation as! MonAnnotation)
        tmp.updateTitle(t: nomPrenom)
        
        carte.deselectAnnotation(tmp, animated: false)
        ContactPickerCtlr.dismiss(animated: true, completion: nil)
    }
    
    /* Annulation */
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        //TODO
        print("DONE 2")
    }
    
    
    
    func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
        //TODO
        //DISMISS
        print("DONE 3")
    }
    
    
    /* Delegate concernant la photo */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let mediaType = info[UIImagePickerControllerMediaType] as? String
        if mediaType  == "public.image" {
            let img = info[UIImagePickerControllerEditedImage]
            (currentViewEpingle?.rightCalloutAccessoryView as! UIImageView).image = img as? UIImage
            image.image = ( img as? UIImage)
            imagePresente = true;
            self.dessineDansFormat(frame: UIScreen.main.bounds.size)
        }else{
            let a = UIAlertController(title: "PROBLEME", message: "C'est un film", preferredStyle: .actionSheet)
            a.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            myControler?.present(a, animated: true, completion: nil)
        }
        
        
    }

}

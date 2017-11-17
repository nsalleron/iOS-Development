//
//  DetailViewController.swift
//  MesActivites
//
//  Created by Nicolas Salleron on 08/11/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UISplitViewControllerDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public var svc : UISplitViewController?
    public var termType : terminalType?
    public var mvc : MasterViewController?
    var viewDetail : UIView?
    /* Image picker */
    var imagePicker : UIImagePickerController?
    
    //Cas particulier
    let celluleVacDefault = UneCellule(l: "S'occuper des vacances", priorite: 4)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Détail"
       
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .camera, target: self, action: #selector(takePhoto))
        
        viewDetail = DetailView(frame: UIScreen.main.bounds)
        (viewDetail as! DetailView).dvc = self
        self.view = viewDetail
        // Do any additional setup after loading the view.
        
        self.updateView(cel: celluleVacDefault)
    }
    
    func takePhoto(){
        if (!(imagePicker != nil)){
            imagePicker = UIImagePickerController()
            imagePicker?.delegate = self
        }
        if( UIImagePickerController.isSourceTypeAvailable(.camera)){
            imagePicker?.sourceType = .camera
            imagePicker?.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
            imagePicker?.allowsEditing = true

        }else{
            imagePicker?.sourceType = .photoLibrary
            imagePicker?.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            imagePicker?.allowsEditing = true
        }
        self.present(imagePicker!, animated: true, completion: nil)
    }
    
    func updateView(cel: UneCellule){
        let v = (self.view as! DetailView)
        v.updateView(cel: cel)
        
    }
    
    func changePrio(sender : UISegmentedControl){
        //APL à la vue Master
        print("passage")
        mvc?.changePrioCellule(selected: sender.selectedSegmentIndex)
        
    }
    
    func changeText(sender: UITextField){
        mvc?.changeTextCellue(string: sender.text!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.view.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        (self.view as! DetailView).dessine(rect: size)
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /* Delegate concernant la photo */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let mediaType = info[UIImagePickerControllerMediaType] as? String
        if mediaType  == "public.image" {
            let img = info[UIImagePickerControllerEditedImage]
            (viewDetail as! DetailView).image.addSubview(UIImageView(image: ( img as? UIImage)))
            
            (viewDetail as! DetailView).image.setZoomScale(0.2, animated: true)
            mvc?.changeImageCellule(selected: ( img as? UIImage)!)
        }else{
            let a = UIAlertController(title: "PROBLEME", message: "C'est un film", preferredStyle: .actionSheet)
            a.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(a, animated: true, completion: nil)
        }
        
        
    }


}

//
//  DetailView.swift
//  MesActivites
//
//  Created by Nicolas Salleron on 08/11/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit


class DetailView: UIView,UIScrollViewDelegate{

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var imageFond = UIImageView(image: #imageLiteral(resourceName: "fond-alu"))
    var segPrio = UISegmentedControl(items: ["0","1","2","3","4"])
    var labelPrio = UILabel()
    var labelTf = UILabel()
    var tf = UITextField()
    var dvc : ChangeController?
    var lastCountCharacter : Int?
    var image  = UIScrollView()
    
    
    //TODO
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        segPrio.addTarget(self.superview, action: #selector(ChangeController.changePrio(sender:)), for: UIControlEvents.valueChanged)
       // segPrio.addTarget(super.superview, action: #selector(DetailViewController.changePrio(sender:)), for: UIControlEvents.touchDown)
        segPrio.backgroundColor = UIColor.clear
        segPrio.tintColor = UIColor.white
        labelPrio.text = "Priority"
        labelTf.text = "Title : "
        tf.text = ""
        tf.backgroundColor = UIColor.white
        tf.addTarget(super.superview, action: #selector(ChangeController.changeText(sender:)), for: .allEditingEvents)
        
        image.delegate = self
        image.maximumZoomScale = 1.0
        image.minimumZoomScale = 0.05
        
        self.addSubview(imageFond)
        self.addSubview(labelPrio)
        self.addSubview(tf)
        self.addSubview(labelTf)
        self.addSubview(segPrio)
        self.addSubview(image)
        
        
        
        
        self.draw(frame)
    }
    
    func updateView(cel : UneCellule){
        tf.text = cel.label
        segPrio.selectedSegmentIndex = cel.priorite
        if(cel.image != nil){
            self.image.addSubview(UIImageView(image: cel.image))
            self.image.setZoomScale(0.2, animated: true)
        }else{
            if(self.image.subviews.count > 0){
                for image in self.image.subviews{
                    image.removeFromSuperview()
                }
            }
        }
        self.setNeedsDisplay()
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dessine( rect : CGSize){
        imageFond.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
        labelTf.frame = CGRect(x: 10, y: 100, width: 50, height: 20)
        tf.frame = CGRect(x: 60, y: 100, width: rect.width/1.1 - 80, height: 20)
        labelPrio.frame = CGRect(x: 10, y: 130, width: 100, height: 20)
        segPrio.frame = CGRect(x: 10, y: 160, width: rect.width/1.1 - 20, height: 30)
        image.frame = CGRect(x: 10, y: 200, width: rect.width/1.1 - 20, height: rect.height/1.1 - 160)
    }
    
    override func draw(_ rect: CGRect) {
        self.dessine(rect: rect.size)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lastCountCharacter = textField.text?.characters.count
    }
    
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        scrollView.setZoomScale(scale, animated: true)
    }
   
    
}

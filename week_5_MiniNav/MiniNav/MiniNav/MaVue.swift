//
//  MaVue.swift
//  MiniNav
//
//  Created by Nicolas Salleron on 16/10/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit

class MaVue: UIView,UIWebViewDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let wv = UIWebView();
    let tb = UIToolbar();
    let back = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.rewind, target: nil, action: nil);
    let preference = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: nil, action: nil);
    let home  = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: nil, action: nil);
    let URLbtn  = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.compose, target: nil, action: nil);
    let activity = UIActivityIndicatorView();
    
    let foward = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fastForward, target: nil, action: nil);
    override init(frame : CGRect) {
        super.init(frame: frame);
        
        let varSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil);
        let smallSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil);
        smallSpace.width = 10;
        activity.color = UIColor.white;
        tb.barTintColor = UIColor.red
        preference.tintColor = UIColor.white
        back.tintColor = UIColor.white
        home.tintColor = UIColor.white
        foward.tintColor = UIColor.white
        URLbtn.tintColor = UIColor.white
        wv.backgroundColor = UIColor.brown
        
        
        tb.items = [home ,varSpace,back,smallSpace,URLbtn,smallSpace,foward,varSpace,preference]
        
        back.target = self.superview
        back.action = #selector(ViewController.actionButton)
        
        foward.target = self.superview
        foward.action = #selector(ViewController.actionButton)
        foward.isEnabled = false;
        
        URLbtn.target = self.superview
        URLbtn.action = #selector(ViewController.nouvelleURL)
        
        home.target = self.superview
        home.action = #selector(ViewController.loadHomeURL)
        
        preference.target = self.superview
        preference.action = #selector(ViewController.changePref)
        
        self.addSubview(tb)
        self.addSubview(activity)
        self.addSubview(wv)
        wv.delegate = self
        
        
        self.loadDefaultURL();
        self.dessineDansFormat(frame: frame.size)
        
    }
    func loadDefaultURL(){
        
        wv.loadRequest(URLRequest(url: URL(string : "https://www.google.fr")!))
    }
    
    func loadURL(string : String){
        
        wv.loadRequest(URLRequest(url: URL(string : string)!))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        self.dessineDansFormat(frame: rect.size)
    }
    
    func dessineDansFormat(frame : CGSize) -> Void {
        
        tb.frame = CGRect(x: 0, y: 0, width: Int(frame.width), height: Int(10+50))
        activity.frame = CGRect(x: Int(frame.width)/6, y: 20, width: 20, height: 20)
        wv.frame = CGRect(x: 0, y: Int(10+50), width: Int(frame.width), height: Int(frame.height - 60));
        
    }
    
    func goBack () -> Void {
        wv.goBack();
    }
    
    func goFoward () -> Void {
        
        wv.goForward();
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        //TODO
        activity.startAnimating()
        if wv.canGoForward {
            foward.isEnabled = true
        }else{
             foward.isEnabled = false
        }
        
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //TODO
        activity.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        let erreurVC = UIAlertController(title: "Erreur", message: error.localizedDescription, preferredStyle: .alert);
        erreurVC.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        UIApplication.shared.windows[0].rootViewController?.present(erreurVC, animated: true, completion: {})
    }
    
    deinit {
        wv.delegate = nil;
    }
    
    
}

//
//  DetailViewController.swift
//  MesActivites
//
//  Created by Nicolas Salleron on 08/11/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit
import MediaPlayer

class ChangeController: UIViewController {
  
    public var termType : terminalType?
    var viewAff : ChangeView?
    let media = MPMediaQuery.songs()
    var player : MPMusicPlayerController?
    var history : HistoryController?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarItem = UITabBarItem(title: "Musique", image: #imageLiteral(resourceName: "tete-a-toto"), tag: 0)
        
        
        player = MPMusicPlayerController()

        player?.setQueue(with: media)
        
        viewAff = ChangeView()
        viewAff?.controller = self
        self.view = viewAff
        
       
        
        
        viewAff?.setCountMusic(nb: (media.collections?.count)!)
        viewAff?.updateMusic()
        // Do any additional setup after loading the view.
       
    }
    
    
    func playerNext(){
        if(viewAff?.playing)!{
            player?.skipToNextItem()
            viewAff?.current += 1
            viewAff?.updateMusic()
            history?.addCell(music:  (media.collections?[(viewAff?.current)! - 1].items.first?.title)!)
        }
    }
    
    func playerPrevious(){
        if(viewAff?.playing)!{
            player?.skipToPreviousItem()
            viewAff?.current -= 1
            if(viewAff?.current == 0){
                viewAff?.current = 1
            }
            viewAff?.updateMusic()
            history?.addCell(music:  (media.collections?[(viewAff?.current)! - 1].items.first?.title)!)
        }
        
    }
    
    func playerStart(){
        viewAff?.current = 1
        viewAff?.updateMusic()
        player?.play()
        viewAff?.backgroundColor = UIColor.darkGray
        viewAff?.updateStatus(status: "En écoute")
        
        
        history?.addCell(music:  (media.collections?[(viewAff?.current)! - 1].items.first?.title)!)
        
    }
    
    func playerStop(){
        player?.stop()
        viewAff?.updateStatus(status: "À l'arrêt")
        viewAff?.backgroundColor = UIColor.white
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
       
    }
    
    
    

   


}

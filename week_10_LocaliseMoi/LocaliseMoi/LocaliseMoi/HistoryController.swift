//
//  ViewController.swift
//  MesActivites
//
//  Created by Nicolas Salleron on 08/11/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit

class HistoryController: UITableViewController,UISplitViewControllerDelegate {
    enum terminalType {
        case undefined
        case iphone35
        case iphone40
        case iphone47
        case iphone55
        case ipad
        case ipadpro
    }
    
    public var svc : UISplitViewController?
    public var termType : terminalType?
    public var mvc : MapViewController?
    public var mnvc : UINavigationController?
    
    private var currentSection : Int = 0
    private var currentRow : Int = 0
    
    public var contenu = [[UneCellule]]()
    var compteur = 1
    
    let rep = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 1)
        
        self.tableView = UITableView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: UIScreen.main.bounds.width,
                                                   height: UIScreen.main.bounds.height),
                                     style: style)
        
       
        self.tableView.backgroundColor = UIColor.white
        self.tableView.sectionFooterHeight = 80
        self.tableView.sectionIndexBackgroundColor = UIColor.white
        self.tableView.dataSource = self
        self.tableView.delegate = self
 
        self.title = "Historique"
        
      
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.sauvegarde))
        
        
        
        self.tableView.allowsSelectionDuringEditing = true
        let section = [UneCellule]()
    
         contenu += [section]
        
        
    }
    
    func restaure(){
        /*Decodage */
        var fich = rep[0] + "/sauvegarde0"
        if FileManager.default.fileExists(atPath: fich) {
            for i in 0 ... 1000{
                fich = rep[0] + "/sauvegarde" + String(i)
                let d = NSKeyedUnarchiver.unarchiveObject(withFile: fich) as! UneCellule?
                if(d != nil){
                    NSLog("Récupération : "+String(i))
                    contenu[0].append((d)!)
                    mvc?.v.compteur += 1
                }else{
                    break
                }
            }
        }
    }
    
    
    func sauvegarde(){
        NSLog("Sauvegarde des données")
        for i in 0 ... contenu[0].count - 1{
            let fich = rep[0] + "/sauvegarde"+String(i)
            let res = NSKeyedArchiver.archiveRootObject(contenu[0][i], toFile: fich)
            if !res {
                let alert = UIAlertController(title: "Problème de sauvegarde",
                                              message: "PB de sauvegarde :(",
                                              preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Ok",
                                              style: .default,
                                              handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "Historique"
        let v = UIView()
        v.backgroundColor = UIColor.white
        self.view = v
        
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /* Protocole tableViewDataSource */
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contenu[0].count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func addCell(cel : UneCellule){
        contenu[0].append(cel)
        tableView.reloadData()
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ppm")
        if cell === nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ppm")
        }
        let cont = contenu[indexPath.section][indexPath.row]
        cell!.textLabel?.text = "Adresse \(cont.compteur)"
        cell!.detailTextLabel?.text = cont.label
        cell!.backgroundColor = UIColor.white
        return cell!

    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mvc?.v.loadMapAt(desti: contenu[indexPath.section][indexPath.row])
        
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = contenu[sourceIndexPath.section][sourceIndexPath.row]
        contenu[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        contenu[destinationIndexPath.section].insert(movedObject, at: destinationIndexPath.row)
        
        currentRow = destinationIndexPath.row
        currentSection = destinationIndexPath.section
        
        tableView.reloadData()
        
    }
   
   

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.view.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.tableView.reloadData()
        print("viewWillTransition")
    }

    override func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        print("willBeginEditingRowAt")
    }
    
    override func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        print("didendEditiingRowAt")
    }
  
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contenu[0].remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }

}


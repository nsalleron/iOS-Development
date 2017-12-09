//
//  ViewController.swift
//  MesActivites
//
//  Created by Nicolas Salleron on 08/11/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit

class ConnectedController: UITableViewController,UISplitViewControllerDelegate,NetServiceDelegate,NetServiceBrowserDelegate {
    
    public var svc : UISplitViewController?
    public var mnvc : UINavigationController?
    
    private var currentSection : Int = 0
    private var currentRow : Int = 0
    
    public var contenu = [[UneCellule]]()
    var compteur = 1
    var name : String?
    
    /* NetService */
    var discoverService : NetService?
    var discoverBrowser : NetServiceBrowser?
    
    var humeurService : NetService?
    var humeurBrowser : NetServiceBrowser?
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        
       
        /* Préparation du tableau */
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
        self.title = "Participants"
        self.tableView.allowsSelectionDuringEditing = false
        
        /* Préparation du tableau interne */
        let section = [UneCellule]()
        contenu += [section]
        
        /* Récupération du nom en préférence */
        let def = UserDefaults.standard
        NSLog(def.description)
        let tmp = def.string(forKey: "name_preference")
      
        if(tmp == nil){
            name = UIDevice.current.name
        }else{
            name = tmp
        }
        
        
        /* Préparation du service Note: 1 seul service suffi*/
        discoverService = NetService(domain: "local", type: "_humeur._tcp.", name: name!, port: 9090)
        discoverService?.delegate = self
        discoverService?.includesPeerToPeer = true
        discoverService?.publish()
        
        discoverBrowser = NetServiceBrowser()
        discoverBrowser?.delegate = self
        discoverBrowser?.searchForServices(ofType: "_humeur._tcp.", inDomain: "local")
        
   
        humeurService = NetService(domain: "local", type: "_change._tcp.", name: name!+";"+"happy", port: 9090)
        humeurService?.delegate = self
        humeurService?.includesPeerToPeer = true
        humeurService?.publish()
     
        
        humeurBrowser = NetServiceBrowser()
        humeurBrowser?.delegate = self
        humeurBrowser?.searchForServices(ofType: "_change._tcp.", inDomain: "local")
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib
        let v = UIView()
        v.backgroundColor = UIColor.white
        self.view = v
        
        
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
    
    
    func addCell(music : String){
        contenu[0].append(UneCellule(l: music))
        tableView.reloadData()
    }
    

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ppm")
        if cell === nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ppm")
        }
        let cont = contenu[indexPath.section][indexPath.row]
        cell!.textLabel?.text = cont.label
        cell!.detailTextLabel?.text = cont.humeur
        var tmp : UIImage?
        
        switch cont.humeur {
        case "happy":
            tmp = #imageLiteral(resourceName: "happy")
            cell!.detailTextLabel?.textColor = UIColor.green
        case "blues":
            tmp = #imageLiteral(resourceName: "blues")
            cell!.detailTextLabel?.textColor = UIColor.black
        case "sad":
            tmp = #imageLiteral(resourceName: "sad")
            cell!.detailTextLabel?.textColor = UIColor.blue
        case "angry":
            tmp = #imageLiteral(resourceName: "angry")
            cell!.detailTextLabel?.textColor = UIColor.red
        default:
            ()
        }
        cell!.imageView?.image = tmp
        cell!.backgroundColor = UIColor.white
        return cell!

    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(contenu[0][indexPath.row].label == name){
            let c = ChangeHumeurController()
            c.cel = contenu[0][indexPath.row];
            c.humeurService = humeurService
            c.connectedController = self
            c.mnvc = mnvc
            mnvc?.pushViewController(c, animated: true)
        }
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

    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool) {
        NSLog("Passage de type \(service.type)")
        if service.type == "_humeur._tcp." {
            var i = 0
            if(contenu[0].count == 0){
                contenu[0].append(UneCellule(l: service.name))
            }else{
                for str in contenu[0]{
                    NSLog("\(service.name)")
                    if(str.label != service.name){
                        contenu[0].append(UneCellule(l: service.name))
                    }
                    i += 1
                }
            }
            
            
        }
        if service.type == "_change._tcp." {
            var i = 0
            for str in contenu[0]{
                if(str.label == service.name.components(separatedBy: ";")[0]){
                    let c = contenu[0][i]
                    c.changeHumeur(l: service.name.components(separatedBy: ";")[1])
                    
                    NSLog("Humeur : \(c.humeur)")
                    
                }
                i += 1
            }
        }
        tableView.reloadData()

    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool){
         NSLog("Fin service")
        if(service.type == "_humeur._tcp."){
            var i = 0
            for str in contenu[0]{
                if(str.label == service.name){
                    contenu[0].remove(at: i)
                    tableView.reloadData()
                }
                i += 1
            }
        }
        
        
    }
    
    deinit {
        discoverService?.stop()
        discoverBrowser?.stop()
        
    }
    
}


//
//  ViewController.swift
//  MesActivites
//
//  Created by Nicolas Salleron on 08/11/2017.
//  Copyright © 2017 Nicolas Salleron. All rights reserved.
//

import UIKit

class HistoryController: UITableViewController,UISplitViewControllerDelegate {
    
    public var svc : UISplitViewController?
    public var termType : terminalType?
    public var dvc : ChangeController?
    public var mnvc : UINavigationController?
    
    private var currentSection : Int = 0
    private var currentRow : Int = 0
    
    public var contenu = [[UneCellule]]()
    var compteur = 1
    
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
        
        self.tableView.allowsSelectionDuringEditing = false
        
        let section = [UneCellule]()
    
        contenu += [section]
            
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
        return true
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
        return 50
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width
            , height: 50.0))
        
        /* Préparation du fond */
        let imageFond = UIImageView()
        imageFond.backgroundColor = UIColor.white
        imageFond.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width
            , height: 50.0)
        
        /* Préparation de l'affichage des élements */
        let l = UILabel(frame: CGRect(x: 10, y: 15, width: UIScreen.main.bounds.size.width - 100
            , height: 25))
        
        l.textColor = UIColor.black
        l.font = UIFont.boldSystemFont(ofSize: 20)
        l.text = "Historique"
        
        hv.addSubview(imageFond)
        hv.addSubview(l)
        
        return hv
        
        
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
        cell!.backgroundColor = UIColor.white
        return cell!

    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return false
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

}


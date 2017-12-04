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
    
    
    let celluleVacDefault = UneCellule(l: "S'occuper des vacances", priorite: 4)
    let cellulePersoDefault = UneCellule(l: "Faire les courses", priorite: 2)
    let celluleUrgentDefault = UneCellule(l: "Me faire un cadeau", priorite: 3)
    let tabCelluleAujourdhuiDefault = [ UneCellule(l: "Boire mon café", priorite: 0),
                                        UneCellule(l:"Faire ma sieste", priorite: 1)
                                        ]
    let tabSection = ["Vacances","Personnel","Urgent","Aujourd'hui"]
    
    var mobile = false
    
    public var contenu = [[UneCellule]]()
    var compteur = 1
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        
        self.tableView = UITableView(frame: CGRect(x: 0,
                                                   y: 0,
                                                   width: UIScreen.main.bounds.width,
                                                   height: UIScreen.main.bounds.height),
                                     style: style)
        
        
        self.tableView.backgroundView = UIImageView(image:#imageLiteral(resourceName: "fond-alu-2"))
        self.tableView.sectionFooterHeight = 80
        self.tableView.sectionIndexBackgroundColor = UIColor.white
        self.tableView.separatorColor = UIColor.red
        self.tableView.dataSource = self
        self.tableView.delegate = self
 
        self.title = "Mes éléments"
        
        /* Mise en place du contenu */
        
        for i in 0 ... tabSection.count - 1{
            var dansSection = [UneCellule]()
            switch i {
            case 0:
                dansSection += [celluleVacDefault]
            case 1:
                dansSection += [cellulePersoDefault]
            case 2:
                dansSection += [celluleUrgentDefault]
            case 3:
                dansSection += tabCelluleAujourdhuiDefault
            default:
                ()
            }
            contenu += [dansSection]
        }
        
        
        
        
        /* Boutons de modifications */
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        
        self.navigationItem.rightBarButtonItem =
            UIBarButtonItem(barButtonSystemItem: .add,
                            target: self,
                            action: #selector(ajoutCellule))
        
        
        
        self.tableView.allowsSelectionDuringEditing = true
        
        
        
    }
    
    func ajoutCellule(){
        self.contenu[1].insert(UneCellule(l:"Nouvelle tâche",
                                priorite: 0), at: contenu[1].count)
        compteur += 1
        self.tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "Master"
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
        return contenu.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contenu[section].count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = UIView(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width
            , height: 50.0))
        
        /* Préparation du fond */
        let imageFond = UIImageView(image: #imageLiteral(resourceName: "bg-header"))
        imageFond.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.size.width
            , height: 50.0)
        
        /* Préparation de l'affichage des élements */
        let l = UILabel(frame: CGRect(x: 10, y: 15, width: UIScreen.main.bounds.size.width - 100
            , height: 25))
        
        l.textColor = UIColor.white
        l.font = UIFont.boldSystemFont(ofSize: 20)
        l.text = tabSection[section]
        
        hv.addSubview(imageFond)
        hv.addSubview(l)
        
        return hv
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentSection = indexPath.section
        currentRow = indexPath.row
        let cont = contenu[indexPath.section][indexPath.row]
        dvc?.updateView(cel: cont)
        
        if(mobile){
            mnvc?.pushViewController(dvc!, animated: true)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "ppm")
        if cell === nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ppm")
        }
        let cont = contenu[indexPath.section][indexPath.row]
        cell!.textLabel?.text = cont.label
        cell!.detailTextLabel?.text = cont.detail
        cell!.imageView?.image = cont.prioImage.image
        cell!.backgroundView = UIImageView(image: #imageLiteral(resourceName: "bg-tableview-cell"))
        return cell!

    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = contenu[sourceIndexPath.section][sourceIndexPath.row]
        contenu[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        contenu[destinationIndexPath.section].insert(movedObject, at: destinationIndexPath.row)
        
        currentRow = destinationIndexPath.row
        currentSection = destinationIndexPath.section
        
        let cont = contenu[currentSection][currentRow]
        dvc?.updateView(cel: cont)
        
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.contenu[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Pas implémenter mais on pourrait
        }
        self.tableView.reloadData()
        
    }
    
    func changePrioCellule(selected : Int){
        let tmp = contenu[currentSection][currentRow]
        tmp.updatePrio(prio: selected)
        
        self.contenu[currentSection].remove(at: currentRow)
        self.contenu[currentSection].insert(tmp, at: currentRow)
       
        self.tableView.reloadData()
    }
    
    func changeImageCellule(selected : UIImage){
        let tmp = contenu[currentSection][currentRow]
        tmp.updateImage(d: selected)
        
        self.contenu[currentSection].remove(at: currentRow)
        self.contenu[currentSection].insert(tmp, at: currentRow)
        
        self.tableView.reloadData()
    }
    
    
    func changeTextCellue(string:String){
        let tmp = contenu[currentSection][currentRow]
        tmp.updateTitle(prio: string)
        
        self.contenu[currentSection].remove(at: currentRow)
        self.contenu[currentSection].insert(tmp, at: currentRow)
        
        self.tableView.reloadData()
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


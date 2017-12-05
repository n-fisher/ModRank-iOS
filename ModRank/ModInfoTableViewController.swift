//
//  ModInfoTableViewController.swift
//  ModRank
//
//  Created by Nick Fisher on 11/5/17.
//  Copyright © 2017 Nick Fisher. All rights reserved.
//

import UIKit
import os.log

class ModInfoTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    @IBOutlet var tableUI: UITableView!
    var mods = [ModInfo]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.action = #selector(ModInfoTableViewController.editTableView)
        /*if let savedMods = loadMods() {
            mods = savedMods
            print("Loaded " + String(savedMods.count) + " mods")
        }
        else {
            os_log("Failed to load mods", log: OSLog.default, type: .error)
        }*/
        
        if mods.count == 0 {
            //loadSampleMods()
        }
        
        tableUI.delegate = self
        tableUI.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mods.count
    }
    
    @IBAction func editTableView (sender:UIBarButtonItem)
    {
        if tableUI.isEditing{
            //listTableView.editing = false;
            tableUI.setEditing(false, animated: true);
            navigationItem.leftBarButtonItem?.style = UIBarButtonItemStyle.plain;
            navigationItem.leftBarButtonItem?.title = "Edit";
            //listTableView.reloadData();
        }
        else{
            //listTableView.editing = true;
            tableUI.setEditing(true, animated: true);
            navigationItem.leftBarButtonItem?.title = "Done";
            navigationItem.leftBarButtonItem?.style =  UIBarButtonItemStyle.done;
            //listTableView.reloadData();
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ModInfoTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ModInfoTableViewCell else {
            fatalError("The dequeued cell is not an instance of ModInfoTableViewCell.")
        }

        let mod = mods[indexPath.row]
        
        cell.titleLabel.text = mod.itemTitle
        cell.modImage.image = UIImage(data: mod.img as Data)
        
        cell.percentagesStack.refresh(favs: mod.favsPercent, views: mod.viewsPercent, unsubs:mod.unsubscribesPercent, subs: mod.subsPercent, comments: mod.commentsPercent)
        
        return cell
    }

    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        mods.swapAt(sourceIndexPath.item, proposedDestinationIndexPath.item)
        return proposedDestinationIndexPath;
    }
    
    // Override to support conditional editing of the table view.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            mods.remove(at: indexPath.row)
            saveMods()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // Override to support conditional rearranging of the table view.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            os_log("Adding a new mod.", log: OSLog.default, type: .debug)
            
        case "unwind":
            os_log("Unwinding to lists.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            guard let modInfo = segue.destination as? UINavigationController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedMod = sender as? ModInfoTableViewCell else {
                fatalError("Unexpected sender: \(sender ?? "null")")
            }
            
            guard let indexPath = tableUI.indexPath(for: selectedMod) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let mod = mods[indexPath.row]
            (modInfo.childViewControllers.first as! ModInfoViewController).modInfo = mod
            
        case "Stats":
            guard let modInfo = segue.destination as? UINavigationController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            (modInfo.childViewControllers.first as! StatsViewController).mods = mods
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "null")")
        }
    }
    
    //MARK: Actions
    @IBAction func unwindToModList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ModInfoViewController, let modInfo = sourceViewController.modInfo {
            
            if let selectedIndexPath = tableUI.indexPathForSelectedRow {
                // Update an existing mod.
                mods[selectedIndexPath.row] = modInfo
                tableUI.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new mod.
                let newIndexPath = IndexPath(row: mods.count, section: 0)
                
                mods.append(modInfo)
                tableUI.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        saveMods()
    }
    
    
    
    //MARK: Actions
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The ViewController is not inside a navigation controller.")
        }
    }
    
    class TableViewController: UITableViewController {
    }
    
    //MARK: Private Methods
    private func saveMods() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(mods, toFile: ModInfo.ModURL.path)
        if isSuccessfulSave {
            os_log("Mods successfully saved.", log: OSLog.default, type: .debug)
            print(String(format: "(%d mods saved)", (loadMods()?.count)!))
        } else {
            os_log("Failed to save mods...", log: OSLog.default, type: .error)
        }
    }
    
    private func loadMods() -> [ModInfo]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ModInfo.ModURL.path) as? [ModInfo]
    }
}

//
//  ModInfoTableViewController.swift
//  ModRank
//
//  Created by Nick Fisher on 11/5/17.
//  Copyright © 2017 Nick Fisher. All rights reserved.
//

import UIKit

class ModListTableViewController: UITableViewController {
    
    //MARK: Properties
    var modlists = [[ModInfo]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedModLists = loadModLists() {
            modlists = savedModLists
            print("Loaded " + String(savedModLists.count) + " modlists")
        }
        
        if modlists.count == 0 {
            //loadSampleMods()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modlists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ModListTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ModListTableViewCell else {
            fatalError("The dequeued cell is not an instance of ModListTableViewCell.")
        }
        
        let modlist = modlists[indexPath.row]
        cell.modList = modlist
        cell.refresh()
        //cell.titleLabel.text = modlist[0].itemTitle
        //cell.modImage.image = UIImage(data: modlist.img as Data)
        
        //cell.percentagesStack.refresh(favs: mod.favsPercent, views: mod.viewsPercent, unsubs:mod.unsubscribesPercent, subs: mod.subsPercent, comments: mod.commentsPercent)
        
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            modlists.remove(at: indexPath.row)
            saveModLists()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        modlists.swapAt(fromIndexPath.item, to.item)
    }
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "AddItem":
            print("Adding a new modlist.")
            
        case "ShowDetail":
            guard let modInfoTableViewController = segue.destination as? UINavigationController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedModListCell = sender as? ModListTableViewCell else {
                fatalError("Unexpected sender: \(sender ?? "null")")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedModListCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedModList = modlists[indexPath.row]
            (modInfoTableViewController.childViewControllers.first as! ModInfoTableViewController).mods = selectedModList
            
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier ?? "null")")
        }
    }
    
    //MARK: Actions
    @IBAction func unwindToModLists(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ModInfoTableViewController {
            let modList = sourceViewController.mods
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing mod.
                modlists[selectedIndexPath.row] = modList
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new mod.
                let newIndexPath = IndexPath(row: modlists.count, section: 0)
                
                modlists.append(modList)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        saveModLists()
    }
    
    private func saveModLists() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(modlists, toFile: ModInfo.ListURL.path)
        if isSuccessfulSave {
            print(String(format: "(%d modlists saved)", (loadModLists()?.count)!))
        }
    }
    
    private func loadModLists() -> [[ModInfo]]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ModInfo.ListURL.path) as? [[ModInfo]]
    }
}

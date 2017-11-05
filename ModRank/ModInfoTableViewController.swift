//
//  ModInfoTableViewController.swift
//  ModRank
//
//  Created by Nick Fisher on 11/5/17.
//  Copyright © 2017 Nick Fisher. All rights reserved.
//

import UIKit

class ModInfoTableViewController: UITableViewController {

    //MARK: Properties
    var mods = [ModInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        loadSampleMods()
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
        return mods.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ModInfoTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ModInfoTableViewCell else {
            fatalError("The dequeued cell is not an instance of ModInfoTableViewCell.")
        }

        let mod = mods[indexPath.row]
        
        cell.titleLabel.text = mod.itemTitle
        cell.modImage.image = mod.img
        
        cell.percentagesStack.updatePercentages(favs: mod.favsPercent, views: mod.viewsPercent, unsubs:mod.unsubscribesPercent, subs: mod.subsPercent, comments: mod.commentsPercent)
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Private Methods
    private func loadSampleMods() {
        let photo1 = UIImage(named: "Image1")
        let photo2 = UIImage(named: "Image2")
        let photo3 = UIImage(named: "Image3")
        
        let mod1 = ModInfo(title: "title1", id: 1, itemTitle: "itemtitle1", comments: 1, subs: 1, favs: 1, views: 1, unsubscribes: 1, img: photo1, favsRank: 1, favsPercent: 1.0, subsRank: 1, subsPercent: 1.0, unsubscribesRank: 1, unsubscribesPercent: 1.0, viewsRank: 1, viewsPercent: 1.0, commentsRank: 1, commentsPercent: 1.0)
        let mod2 = ModInfo(title: "title2", id: 2, itemTitle: "itemtitle2", comments: 2, subs: 2, favs: 2, views: 2, unsubscribes: 2, img: photo2, favsRank: 2, favsPercent: 2.0, subsRank: 2, subsPercent: 2.0, unsubscribesRank: 2, unsubscribesPercent: 2.0, viewsRank: 2, viewsPercent: 2.0, commentsRank: 2, commentsPercent: 2.0)
        let mod3 = ModInfo(title: "title3", id: 3, itemTitle: "itemtitle3", comments: 3, subs: 3, favs: 3, views: 3, unsubscribes: 3, img: photo3, favsRank: 3, favsPercent: 3.0, subsRank: 3, subsPercent: 3.0, unsubscribesRank: 3, unsubscribesPercent: 3.0, viewsRank: 3, viewsPercent: 3.0, commentsRank: 3, commentsPercent: 3.0)
        
        mods += [mod1, mod2, mod3]
    }
}
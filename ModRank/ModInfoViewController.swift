//
//  ModInfoViewController.swift
//  ModRank
//
//  Created by Nick Fisher on 11/4/17.
//  Copyright © 2017 Nick Fisher. All rights reserved.
//

import UIKit
import os.log

class ModInfoViewController: UIViewController, UINavigationControllerDelegate, UISearchBarDelegate {
    //MARK: Properties
    @IBOutlet weak var modImage: UIImageView!
    @IBOutlet weak var searchResults: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var modTitle: UILabel!
    @IBOutlet weak var percentagesView: PercentagesView!
    
    let url = "http://modranker-modrank.a3c1.starter-us-west-1.openshiftapps.com/api/items/:"
    
    var currentID: Int?
    var modInfo: ModInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if modInfo != nil {
            updateDisplays()
        }
        
        updateSaveButtonState()
        searchBar.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarCancelButtonClicked(_ bar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ bar: UISearchBar) {
        loadFromAPI(id: bar.text!)
        searchBar.resignFirstResponder()
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
    
    //MARK: Private Functions
    
    private func updateSaveButtonState() {
        // TODO: Disable the Save button if the text field is empty.
        saveButton.isEnabled = !(self.modTitle.text?.isEmpty)!
    }
    
    
    private func loadFromAPI(id: String) {
        let req: String = url + id
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let request = URLRequest(url: URL(string: req)!)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (receivedData, response, error) -> Void in
            if let data = receivedData {
                /*
                let rawDataString = String(data: data, encoding: String.Encoding.utf8)
                print(rawDataString!)
                 */
                
                var jsonResponse : [String:AnyObject]?
                
                do {
                    jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject]
                }
                catch {
                    self.showFail(response: "Caught exception")
                    return
                }
                
                guard let err = jsonResponse?.first
                    else {
                        self.showFail(response: "No response")
                        return
                }
                
                guard err.key != "error"
                    else {
                        if (err.value as! String).starts(with: "404") {
                            self.show404Fail()
                        }
                        else {
                           self.showFail(response: err.value as? String)
                        }
                        return
                }
                
                var img: String? = jsonResponse!["img"] as? String

                if img == nil || img!.isEmpty {
                    img = "https://steamuserimages-a.akamaihd.net/ugc/100600869081028686/995C77B99B7EF5FE58BC696B0C70CB5999502F7C/"
                }
                
                guard let imageData: NSData = NSData(contentsOf: URL(string: img!)!)
                    else {
                        return
                }
                
                DispatchQueue.main.async {
                    self.updateModInfo(mod: ModInfo(title: jsonResponse!["title"] as! String,
                                                    id: jsonResponse!["id"] as! Int,
                                                    itemTitle: jsonResponse!["itemTitle"] as! String,
                                                    comments: jsonResponse!["comments"] as! Int,
                                                    subs: jsonResponse!["subs"] as! Int,
                                                    favs: jsonResponse!["favs"] as! Int,
                                                    views: jsonResponse!["views"] as! Int,
                                                    unsubscribes: jsonResponse!["unsubscribes"] as! Float,
                                                    img: imageData,
                                                    favsRank: jsonResponse!["favsRank"] as! Int,
                                                    favsPercent: (jsonResponse!["favsPercent"] as! NSString).floatValue,
                                                    subsRank: jsonResponse!["subsRank"] as! Int,
                                                    subsPercent: (jsonResponse!["subsPercent"] as! NSString).floatValue,
                                                    unsubscribesRank: jsonResponse!["unsubscribesRank"] as! Int,
                                                    unsubscribesPercent: (jsonResponse!["unsubscribesPercent"] as! NSString).floatValue,
                                                    viewsRank: jsonResponse!["viewsRank"] as! Int,
                                                    viewsPercent: (jsonResponse!["viewsPercent"] as! NSString).floatValue,
                                                    commentsRank: jsonResponse!["commentsRank"] as! Int,
                                                    commentsPercent: (jsonResponse!["commentsPercent"] as! NSString).floatValue))
                }
            }
            else {
                self.showFail(response: "No connection")
            }
        }
        task.resume()
    }
    
    private func updateModInfo(mod: ModInfo)
    {
        self.currentID = mod.id
        self.modInfo = mod
        updateDisplays()
    }
    
    private func updateDisplays() {
        self.modImage.image = UIImage(data: modInfo?.img as! Data)
        self.modTitle.text = modInfo?.itemTitle
        self.percentagesView.updatePercentages(favs: modInfo!.favsPercent, views: modInfo!.viewsPercent, unsubs: modInfo!.unsubscribesPercent, subs: modInfo!.subsPercent, comments: modInfo!.commentsPercent)
        updateSaveButtonState()
    }
    
    private func show404Fail() {
        showFail(response: "Item not found")
    }
    
    private func showFail(response: String?) {
        DispatchQueue.main.async {
            print(response)
            self.searchResults.text = response// ? "ID not found" : "Search error"
            self.searchResults.isHidden = false
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false,
                                 block: {_ in DispatchQueue.main.async { self.searchResults.isHidden = true}})
        }
    }
}


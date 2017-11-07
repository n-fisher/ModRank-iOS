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
        
        if let modInfo = modInfo {
            updateModInfo(mod: modInfo)
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
        self.currentID = Int(bar.text ?? "0")
        loadFromAPI(id: self.currentID!)
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
    
    
    private func loadFromAPI(id: Int) {
        let req: String = url + String(id)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let request = URLRequest(url: URL(string: req)!)
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (receivedData, response, error) -> Void in
            if let data = receivedData {
                let rawDataString = String(data: data, encoding: String.Encoding.utf8)
                print(rawDataString!)
                
                var jsonResponse : [String:AnyObject]?
                
                do {
                    jsonResponse = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:AnyObject]
                }
                catch {
                    print("Caught exception")
                    return
                }
                
                // print dictionary after serialization
                print(jsonResponse!)
                
                // check high-level keys for collections
                print()
                for (key,value) in jsonResponse! {
                    if value is [String:AnyObject] {
                        print("\(key) is a Dictionary")
                    }
                    else if value is [AnyObject] {
                        print("\(key) is an Array")
                    }
                    else {
                        print(type(of: value))
                    }
                }
                
                guard let imageData: NSData = NSData(contentsOf: URL.init(string: jsonResponse!["img"] as! String)!)
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
        }
        
        task.resume()
    }
    
    private func updateModInfo(mod: ModInfo)
    {
        self.modInfo = mod
        self.modImage.image = UIImage(data: modInfo?.img as! Data)
        self.modTitle.text = modInfo?.itemTitle
        self.percentagesView.updatePercentages(favs: mod.favsPercent, views: mod.viewsPercent, unsubs: mod.unsubscribesPercent, subs: mod.subsPercent, comments: mod.commentsPercent)
        updateSaveButtonState()
    }
}


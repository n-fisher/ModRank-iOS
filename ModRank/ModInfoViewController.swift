//
//  ModInfoViewController.swift
//  ModRank
//
//  Created by Nick Fisher on 11/4/17.
//  Copyright © 2017 Nick Fisher. All rights reserved.
//

import UIKit

class ModInfoViewController: UIViewController, UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var modIDLabel: UILabel!
    @IBOutlet weak var modImage: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var modTitle: UINavigationItem!
    
    var modInfo: ModInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let modInfo = modInfo {
            modTitle.title = modInfo.itemTitle
            modImage.image = modInfo.img
        }
        
        updateSaveButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        // Disable the Save button if the text field is empty.
        saveButton.isEnabled = !"".isEmpty
    }
}


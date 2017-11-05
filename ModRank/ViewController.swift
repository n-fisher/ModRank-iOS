//
//  ViewController.swift
//  ModRank
//
//  Created by Nick Fisher on 11/4/17.
//  Copyright © 2017 Nick Fisher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var modIDField: UITextField!
    @IBOutlet weak var modIDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Actions
    @IBAction func addModID(_ sender: UIButton) {
        modIDLabel.text = modIDField.text
    }
    
}


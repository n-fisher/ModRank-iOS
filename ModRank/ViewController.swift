//
//  ViewController.swift
//  ModRank
//
//  Created by Nick Fisher on 11/4/17.
//  Copyright © 2017 Nick Fisher. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var modIDField: UITextField!
    @IBOutlet weak var modIDLabel: UILabel!
    @IBOutlet weak var modImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        modIDField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        modIDLabel.text = textField.text
    }
    
    //MARK: Actions
    @IBAction func changeImage(_ sender: UITapGestureRecognizer) {
        modIDField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    @IBAction func addModID(_ sender: UIButton) {
        modIDLabel.text = modIDField.text
    }
    
}


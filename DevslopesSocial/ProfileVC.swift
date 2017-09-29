//
//  ProfileVC.swift
//  DevslopesSocial
//
//  Created by Raphael M. Hidalgo on 9/29/17.
//  Copyright © 2017 UpliftedStudios. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var usernameField: FancyField!
    @IBOutlet weak var addImage: CircleView!
    
    var imagePicker: UIImagePickerController!
    var imageSelected = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameField.delegate = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
//        if UIImagePickerController.isSourceTypeAvailable(.camera) {
//            imagePicker.sourceType = .camera
//            self.present(imagePicker, animated: true, completion: nil)
//        }
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            addImage.image = image
        } else {
            print("MARCUS: A valid image was not selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    @IBAction func addImageTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func goBtn(_ sender: Any) {
    }
    
}

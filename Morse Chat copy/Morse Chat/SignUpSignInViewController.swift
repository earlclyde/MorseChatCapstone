//
//  AddPhotoViewController.swift
//  Morse Chat
//
//  Created by Mason Earl on 7/18/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import UIKit
import CloudKit
import Foundation


class SignUpSignInViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //Call the create user function
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Buttons and Outlets for sign up view
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var addImageButton: UIButton!
    
    @IBOutlet weak var addProfileImageLabel: UILabel!
    
    @IBAction func saveImageButtonTapped(sender: AnyObject) {
    }
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func createAccountButtonTapped(sender: AnyObject) {
        
        let username = userNameTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let password = passwordTextField.text!
        let firstname = firstNameTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        let lastname = lastNameTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
//        let email = emailTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        if username == "" || password == "" || firstname == "" || lastname == ""  {
            presentViewController(UIAlertController.init(title: "Not So Fast", message: "Please fill in all fields.", preferredStyle: .Alert), animated: true, completion: nil)
            
            if username == "" {
                userNameTextField.superview?.layer.borderColor = UIColor.redColor().CGColor
            }
            
            if password == "" {
                passwordTextField.superview?.layer.borderColor = UIColor.redColor().CGColor
            }
            
            if firstname == "" {
                firstNameTextField.superview?.layer.borderColor = UIColor.redColor().CGColor
            }
            
            if lastname == "" {
                lastNameTextField.superview?.layer.borderColor = UIColor.redColor().CGColor
            }
            
//            if email == "" {
//                emailTextField.superview?.layer.borderColor = UIColor.redColor().CGColor
//            }
            
            dismissViewControllerAnimated(true, completion: nil)
            
            let user = User(userName: username, firstName: firstname, lastName: lastname)
            UserController.sharedController.createUser(user)
            
        }
    }
}


// Capture the text from your text field
// Use the text to create a User using it's init
// Example let user = User(
// Then create user using your UserController.sharedController.createUser(user)



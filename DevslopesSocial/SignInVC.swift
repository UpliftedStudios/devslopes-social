//
//  SignInVC.swift
//  DevslopesSocial
//
//  Created by Raphael M. Hidalgo on 9/13/17.
//  Copyright © 2017 UpliftedStudios. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                print("MARCUS: Unable to authenticate with Facebook - \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("MARCUS: User cancelled Facebook Authentification")
            } else {
                print("MARCUS: Facebook successfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
        
    }
    
    func firebaseAuth(_ credential: AuthCredential) {
        
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("MARCUS: Unable to authenticate with Firebase - \(String(describing: error))")
            } else {
                print("MARCUS: Successfully authenthicated with Firebase")
            }
        })

    }
    
    @IBAction func signInTapped(_ sender: Any) {
        
        if let email = emailField.text, let pwd = pwdField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in
                
                if error == nil {
                    print("MARCUS: Email successfully Authenticated with Firebase")
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("MARCUS: Unable to authenticate with Firebase using email.")
                        } else {
                            print("MARCUS: Sucess with the email, bruh")
                        }
                    })
                }
            })
        }
        
    }
}


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
import SwiftKeychainWrapper

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwdField: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: SEGUE_FEED, sender: nil)
        }
    }

    @IBAction func facebookBtnTapped(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                print("MARCUS: Unable to authenticate with Facebook - \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("MARCUS: User cancelled Facebook Authentification")
            } else {
                print("MARCUS: Successfully authenticated with Facebook")
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
                if let user = user {
                    let userData = ["provider": credential.provider]
                    self.completeSignIn(id: user.uid, userData: userData )
                }
            }
        })

    }
    
    @IBAction func signInTapped(_ sender: Any) {
        
        performSegue(withIdentifier: SEGUE_PROFILE, sender: nil)
        
        if let email = emailField.text, let pwd = pwdField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: { (user, error) in

                if error == nil {
                    print("MARCUS: Email successfully Authenticated with Firebase")
                    if let user = user {
                        let userData = ["provider": user.providerID]
                        self.completeSignIn(id: user.uid, userData: userData)
                    }
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("MARCUS: Unable to authenticate with Firebase using email.")
                        } else {
                            print("MARCUS: Sucess with the email, bruh")
                            if let user = user {
                                let userData = ["provider": user.providerID]
                                self.completeSignIn(id: user.uid, userData: userData)
                            }
                        }
                    })
                }
            })
        }
    }
    
    func completeSignIn(id: String, userData: Dictionary<String, String>) {
//        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
//        let keychainResult = KeychainWrapper.standard.set(id, forKey: KEY_UID)
//        print("MARCUS: Data saved to keychain - \(keychainResult)")
        performSegue(withIdentifier: SEGUE_PROFILE, sender: nil)
    }
}


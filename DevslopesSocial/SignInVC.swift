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
            }
        })

    }
}


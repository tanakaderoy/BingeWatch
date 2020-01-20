//
//  LoginViewController.swift
//  Binge
//
//  Created by Tanaka Mazivanhanga on 11/5/19.
//  Copyright © 2019 Tanaka Mazivanhanga. All rights reserved.
//

import UIKit
import FirebaseUI

class LoginViewController: UIViewController, FUIAuthDelegate {



    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        //FIRApp.configure()
        checkLoggedIn()
    }

    func checkLoggedIn() {
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                // User is signed in.
                self.performSegue(withIdentifier: "goToBinge", sender: nil)
            } else {
                // No user is signed in.
                self.login()
            }
        }
    }

    func login() {
        let authUI = FUIAuth.defaultAuthUI()
        let googleProvider = FUIGoogleAuth()
        let emailProvider = FUIEmailAuth()

        authUI?.delegate = self
        authUI?.providers = [googleProvider, emailProvider]
        let authViewController = authUI?.authViewController()
        authViewController?.modalPresentationStyle = .fullScreen
        self.present(authViewController!, animated: true, completion: nil)
    }

    //try! Auth.auth().signOut()

    internal func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        if error != nil {
            //Problem signing in
            performSegue(withIdentifier: "goToBinge", sender: nil)

        }else {
            //User is in! Here is where we code after signing in
            performSegue(withIdentifier: "goToBinge", sender: nil)


        }
    }
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */



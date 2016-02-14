//
//  ViewController.swift
//  Twitter
//
//  Created by Esme Romero on 2/13/16.
//  Copyright © 2016 Esme Romero. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import AFNetworking





class ViewController: UIViewController {
    
    //var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        
        
             
        
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if let _ = user {
                //perform segue
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                //handle login error
                print("login error")
            }
        }
        
        
       
   }

}
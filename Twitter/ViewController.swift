//
//  ViewController.swift
//  Twitter
//
//  Created by Youcef Iratni on 2/12/16.
//  Copyright © 2016 Youcef Iratni. All rights reserved.
//



import UIKit
import BDBOAuth1Manager
import AFNetworking 


class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
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
            if user != nil {
                 self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                // handle error
            }
        }
        
    }

}


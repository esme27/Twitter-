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





class ViewController: UIViewController{
    
    var tweets: [Tweet]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
        self.tweets = tweets
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
       
        
    }

    func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        

    func onLogin(sender: AnyObject) {
        
        
             
        
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


}
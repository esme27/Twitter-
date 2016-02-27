//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Esme Romero on 2/14/16.
//  Copyright © 2016 Esme Romero. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TweetCellButtonDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
    let delay = 3.0 * Double(NSEC_PER_SEC)
    var tweets: [Tweet]?
    

    override func viewDidLoad() {
                
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        tableView.addSubview(refreshControl)
        
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        
        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil , completion: { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
           self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        
            //can reload here too
        })
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func delay(delay:Double, closure:() -> ()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        delay(1, closure: {
            self.refreshControl.endRefreshing()
        })
    }
    
    
    
    @IBAction func onLogout(sender: AnyObject) {
         User.currentUser!.logout();
        
        
        
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as! TweetCell
        
        cell.buttonDelegate = self
        
//        
//        let url = NSURL(string: tweets![indexPath.row].user!.profileImageUrl!);
//        cell.profilePicture.setImageWithURL(url!)
//        cell.userName.text = tweets![indexPath.row].user!.name!
//        cell.twitterName.text = "@" + (tweets![indexPath.row].user?.screenname!)!
//        cell.Tweetss.text = tweets![indexPath.row].text!
//        cell.tweetTime.text = tweets![indexPath.row].createdAtString!
//        
//        

        cell.tweet = tweets![indexPath.row]
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = self.tweets {
            return tweets.count
            
        }
        return 0
        
    }
    
    func retweetClicked(tweetCell: TweetCell){
        
                        print("here1111111")
        
        
        let tweet = tweetCell.tweet! as Tweet
        
        // Check if tweet has already been retweeted
        // By way of cool ternary operator:
        tweet.isRetweeted! ? (
            // It's been retweeted already... let's unretweet it:
            TwitterClient.sharedInstance.unRetweet(Int(tweetCell.tweetID!)!, params: nil, completion: {(error) -> () in
                tweetCell.retweetButton.setImage(UIImage(named: "retweet-action.png"), forState: UIControlState.Selected)
                
                if tweet.retweetCount! > 1 {
                    tweetCell.retweetLabel.text = String(tweet.retweetCount! - 1)
                } else {
                    tweetCell.retweetLabel.hidden = true
                    tweetCell.retweetLabel.text = String(tweet.retweetCount! - 1)
                }
                
                print("here")
                // locally update tweet dictionary so we don't need to make network request in order to update that cell
                tweet.retweetCount! -= 1
                tweet.isRetweeted! = false
            }) // END CLOSURE
            ) : (
                // YES! HASN'T BEEN RETWEETED, SO LET'S DO THAT:
                TwitterClient.sharedInstance.retweet(Int(tweetCell.tweetID!)!, params: nil, completion: {(error) -> () in
                    tweetCell.retweetButton.setImage(UIImage(named: "retweet-action-on-pressed.png"), forState: UIControlState.Selected)
                    
                    if tweet.retweetCount! > 0 {
                        tweetCell.retweetLabel.text = String(tweet.retweetCount! + 1)
                    } else {
                        tweetCell.retweetLabel.hidden = false
                        tweetCell.retweetLabel.text = String(tweet.retweetCount! + 1)
                    }
                                    print("here2")
                    // locally update tweet dictionary so we don't need to make network request in order to update that cell
                    tweet.retweetCount! += 1
                    tweet.isRetweeted! = true
                }) // END CLOSURE
        ) // END TERNARY OPERATOR

    }
    
    
    
    
    
    
    
    
        func likeClicked(tweetCell: TweetCell) {
            
        }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

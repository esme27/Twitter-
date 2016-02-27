////
//  TweetCell.swift
//  Twitter
//
//  Created by Esme Romero on 2/14/16.
//  Copyright © 2016 Esme Romero. All rights reserved.
//

import UIKit
//import SwiftMoment


protocol TweetCellButtonDelegate: class {
    func retweetClicked(tweetCell: TweetCell)
    func likeClicked(tweetCell: TweetCell)
    
}

class TweetCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var Tweetss: UILabel!
    @IBOutlet weak var twitterName: UILabel!
    @IBOutlet weak var tweetTime: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    
     weak var buttonDelegate: TweetCellButtonDelegate?
    

    var isRetweetButton: Bool = false
    var islikeButton: Bool = false
    
    
    var tweetID: String?
    
    
    var tweet: Tweet! {
        didSet {
            Tweetss.text = tweet.text
            userName.text = tweet.user!.name
            userName.text = "@\(tweet.user!.screenname!)"
            
            profilePicture.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
            
            //<-This is for the time to look nice
            
            
            // (#5R) Starting adding the retweet & favorite outlets + TweetID
            
            tweetID = tweet.id
            retweetLabel.text = String(tweet.retweetCount!)
            likeLabel.text = String(tweet.likeCount!)
            
            retweetLabel.text! == "0" ? (retweetLabel.hidden = true) : (retweetLabel.hidden = false)
            likeLabel.text! == "0" ? (likeLabel.hidden = true) : (likeLabel.hidden = false)
            // (#5R) Done adding the retweet & favorite outlets + TweetID
            
        }
        
        
    }
    
    
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func retweetButton(sender: AnyObject) {
        //retweetButton.setImage(UIImage(named: "RetweetOn"), forState: UIControlState.Normal)
        
//        if self.isRetweetButton {
//            self.retweetLabel.text = String(self.tweet.retweetCount!)
//            self.retweetButton.setImage(UIImage(named: "retweet-action-pressed"), forState: UIControlState.Normal)
//            self.isRetweetButton = false
//            self.tweet.retweetCount!--
//            self.retweetLabel.textColor = UIColor.grayColor()
//            if self.retweetLabel.text == "0" {
//                self.retweetLabel.hidden = true
//            }
//            
//        } else{
//            self.retweetButton.setImage(UIImage(named: "Retweet"), forState: UIControlState.Normal)
//            
//            self.retweetLabel.textColor = UIColor(red: 0.0157, green: 0.9176, blue:0.5137, alpha: 1.0)
//            self.isRetweetButton = true
//
//            self.tweet.retweetCount!++
//            
//            if self.retweetLabel.text == "0"{
//                self.retweetLabel.hidden = false
//            }
//        }
//        self.retweetLabel.text = "\(self.tweet.retweetCount!)"
        if  isRetweetButton{
            isRetweetButton = false
            retweetButton.setImage(UIImage(named: "RetweetOn"), forState: UIControlState.Normal)
        } else {
            isRetweetButton = true
            retweetButton.setImage(UIImage(named: "Retweet"), forState: UIControlState.Normal)
        }
        
        
        
        buttonDelegate?.retweetClicked(self)
                    print("here111")
    }
    
    @IBAction func likeButton(sender: AnyObject) {
        
        if islikeButton{
            islikeButton = false
            likeButton.setImage(UIImage(named: "LikeOn"), forState: UIControlState.Normal)
        } else {
            islikeButton = true
            likeButton.setImage(UIImage(named: "Like"), forState: UIControlState.Normal)
        }
        
        
        //likeButton.setImage(UIImage(named: "LikeOn"), forState: UIControlState.Normal)
        buttonDelegate?.likeClicked(self)
}





//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

// override func setSelected(selected: Bool, animated: Bool) {
//  super.setSelected(selected, animated: animated)

// Configure the view for the selected state
// }


}

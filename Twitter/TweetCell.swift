//
//  TweetCell.swift
//  Twitter
//
//  Created by Esme Romero on 2/14/16.
//  Copyright © 2016 Esme Romero. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var Tweetss: UILabel!
    @IBOutlet weak var twitterName: UILabel!
    @IBOutlet weak var tweetTime: UILabel!
    
    
    
    
   /*
    var tweet: Tweet! {
        didSet {
            Tweetss.text = tweet.text
            userName.text = tweet.user!.name
            userName.text = "@\(tweet.user!.screenname!)"
            
            profilePicture.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
            
             //<-This is for the time to look nice
            
            
            // (#5R) Starting adding the retweet & favorite outlets + TweetID
            
            tweetId = tweet.id
            retweetCountLabel.text = String(tweet.retweetCount!)
            favCountLabel.text = String(tweet.favCount!)
            
            retweetCountLabel.text! == "0" ? (retweetCountLabel.hidden = true) : (retweetCountLabel.hidden = false)
            favCountLabel.text! == "0" ? (favCountLabel.hidden = true) : (favCountLabel.hidden = false)
            // (#5R) Done adding the retweet & favorite outlets + TweetID
            
        }
        
        
    }*/
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  Tweet.swift
//  Twitter
//
//  Created by Esme Romero on 2/14/16.
//  Copyright © 2016 Esme Romero. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var retweetCount: Int? = 0
    var likeCount: Int? = 0
    var id: String
    var isRetweeted: Bool? = false

    
    init(dictionary: NSDictionary) {
        user = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        
        id = String(dictionary["id"]!)
        
        print(id)
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
    
    }
    
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in array {
            tweets.append(Tweet(dictionary: dictionary))
        }
        
        return tweets
    }

}
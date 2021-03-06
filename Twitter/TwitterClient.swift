//
//  TwitterClient.swift
//  Twitter
//
//  Created by Youcef Iratni on 2/12/16.
//  Copyright © 2016 Youcef Iratni. All rights reserved.
//


import UIKit
import BDBOAuth1Manager
import AFNetworking

let twitterConsumerKey = "5qtq9cPEQro5QgrLEcy4qsfX8"
let twitterConsumerSecret = "YvpQSp8gMn1QQpWhsfaoPd9xbqwudQP5KMBOxDgrTVBvuXoqWI"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {

    var loginWithCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(
                baseURL: twitterBaseURL,
                consumerKey: twitterConsumerKey,
                consumerSecret: twitterConsumerSecret
            )
        }
        
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject) -> Void in
            let tweets = Tweet.tweetsWithArray(response as! [NSDictionary])
            
            completion(tweets: tweets, error: nil)
            
            }, failure: { (operation:NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error getting home timeline")
                completion(tweets: nil, error: error)
        })
        
    }
    
    
    func retweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/statuses/retweet/\(id).json", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                completion(error: error)
            }
        )
    }
    
    
    func undoretweet(retweetedTweetID: Int, params: NSDictionary?, completion: (error: NSError?) -> ()) {
        POST("/1.1/statuses/destroy/\(retweetedTweetID).json", parameters: params, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, err: NSError!) -> Void in
                completion(error: err)
        })
    }
    
    
    
    func likeTweet(id: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/favorites/create.json?id=\(id)", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                completion(error: error)
            }
        )}
    
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
        loginWithCompletion = completion
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Got the request token")
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            }) { (error: NSError!) -> Void in
                print("Failed to get request token: \(error)")
                self.loginWithCompletion?(user: nil, error: error)
        }
    }
    
    func openURL(url: NSURL){
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query)!, success: { (accessToken: BDBOAuth1Credential!) -> Void in
            print("Got the access token!")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject) -> Void in
                let user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                self.loginWithCompletion?(user: user, error: nil)
                }, failure: { (operation:NSURLSessionDataTask?, error: NSError) -> Void in
                    print("error getting current user")
                    self.loginWithCompletion?(user: nil, error: error)
            })
        }) { (error: NSError!) -> Void in
            print("Failed to receive access token")
            self.loginWithCompletion?(user: nil, error: error)
        }
    }
    
    
    func ComposeTweet(escapedTweet: String, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/statuses/update.json?status=\(escapedTweet)", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("tweeted: \(escapedTweet)")
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Couldn't compose")
                completion(error: error)
            }
        )
    }
    
    
    func ReplyToTweet(escapedTweet: String, statusID: Int, params: NSDictionary?, completion: (error: NSError?) -> () ){
        POST("1.1/statuses/update.json?in_reply_to_status_id=\(statusID)&status=\(escapedTweet)", parameters: params, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("tweeted: \(escapedTweet)")
            completion(error: nil)
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("Couldn't reply")
                completion(error: error)
            }
        )
    }
    
}

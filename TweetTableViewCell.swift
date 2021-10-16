//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Desmond Ofori Atta on 10/7/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var retweet: UIButton!
    @IBOutlet weak var like: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetHandle: UILabel!
    @IBOutlet weak var tweet: UITextView!
    @IBOutlet weak var commentCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var tweetImage: UIImageView!
    
    var liked:Bool = false
    var retweeted:Bool = false
    var tweetID:Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setLiked(_ isLiked:Bool){
        liked = isLiked
        if(liked){
            like.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            like.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweet(_ isRetweeted:Bool){
        retweeted = isRetweeted
        if(retweeted){
            retweet.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
        }
        else{
            retweet.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func retweetClicked(_ sender: Any) {
        let isRetweeted = !retweeted
        if(isRetweeted){
            TwitterAPICaller.client?.retweetTweet(tweetID: tweetID, success: {
                self.setRetweet(isRetweeted)
            }, failure: { (Error) in
                print("Could not retweet tweet")
            })
        }
        else{
            TwitterAPICaller.client?.unretweetTweet(tweetID: tweetID, success: {
                self.setRetweet(isRetweeted)
            }, failure: { (Error) in
                print("Could not unretweet tweet")
            })
        }
    }
    
    @IBAction func likeClicked(_ sender: Any) {
        let isLiked = !liked
        if(isLiked){
            TwitterAPICaller.client?.likeTweet(tweetID: tweetID, success: {
                self.setLiked(isLiked)
            }, failure: { (Error) in
                print("Could not like tweet")
            })
        }
        else{
            TwitterAPICaller.client?.unlikeTweet(tweetID: tweetID, success: {
                self.setLiked(isLiked)
            }, failure: { (Error) in
                print("Could not unlike tweet")
            })
        }
    }
}

//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Desmond Ofori Atta on 10/7/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    var tweets = [NSDictionary]()
    var numberofTweet : Int!
    let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
//        tableView.rowHeight = 100
        loadTweets()
        refresh.addTarget(self, action: #selector(loadTweets), for: .valueChanged)
        tableView.refreshControl = refresh
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadTweets()
    }

    @IBAction func logoutButtonClicked(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    @objc func loadTweets(){
        numberofTweet = 20
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = [
            "count": numberofTweet!
        ]
        as [String : Any]
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: params as [String : Any], success: { (tweets:[NSDictionary]) in
            
            self.tweets.removeAll()
            for tweet in tweets {
                self.tweets.append(tweet)
            }
            self.tableView.reloadData()
            self.refresh.endRefreshing()
            
        }, failure: { (Error) in
            print("Could not retrieve tweet")
            print("Firiiiirrrrrssstt")
            print(Error)
        })
    }
    
    func loadMoreTweets(){
        numberofTweet = numberofTweet + 20
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = [
            "count": numberofTweet!
        ]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: params, success: { (tweets:[NSDictionary]) in
            
            self.tweets.removeAll()
            for tweet in tweets {
                self.tweets.append(tweet)
            }
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("Could not retrieve tweet")
            print("Heerrrreeee")
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == tweets.count {
            loadMoreTweets()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetTableViewCell
        
        let tweet = tweets[indexPath.row]
        
        cell.tweet.text = tweet["text"] as? String
        
        let user = tweet["user"] as! NSDictionary
        cell.tweetHandle.text = user["name"] as? String
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data {
            cell.profileImage.image = UIImage(data: imageData)
        }
        
        cell.tweetID = tweet["id"] as? Int ?? -1
        cell.setLiked(tweet["favorited"] as? Bool ?? false)
        cell.setRetweet(tweet["retweeted"] as? Bool ?? false)
        
        return cell
    }

}

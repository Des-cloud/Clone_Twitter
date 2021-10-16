//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Desmond Ofori Atta on 10/15/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var bio: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var backdropImage: UIImageView!
    
    var user = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2
//        backButton.setImage(UIImage(named: "back-icon"), for: UIControl.State.normal)
        
        let url = "https://api.twitter.com/1.1/account/verify_credentials.json"
        let params = [
            "include_entities": false,
            "include_email": false
        ]
        
        TwitterAPICaller.client?.getDictionaryRequest(url: url, parameters: params, success: { (user:NSDictionary) in
            
            self.name.text = user["name"] as? String
            self.handle.text = "@\(user["screen_name"] ?? "user1234")"
            self.bio.text = user["description"] as? String ?? "My bio"
            self.following.text = "\(user["followers_count"] as! Int)"
            self.followers.text = "\(user["friends_count"] as! Int)"
            self.tweetCount.text = "\(user["statuses_count"] as! Int)"
            
            let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
            let data = try? Data(contentsOf: imageUrl!)
            
            if let imageData = data {
                self.profileImage.image = UIImage(data: imageData)
            }
            
            if(!(user["default_profile"] as? Bool)!){
                let bannerUrl = URL(string: (user["profile_background_image_url_https"] as? String)!)
                let backdropData = try? Data(contentsOf: bannerUrl!)
                
                if let backdropimageData = backdropData {
                    self.backdropImage.image = UIImage(data: backdropimageData)
                }
            }
            
        }, failure: { (Error) in
            print("Could not retrieve User profile")
        })
    }

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
}

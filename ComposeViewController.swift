//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Desmond Ofori Atta on 10/14/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var tweetString: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetString.becomeFirstResponder()
    }
    
    @IBAction func cancelTweet(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendTweet(_ sender: Any) {
        if(!tweetString.text.isEmpty){
            TwitterAPICaller.client?.sendTweet(tweet: tweetString.text, success: {
                self.dismiss(animated: true, completion: nil)
                
            }, failure: { (Error) in
                print("Could not post tweet => Reason: \(Error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
        else{
            print("No text to post")
            self.dismiss(animated: true, completion: nil)
        }
    }
}

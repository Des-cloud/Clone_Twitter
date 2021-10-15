//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Desmond Ofori Atta on 10/14/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var tweetString: UITextView!
    @IBOutlet weak var characterCount: UILabel!
    
    let characterLimit = 280
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tweetString = RSKPlaceholderTextView(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 100))
        tweetString.delegate = self
        tweetString.becomeFirstResponder()
        
        tweetString.tintColor = UIColor.white
        tweetString.tintColor = UIColor.black
        
        self.view.addSubview(self.tweetString)
        
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
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        if(characterLimit - newText.count > 0){
            characterCount.text = String(characterLimit - newText.count)
        }
        else {
            characterCount.text = String(0)
        }
        return newText.count < characterLimit
    }

}

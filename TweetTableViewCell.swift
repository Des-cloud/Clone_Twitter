//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Desmond Ofori Atta on 10/7/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetHandle: UILabel!
    @IBOutlet weak var tweet: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

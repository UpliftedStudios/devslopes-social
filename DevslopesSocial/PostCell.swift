//
//  PostCell.swift
//  DevslopesSocial
//
//  Created by Raphael M. Hidalgo on 9/23/17.
//  Copyright © 2017 UpliftedStudios. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    
    var post: Post!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(post: Post, image: UIImage? = nil) {
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"
        
        if image != nil {
            self.postImg.image = image
        } else {
                let ref = Storage.storage().reference(forURL: post.imageURL)
                ref.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
                    if error != nil {
                        print("MARCUS: Unable to download image from Firebase Storage")
                    } else {
                        print("MARCUS: Image downloaded from Firebase")
                        if let imageData = data {
                            if let img = UIImage(data: data!) {
                                self.postImg.image = img
                                FeedVC.imageCache.setObject(img, forKey: post.imageURL as NSString)
                            }
                        }
                }
            }
        )}
    }
}

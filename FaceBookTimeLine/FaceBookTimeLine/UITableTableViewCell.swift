//
//  UITableTableViewCell.swift
//  FaceBookTimeLine
//
//  Created by 김현석 on 2020/06/28.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit

class UITableTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var arrow: UIImageView!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var hour: UILabel!
    
    @IBOutlet weak var contentText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.layer.borderWidth = 1
        userImage.layer.borderColor = UIColor.clear.cgColor
        userImage.clipsToBounds = true
        
        userImage.image = UIImage(named: "andrew.jpg")
        userName.text = "andrew"
        arrow.image = UIImage(named: "png.png")
        destination.text = "urssu"
        hour.text = "1hour later"
        
        contentText.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

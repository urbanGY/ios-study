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
    
    @IBOutlet weak var commentView: UIStackView!
    
    @IBOutlet weak var writer: UIImageView!
    @IBOutlet weak var commentBar: UITextField!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    var idx = 0
    
    @IBAction func register(_ sender: UIButton) {
        let writerImg = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        writerImg.center = CGPoint(x: 40, y: 215 + (idx * 55))
        writerImg.image = UIImage(named: "jspark.jpg")
        writerImg.layer.cornerRadius = writerImg.frame.height/2
        writerImg.layer.borderWidth = 1
        writerImg.layer.borderColor = UIColor.clear.cgColor
        writerImg.clipsToBounds = true
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 20))
        label.center = CGPoint(x: 225, y: 215 + (idx * 55))
        label.textAlignment = .left
        label.text = commentBar.text!
        commentBar.text = ""
        
        idx += 1
        self.addSubview(writerImg)
        self.addSubview(label)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = userImage.frame.height/2
        userImage.layer.borderWidth = 1
        userImage.layer.borderColor = UIColor.clear.cgColor
        userImage.clipsToBounds = true
        userImage.image = UIImage(named: "andrew.jpg")
        
        userName.text = "andrew"
        arrow.image = UIImage(named: "arrow.png")
        destination.text = "urssu"
        hour.text = "1hour later"
        
        contentText.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        
        writer.layer.cornerRadius = writer.frame.height/2
        writer.layer.borderWidth = 1
        writer.layer.borderColor = UIColor.clear.cgColor
        writer.clipsToBounds = true
        writer.image = UIImage(named: "jspark.jpg")
                
        registerBtn.layer.cornerRadius = registerBtn.frame.height/2
        registerBtn.layer.borderWidth = 1
        registerBtn.layer.borderColor = UIColor.clear.cgColor
        registerBtn.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        print("select")
    }

}

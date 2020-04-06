//
//  ContentTableViewCell.swift
//  NoticeBoard
//
//  Created by 김현석 on 31/03/2020.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {

//    @IBOutlet weak var fileImage: UIImageView!
    @IBOutlet weak var downloadFileName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

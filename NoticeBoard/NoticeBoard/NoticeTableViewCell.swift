//
//  NoticeTableViewCell.swift
//  NoticeBoard
//
//  Created by 김현석 on 28/03/2020.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit

class NoticeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var noticeCell: UILabel!
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var dateCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

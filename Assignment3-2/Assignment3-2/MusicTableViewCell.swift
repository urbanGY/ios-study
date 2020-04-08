//
//  MusicTableViewCell.swift
//  Assignment3-2
//
//  Created by 김현석 on 2020/04/07.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var musicTitle: UILabel!
    @IBOutlet weak var musicDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

//
//  MusicData.swift
//  Assignment3-2
//
//  Created by 김현석 on 2020/04/07.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import Foundation
import UIKit

class MusicData {
    private var title: String
    private var description: String
    private var img: UIImage?
    private var imageUrl: String
    private var linkUrl: String
    
    init(title:String, description:String, imageUrl:String, linkUrl:String) {
        self.title = title
        self.description = description
        self.img = nil
        self.imageUrl = imageUrl
        self.linkUrl = linkUrl
    }

    func getData() -> (String, String) {
        return (self.title, self.description)
    }
    
    func setImg(_ img: UIImage) -> Void {
        self.img = img
    }
    
    func getImg() -> UIImage? {
        return self.img
    }
    
    func getImgUrl() -> String {
        return self.imageUrl
    }
    
    func getLink() -> String {
        return self.linkUrl
    }
    
    
}

//
//  DownloadData.swift
//  Assignment4
//
//  Created by 김현석 on 2020/04/09.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import Foundation

class DownloadData {
    private var title: String
    private var link: String
    
    init(title:String, link:String){
        self.title = title
        self.link = link
    }
    
    func getTitle() -> String {
        return self.title
    }
    
    func getLink() -> String {
        return self.link
    }
}

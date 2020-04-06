//
//  noticeModel.swift
//  Assignment2
//
//  Created by 김현석 on 2020/04/06.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import Foundation

class NoticeData {
    var title: String
    var content: String
    
    init(title:String, content:String) {
        self.title = title
        self.content = content
    }
    
    func getTitle() -> String {
        return self.title
    }
    
    func getContent() -> String {
        return self.content
    }
    
    static var noticeList: [NoticeData] = []
}

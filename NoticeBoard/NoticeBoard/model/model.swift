//
//  model.swift
//  NoticeBoard
//
//  Created by 김현석 on 26/03/2020.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import Foundation

class NoticeData {
    var IsNotice: Bool
    var Title: String
    var Date: String
    var url: String
    
    init(isNotice:Bool, title:String, date:String, url:String) {
        self.IsNotice = isNotice
        self.Title = title
        self.Date = date
        self.url = "https://sw.ssu.ac.kr/" + url
    }
    
    func GetIsNotice() -> String {
        if self.IsNotice {
            return "공지"
        }else {
            return "  "
        }
    }
    
    func GetTitle() -> String {
        return self.Title
    }
    
    func GetDate() -> String {
        return self.Date
    }
    
    func GetUrl() -> String {
        return self.url
    }
    
    static var noticeList: [NoticeData] = []
}

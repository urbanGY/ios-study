//
//  NoticeData.swift
//  Assignment3
//
//  Created by 김현석 on 2020/04/07.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import Foundation

class NoticeData {
    var title: String
    var date: String
    
    init(title:String, date:String){
        self.title = title
        self.date = date
    }
    
    func getData() -> (String, String) {
        return (self.title, self.date)
    }
}

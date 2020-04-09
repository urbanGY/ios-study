//
//  NoticeData.swift
//  Assignment4
//
//  Created by 김현석 on 2020/04/09.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import Foundation

class NoticeData {
    private var title: String
    private var date: String
    private var detailUrl: String
    
    init(title: String, date: String, detailUrl: String){
        self.title = title
        self.date = date
        self.detailUrl = detailUrl
    }
    
    func getCellData() -> (String, String) {
        return (self.title, self.date)
    }
    
    func getDatailUrl() -> String {
        return self.detailUrl
    }
}

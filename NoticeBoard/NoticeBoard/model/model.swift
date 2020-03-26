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
    
    init(isNotice:Bool, title:String, date:String) {
        self.IsNotice = isNotice
        self.Title = title
        self.Date = date
    }
    
    func GetIsNotice() -> Bool {
        return self.IsNotice
    }
    
    func GetTitle() -> String {
        return self.Title
    }
    
    func GetDate() -> String {
        return self.Date
    }
}

//
//  model.swift
//  Memo
//
//  Created by 김현석 on 25/03/2020.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import Foundation

class Data {
    var Title: String
    var Content: String
    
    init(title:String, content: String) {
        self.Title = title
        self.Content = content
    }
    
    func GetTitleText() -> String {
        return self.Title
    }
    
    func GetContentText() -> String {
        return self.Content
    }
    
    static var DataList: [Data] = []
}

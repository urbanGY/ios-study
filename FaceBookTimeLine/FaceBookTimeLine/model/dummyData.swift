//
//  dummyData.swift
//  FaceBookTimeLine
//
//  Created by 김현석 on 2020/06/28.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import Foundation

class DummyData {
    var content:String
    
    init(content:String){
        self.content = content
    }
    
    func getContent() -> String {
        return self.content
    }
}

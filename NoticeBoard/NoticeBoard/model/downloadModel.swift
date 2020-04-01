//
//  downloadModel.swift
//  NoticeBoard
//
//  Created by 김현석 on 01/04/2020.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import Foundation

class DownloadFile {
    var fileName: String
    var fileImageName: String
    var fileUrl: String
    
    init(fileName:String, fileImageName:String, fileUrl:String) {
        self.fileName = fileName
        self.fileImageName = fileImageName
        self.fileUrl = fileUrl
    }
    
    func GetFileName() -> String {
        return self.fileName
    }
    
    func GetFileImageName() -> String {
        return self.fileImageName
    }
    
    func GetFileUrl() -> String {
        return self.fileUrl
    }
}

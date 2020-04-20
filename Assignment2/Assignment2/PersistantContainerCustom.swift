//
//  PersistantContainerCustom.swift
//  MemoWidget
//
//  Created by 김현석 on 2020/04/20.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import Foundation
import CoreData

class NSCustomPersistentContainer: NSPersistentContainer {
    
    override open class func defaultDirectoryURL() -> URL {
//        let documentsDirectory = FileManager().containerURL(forSecurityApplicationGroupIdentifier: "group.Assignment2")
//        let storeURL = documentsDirectory?.appendingPathComponent("Memo.sqlite")
        var storeURL = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.sfsfkj.Assignment2")
//        storeURL = storeURL?.
//        storeURL = storeURL?.appendingPathComponent("Assignment2")
//        storeURL = storeURL?.appendingPathComponent("Memo")
//        if let storeUrl = storeURL {
//            print("store is not null")
//        }else {
//            print("store is null")
//        }
        return storeURL!
    }

}

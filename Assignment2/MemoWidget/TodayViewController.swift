//
//  TodayViewController.swift
//  MemoWidget
//
//  Created by 김현석 on 2020/04/16.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit
import NotificationCenter
class TodayViewController: UIViewController, NCWidgetProviding {
    lazy var secureAppGroupPersistentStoreURL : URL = {
       let fileManager = FileManager.default
       let groupDirectory = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.Assignment2")!
       return groupDirectory.appendingPathComponent("Memo")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}

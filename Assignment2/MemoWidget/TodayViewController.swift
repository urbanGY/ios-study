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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let memo: [Memo] = CoreManager.shared.getMemo(ascending: true)
        print("length memo : \(memo.count)")
        for elem in memo {
            let saveId = elem.id
            print("save id : \(saveId)")
            let saveTitle = elem.title!
            print("save title : \(saveTitle)")
            let saveContent = elem.content!
            print("save content : \(saveContent)\n")
        }
        print("load")
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

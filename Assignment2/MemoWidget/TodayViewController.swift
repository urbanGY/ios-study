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
    
//    @IBOutlet weak var gotoList: UIButton!
//    @IBOutlet weak var label1: UIButton!
//    @IBOutlet weak var label2: UIButton!
//    
//    @IBAction func gotoListBtn(_ sender: UIButton) {
//    }
//    
//    @IBAction func label1Btn(_ sender: UIButton) {
//    }
//    
//    @IBAction func label2Btn(_ sender: UIButton) {
//    }
    var memoId_1:Int64 = 0
    var memoId_2:Int64 = 0
    
    @IBOutlet weak var gotoList: UIButton!
    @IBOutlet weak var label1: UIButton!
    @IBOutlet weak var label2: UIButton!
    
    @IBAction func gotoBtn(_ sender: UIButton) {
        let url = "urssu:memo?id=main"
        guard let schemeURL = URL(string: url) else{
            print("scheme url is not right!")
            return
        }

        self.extensionContext?.open(schemeURL, completionHandler: {
            (bool) -> Void in
            print("open url : \(bool)")
        })
    }
    
    //        if UIApplication.shared.canOpenURL(schemeURL){
    //            print(schemeURL)
    //            UIApplication.shared.open(schemeURL, options: [:], completionHandler: {
    //                (bool) -> Void in
    //                print(bool)
    //            })
    //        }
    
    @IBAction func label1Btn(_ sender: UIButton) {
        let url = "urssu:memo?id=\(memoId_1)"
        guard let schemeURL = URL(string: url) else{
            print("scheme url is not right!")
            return
        }

        self.extensionContext?.open(schemeURL, completionHandler: {
            (bool) -> Void in
            print("open url : \(bool)")
        })
    }
    
    @IBAction func label2Btn(_ sender: UIButton) {
        let url = "urssu:memo?id=\(memoId_2)"
        guard let schemeURL = URL(string: url) else{
            print("scheme url is not right!")
            return
        }

        self.extensionContext?.open(schemeURL, completionHandler: {
            (bool) -> Void in
            print("open url : \(bool)")
        })
    }
    
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
        var index = memo.count-1
        var i:Int = 0
        while i < 2 && index >= 0 {
            if(i == 0){
                label1.setTitle(memo[index].title, for: .normal)
                memoId_1 = memo[index].id
            }else {
                label2.setTitle(memo[index].title, for: .normal)
                memoId_2 = memo[index].id
            }
            i += 1
            index -= 1
        }
        
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}

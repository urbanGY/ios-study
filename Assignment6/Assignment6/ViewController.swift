//
//  ViewController.swift
//  Assignment6
//
//  Created by 김현석 on 2020/04/10.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var input_1: UITextField!
    @IBOutlet weak var input_2: UITextField!
    @IBOutlet weak var result: UILabel!
    
    @IBAction func addBtn(_ sender: UIButton) {
        let val_1 = Int(input_1.text!)
        let val_2 = Int(input_2.text!)
        let result = String(val_1! + val_2!)
        NotificationCenter.default.post(name: NSNotification.Name("setResult"), object: result)
    }
    @IBAction func minBtn(_ sender: UIButton) {
        let val_1 = Int(input_1.text!)
        let val_2 = Int(input_2.text!)
        let result = String(val_1! - val_2!)
        NotificationCenter.default.post(name: NSNotification.Name("setResult"), object: result)
    }
    @IBAction func mulBtn(_ sender: UIButton) {
        let val_1 = Int(input_1.text!)
        let val_2 = Int(input_2.text!)
        let result = String(val_1! * val_2!)
        NotificationCenter.default.post(name: NSNotification.Name("setResult"), object: result)
    }
    @IBAction func divBtn(_ sender: UIButton) {
        let val_1 = Int(input_1.text!)
        let val_2 = Int(input_2.text!)
        let result = String(val_1! / val_2!)
        NotificationCenter.default.post(name: NSNotification.Name("setResult"), object: result)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(receiveResult(_:)),
                                               name: NSNotification.Name("setResult"),
                                               object: nil)
    }
    
    @objc func receiveResult(_ notification: Notification) {
        let resultVal = notification.object as! String
        result.text = resultVal
    }


}


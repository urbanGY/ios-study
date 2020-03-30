//
//  ContentViewController.swift
//  NoticeBoard
//
//  Created by 김현석 on 30/03/2020.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit
import WebKit

class ContentViewController: UIViewController {
    var data: NoticeData?    
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ReadViewController.swift
//  Memo
//
//  Created by 김현석 on 25/03/2020.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit

class ReadViewController: UIViewController {
    
    var data: Data?
    @IBOutlet weak var TitleText: UILabel!
    @IBOutlet weak var ContentText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleText: String? = data?.GetTitleText()
        let contentText: String? = data?.GetContentText()
        TitleText.text = titleText
        ContentText.text = contentText
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



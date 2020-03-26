//
//  WriteViewController.swift
//  Memo
//
//  Created by 김현석 on 25/03/2020.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit

class WriteViewController: UIViewController {

    @IBOutlet weak var TitleText: UITextField!
    @IBOutlet weak var ContentText: UITextView!
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil) //completion은 취소되고 난 후 실행될 함수
    }
    
    @IBAction func restore(_ sender: Any) {
        let title = TitleText.text!
        let content = ContentText.text!
        let data = Data(title: title, content: content)
        Data.DataList.append(data)
        dismiss(animated: true, completion: nil) //completion은 취소되고 난 후 실행될 함수
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation gg

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

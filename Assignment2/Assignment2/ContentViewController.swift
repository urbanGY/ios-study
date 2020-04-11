//
//  ContentViewController.swift
//  Assignment2
//
//  Created by 김현석 on 2020/04/06.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var contentText: UITextView!
    
    var delegate: contentDelegate?
    var noticeData: NoticeData? = nil
    var rowIndex: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let noticeData = noticeData {
            titleText.text = noticeData.getTitle()
            contentText.text = noticeData.getContent()
        }
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        let title = titleText.text!
        let content = contentText.text!
        CoreManager.shared.saveMemo(title: title, content: content) { onSuccess in
            print("saved = \(onSuccess)")
        }
        let data = NoticeData(title: title, content: content)
        delegate?.provider(data, rowIndex)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func deleteButton(_ sender: UIButton) {
        if let curTitle = self.noticeData?.getTitle() { // 만약 저장하기 전에 바로 삭제버튼을 누른다면 noticeData 배열에 주가되기 전임으로 nil이 된다.
            CoreManager.shared.deleteMemo(title: curTitle) { onSuccess in
                print("deleted = \(onSuccess)")
            }
            delegate?.remover(rowIndex)
        }
        self.navigationController?.popViewController(animated: true)
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

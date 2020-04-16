//
//  ViewController.swift
//  Assignment2
//
//  Created by 김현석 on 2020/04/06.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit

protocol contentDelegate {
    func provider(_ noticeData:NoticeData, _ rowIndex:Int?)
    func remover(_ rowIndex:Int?)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, contentDelegate { // 여기에 delegate 꼭 추가해줘야 아래에 = self 가 가능
    var maxId:Int64 = 0
    var noticeList:[NoticeData] = []
    @IBOutlet weak var noticeTableView: UITableView!
    
    func provider(_ noticeData:NoticeData, _ rowIndex:Int?) {
        var title = noticeData.getTitle()
        var content = noticeData.getContent()
        var id: Int64
        
        if let row = rowIndex {
            noticeList[row] = noticeData
            id = noticeData.getId()
        }else {
            maxId = maxId + 1
            id = maxId
            noticeData.setId(id: id)
            noticeList.append(noticeData)
        }
        
        CoreManager.shared.saveMemo(id: id, title: title, content: content) { onSuccess in
            print("saved = \(onSuccess)")
        }
    }
    
    func remover(_ rowIndex: Int?) {
        self.noticeList.remove(at: rowIndex!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noticeTableView.delegate = self
        noticeTableView.dataSource = self
        let memo: [Memo] = CoreManager.shared.getMemo(ascending: true)
        for elem in memo {
            let saveId = elem.id
            print("save id : \(saveId)")
            let saveTitle = elem.title!
            let saveContent = elem.content!
            var data = NoticeData(title: saveTitle, content: saveContent)
            data.setId(id: saveId)
            self.noticeList.append(data)
        }
        maxId = self.noticeList[self.noticeList.count-1].getId()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        noticeTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as! NoticeTableViewCell
        let target = noticeList[indexPath.row]
        cell.cellTitle.text = target.getTitle()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let vc = segue.destination as? ContentViewController {
                if let cell = sender as? NoticeTableViewCell, let indexPath = noticeTableView.indexPath(for: cell) {
                    let sendData = noticeList[indexPath.row]
                    vc.noticeData = sendData
                    vc.rowIndex = indexPath.row
                    vc.delegate = self
                }
            }
        }
        if segue.identifier == "newMemo" {
            if let vc = segue.destination as? ContentViewController {
                vc.delegate = self
            }
        }
    }
}


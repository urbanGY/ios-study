//
//  NoticeTableViewController.swift
//  Assignment4
//
//  Created by 김현석 on 2020/04/09.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class NoticeTableViewController: UITableViewController {
    
    var itemList: [NoticeData] = []
    var baseUrl = "https://scatch.ssu.ac.kr/%EA%B3%B5%EC%A7%80%EC%82%AC%ED%95%AD/page/"
    var index = 1
    var flag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.requestData()
    }

    func requestData() -> Void {
        let requestUrl = baseUrl + "\(index)/"
        let url = URL(string: requestUrl)
        AF.request(url!).response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                self.parsing(utf8Text)
            }
        }
    }
    
    func parsing(_ htmlData: String) -> Void {
        do {
            let htmlText = try HTML(html: htmlData, encoding: .utf8)
            var titleSafe:String, dateSafe:String, urlSafe:String
            for li in htmlText.xpath("//*[@id=\"contents\"]/div/div/div/div/div/div[2]/div/ul/li") {
                if let date = li.at_xpath(".//div/div[1]/div") {
                    dateSafe = date.text!
                }else {
                    continue
                }
                if let title = li.at_xpath(".//div/div[3]/a/span/span[2]") {
                    titleSafe = title.text!
                }else {
                    continue
                }
                if let anchor = li.at_xpath(".//div/div[3]/a") {
                    urlSafe = anchor["href"]!
                }else {
                   continue
                }
                self.itemList.append(NoticeData(title: titleSafe, date: dateSafe, detailUrl: urlSafe))
            }
            index += 1
            tableView.reloadData()
            flag = true
        }catch let error {
            print("Error int pharsing: \(error)")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath)
        let target = self.itemList[indexPath.row]
        var title:String, date:String
        (title, date) = target.getCellData()
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = date
        return cell
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let vc = segue.destination as? DetailViewController {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let url = itemList[indexPath.row].getDatailUrl()
                    vc.url = url
                }
            }
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if flag {
                flag = false
                self.requestData()
            }
        }
    }
    
}

//
//  NoticeTableViewController.swift
//  Assignment3
//
//  Created by 김현석 on 2020/04/07.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class NoticeTableViewController: UITableViewController {
    var noticeList: [NoticeData] = []
    var baseUrl = "https://scatch.ssu.ac.kr/%EA%B3%B5%EC%A7%80%EC%82%AC%ED%95%AD/page/"
    var index = 1
    var flag = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestData()
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
        //*[@id="contents"]/div/div/div/div/div/div[2]/div/ul/li[2]/div/div[1]/div
        //*[@id="contents"]/div/div/div/div/div/div[2]/div/ul/li[2]/div/div[3]/a/span/span[2]
        //*[@id="contents"]/div/div/div/div/div/div[2]/div/ul/li[3]
        print("in parsing")
        do {
            let htmlText = try HTML(html: htmlData, encoding: .utf8)
            var titleSafe:String, dateSafe:String
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
                self.noticeList.append(NoticeData(title: titleSafe, date: dateSafe))
            }
            index += 1
            tableView.reloadData()
            flag = true
        }catch let error {
            print("Error int pharsing: \(error)")
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noticeList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath)
        let target = self.noticeList[indexPath.row]
        var title:String, date:String
        (title, date) = target.getData()
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = date
        return cell
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

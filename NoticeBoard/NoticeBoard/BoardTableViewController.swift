//
//  BoardTableViewController.swift
//  NoticeBoard
//
//  Created by 김현석 on 26/03/2020.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class BoardTableViewController: UITableViewController {
    var doneNoticeFlag: Bool = false;
    var endFlag: Bool = false;
    var index: Int = 1;
    var moreFetch: Bool = true;
    
    @IBOutlet var customCellTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customCellTableView.delegate = self
        customCellTableView.dataSource = self
        self.crawlingData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem gg
    }
    func crawlingData() -> Void {
        var baseUrl: String = "https://sw.ssu.ac.kr/bbs/board.php?bo_table=sub6_1&page="
        let requestUrl: String = baseUrl + String(index)
        let url = URL(string: requestUrl)
        AF.request(url!).response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                self.parsing(utf8Text)
            }
        }
    }
    
    func parsing(_ inputHtml:String) -> Void {
        do {
            let htmlText = try HTML(html: inputHtml, encoding: .utf8)
            for tr in htmlText.xpath("//tr[@class='bg1'] | //tr[@class='bg0'] ") {
                var isNotice: Bool!
                var title: String!
                var date: String!

                if let checkNotice = tr.at_xpath("td[@class='num']/b"){
                    isNotice = true
                } else {
                    isNotice = false
                }
//                print("isNotice : \(isNotice!) , doneNotice : \(doneNoticeFlag)")
                if doneNoticeFlag && isNotice {
                    continue
                }
                if let titleVal = tr.at_xpath(".//span[@class='notice'] | .//a") {
                    title = titleVal.text!
                }
                if let dateVal = tr.at_xpath("td[@class='datetime']") {
                    date = dateVal.text!
                }
                NoticeData.noticeList.append(NoticeData(isNotice:isNotice, title:title, date:date))
            }
            print("count : \(NoticeData.noticeList.count)")
            doneNoticeFlag = true
            index = index + 1
            moreFetch = true
            tableView.reloadData()
        } catch let error {
            print("Error int pharsing: \(error)")
        }
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if moreFetch {
                moreFetch = false
                self.crawlingData()
            }else {
                print("doing fetching... wait...")
            }
        }
    }
    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//
//        return 0
//    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
<<<<<<< HEAD
        // #warning Incomplete implementation, return the number of rows gg
        return 0
=======
        return NoticeData.noticeList.count
>>>>>>> c6cda0c346f0ef13ba0567cef56249e3ca366ebf
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! NoticeTableViewCell
        let target = NoticeData.noticeList[indexPath.row]
        
        cell.noticeCell?.text = target.GetIsNotice()
        cell.titleCell?.text = target.GetTitle()
        cell.dateCell?.text = target.GetDate()
        return cell
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

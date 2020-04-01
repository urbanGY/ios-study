//
//  ContentViewController.swift
//  NoticeBoard
//
//  Created by 김현석 on 30/03/2020.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import Kanna

class ContentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var data: NoticeData?
    var itemList: [DownloadFile] = []
    
    @IBOutlet weak var detailContent: UITextView!
    @IBOutlet weak var downloadTableView: UITableView!
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        downloadTableView.register(ContentTableViewCell.self, forCellReuseIdentifier: "downloadCell")
        downloadTableView.delegate = self
        downloadTableView.dataSource = self
        view.addSubview(downloadTableView) // 이건 꼭 필요한건지 잘 모르겠다;
        self.crawlingData()
    }
    
    func crawlingData() -> Void {
        let requestUrl: String! = data?.GetUrl()
        let url = URL(string: requestUrl)
        AF.request(url!).response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                self.parsing(utf8Text)
                self.downloadTableView.reloadData()
            }
        }
    }
    
    func parsing(_ inputHtml: String) -> Void {
        do {
            print("call parsing")
            detailContent.text = " "
            let htmlText = try HTML(html: inputHtml, encoding: .utf8)
            let line = htmlText.xpath("//*[@id=\"writeContents\"]").first?.text
            detailContent.text = line
            
            if let div_1 = htmlText.at_xpath("//*[@id=\"body_content\"]/div[3]/div[1]"){
                print("in the div 1")
                for tr in div_1.xpath(".//table/tr[not(@*)]/td/table/tr") {
                    var fileName:String?
                    var fileImageName:String?
                    var fileUrl:String?
                    
                    if let fileNameVal = tr.at_xpath(".//span"){
                        fileName = fileNameVal.text!
                        print("file name : \(fileName!)")
                    }
                    if let fileUrlVal = tr.at_xpath(".//a") {
                        fileUrl = fileUrlVal["href"]
                        fileUrl = urlSlice(url: fileUrl)
                        print("file url : \(fileUrl!)")
                    }
                    if let fileImageNameVal = tr.at_xpath(".//a"){
                        fileImageName = fileImageNameVal.text!
                    }
                    
                    if let fileName = fileName, let fileImageName = fileImageName, let fileUrl = fileUrl {
                        self.itemList.append(DownloadFile(fileName: fileName, fileImageName: fileImageName, fileUrl: fileUrl))
                        print("item append!")
                    }
                }
            }
        }catch let error {
            print("Error int pharsing: \(error)")
        }
    }
    
    // https://sw.ssu.ac.kr/bbs/download.php?bo_table=sub6_1&wr_id=1066&no=0&page=1
    func urlSlice(url:String?) -> String {
        let findIdx:String.Index = url!.firstIndex(of: "/")!
        let tmp = String(url![findIdx...])
        let endIdx:String.Index = tmp.firstIndex(of: "'")!
        let result = String(tmp[..<endIdx])
        return "https://sw.ssu.ac.kr/bbs\(result)"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "downloadCell", for: indexPath) as! ContentTableViewCell
        let target = itemList[indexPath.row]
        cell.downloadFileName?.text = target.GetFileName()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("touch!, \(indexPath.row)")
        //터치했을 때 파일 다운로드 하게 만들기
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

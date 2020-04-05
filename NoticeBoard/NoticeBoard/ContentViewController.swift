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
                        fileName = fileSlice(fileName: fileName)
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
    
    func fileSlice(fileName:String?) -> String {
        let findIdx:String.Index = fileName!.firstIndex(of: ".")!
        let file = String(fileName![..<findIdx])
        let tmp = String(fileName![findIdx...])
        let endIdx: String.Index = tmp.index(tmp.startIndex, offsetBy: 4)
        let result = file + String(tmp[..<endIdx])
        return result
    }
    
    // https://sw.ssu.ac.kr/bbs/download.php?bo_table=sub6_1&wr_id=1066&no=0&page=1
    func urlSlice(url:String?) -> String {
        let findIdx:String.Index = url!.firstIndex(of: "/")!
        let tmp = String(url![findIdx...])
        let endIdx:String.Index = tmp.firstIndex(of: "'")!
        let result = String(tmp[..<endIdx])
        return "https://sw.ssu.ac.kr/bbs\(result)"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "downloadCell", for: indexPath) as! ContentTableViewCell
        let target = itemList[indexPath.row]
        cell.downloadFileName?.text = target.GetFileName()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fileName = itemList[indexPath.row].GetFileName()
        let url = itemList[indexPath.row].GetFileUrl()
        
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(fileName)

            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        AF.download(url, to: destination).response { response in
            debugPrint(response)
            if response.error == nil, let filePath = response.fileURL?.path {
                guard var realLocation = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
                let f_url = realLocation.appendingPathComponent(fileName)
                do {
//                    let encoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(0x0422))
//                    let f_content = try String(contentsOf: f_url, encoding: .utf8)
//                    var obj:[String] = [f_content]
                    
                    
                    var obj = [f_url]
                    let activityVC = UIActivityViewController(activityItems: obj, applicationActivities: nil)
//                    activityVC.excludedActivityTypes = [UIActivity.ActivityType.airDrop, UIActivity.ActivityType.addToReadingList]
                    self.present(activityVC, animated: true, completion: nil)
                    
                }catch let error {
                    print("error in Data... \(error)")
                }
                print("in success!! \(filePath)")
            }else {
                print("fail..")
            }
        }
        
        
//        print("\(realLocation.absoluteString)")
//        print("write?")
//        let fileManager = FileManager.default
//        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        print("\(documentsURL)")
//        let fileURL = documentsURL.appendingPathComponent("zedd의 파일")
//        print("\(fileURL)")
//        let myTextString = NSString(string: "HELLO WORLD")
//        try? myTextString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8.rawValue)
//        print("done")
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

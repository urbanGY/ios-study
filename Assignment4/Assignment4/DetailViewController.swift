//
//  DetailViewController.swift
//  Assignment4
//
//  Created by 김현석 on 2020/04/09.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var downloadView: UITableView!
    @IBOutlet weak var detailContent: UITextView!
    var url: String!
    var downloadList: [DownloadData] = []
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadView.dataSource = self
        downloadView.delegate = self
        self.requestData()
    }
    
    func requestData() -> Void {
        if let requestUrl = url {
            let url = URL(string: requestUrl)
            AF.request(url!).response { response in
                if let data = response.data, let htmlText = String(data: data, encoding: .utf8) {
                    self.parsing(htmlText)
                }
            }
        }
    }
    
    func parsing(_ htmlText: String) -> Void {
        do {
            let html = try HTML(html: htmlText, encoding: .utf8)
            //*[@id="contents"]/div/div/div/div/div/div/div[1]/div[1]/div[2]
            //*[@id=\"contents\"]/div/div/div/div/div/div/div[1]/div[1]/div[2]/ol[1]
            //*[@id=\"contents\"]/div/div/div/div/div/div/div[1]/div[1]/div[2]/p[1]
            //*[@id=\"contents\"]/div/div/div/div/div/div/div[1]/div[1]/div[2]/ul/li/a
            //*[@id="contents"]/div/div/div/div/div/div/div[1]/div[1]/div[2]/ul/li[1]/a/span
            if let div = html.at_xpath("//*[@id=\"contents\"]/div/div/div/div/div/div/div[1]/div[1]/div[2]") {
                var contentText: String = ""
                for elem in div.xpath(".//ol | p"){
                    contentText = contentText + "\(elem.text!)\n"
                }
                
                for download in div.xpath(".//ul/li[not(@*)]/a"){
                    let downloadLink = "https://scatch.ssu.ac.kr/\(download["href"]!)"
                    
                    let downloadTitle = download.xpath(".//span").first?.text
                    self.downloadList.append(DownloadData(title: downloadTitle!, link: downloadLink))
                }
                print("download count : \(self.downloadList.count)")
                detailContent.text = contentText
                self.downloadView.reloadData()
            }
        }catch let error {
            print("error occur in parsing func.. \(error)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.downloadList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "downloadCell", for: indexPath)
        let target = self.downloadList[indexPath.row]
        print("target: \(target.getTitle())")
        cell.textLabel?.text = target.getTitle()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fileName = self.downloadList[indexPath.row].getTitle()
        let link = self.downloadList[indexPath.row].getLink()
        print("link : \(link)")
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(fileName)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        AF.download(link, to: destination).response { response in
            if response.error == nil {
                guard var realLocation = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
                let f_url = realLocation.appendingPathComponent(fileName)
                var obj = [f_url]
                let activityVC = UIActivityViewController(activityItems: obj, applicationActivities: nil)
                self.present(activityVC, animated: true, completion: nil)
            }
        }
    }
}

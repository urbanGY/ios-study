//
//  MusicTableViewController.swift
//  Assignment3-2
//
//  Created by 김현석 on 2020/04/07.
//  Copyright © 2020 urbanGY. All rights reserved.
//

import UIKit
import Alamofire

class MusicTableViewController: UITableViewController, XMLParserDelegate {

    var musicList: [MusicData] = []

    var titleFlag: Bool = false
    var descriptionFlag: Bool = false
    var linkFlag: Bool = false

    var titleText: String?
    var descriptionText: String?
    var linkText: String?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func requestData() -> Void {
        let requestUrl = "http://www.bbc.co.uk/music/genres/classicpopandrock/reviews.rss"
        let url = URL(string: requestUrl)
        AF.request(url!).response { response in
            if let responseData = response.data, let _ = String(data: responseData, encoding: .utf8){
                let parser = XMLParser(data: responseData)
                parser.delegate = self
                let success = parser.parse()
                if success {
                    print("success parsing")
                    print("\(self.musicList.count)")
                    self.tableView.reloadData()
                }else {
                    print("fail parsing")
                }
            }else {
                print("fail request")
            }
        }
    }

    //title, description, link, media:thumbnail
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "title" {
            titleFlag = true
        }else if elementName == "description" {
            descriptionFlag = true
        }else if elementName == "link" {
            linkFlag = true
        }else if elementName == "media:thumbnail" {
            if let imgUrl = attributeDict["url"], let title = titleText, let description = descriptionText, let link = linkText {
                let obj = MusicData(title: title, description: description, imageUrl: imgUrl, linkUrl: link)
                self.musicList.append(obj)
                titleText = nil
                descriptionText = nil
                linkText = nil
            }else {
            }
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "title" {
            titleFlag = false
        }else if elementName == "description" {
            descriptionFlag = false
        }else if elementName == "link" {
            linkFlag = false
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if titleFlag {
            if titleText == nil {
                titleText = string
            }else {
                titleText = "\(titleText!) \(string)"
            }
        }
        if descriptionFlag {
            if descriptionText == nil {
                descriptionText = string
            }else {
                descriptionText = "\(descriptionText!) \(string)"
            }
        }
        if linkFlag {
            linkText = string
        }
    }

    func imgAsync(_ index: Int) -> UIImage {
        let obj = self.musicList[index]
        if let img = obj.getImg() {
            return img
        }else {
            let url = URL(string: obj.getImgUrl())
            let data = try! Data(contentsOf: url!)
            obj.setImg(UIImage(data: data)!)
            return obj.getImg()!
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath) as! MusicTableViewCell
        let target = musicList[indexPath.row]
        var title:String, description:String
        (title,description) = target.getData()
        
//        DispatchQueue.main.async {
//            cell.musicImage.image = self.imgAsync(indexPath.row)
//        }
        DispatchQueue.global().async {
            cell.musicImage.image = self.imgAsync(indexPath.row)
        }
        cell.musicTitle.text = title
        cell.musicDescription.text = description

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let linkUrl = self.musicList[indexPath.row].getLink()
        if let url = URL(string: linkUrl) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
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

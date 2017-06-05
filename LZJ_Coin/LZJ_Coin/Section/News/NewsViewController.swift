//
//  NewsViewController.swift
//  LZJ_Coin
//
//  Created by Heyz on 2017/5/25.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON
import Alamofire
import Kingfisher

class NewsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var bigLbl: UILabel!
    @IBOutlet weak var subLbl: UILabel!

    let newsURL = "https://toutiao.com/api/article/recent/?source=2&category=news_hot&as=A1D5D87595C3287"

    @IBOutlet weak var tableView: UITableView!

    var messages = Array<Any>()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.automaticallyAdjustsScrollViewInsets = false
        bigLbl.text = "News"
        subLbl.text = "some hot news"


        self.getNews()
      }

    func getNews() -> () {
        Alamofire.request(newsURL).responseJSON { (res) in
            if let result : Dictionary = res.value as? Dictionary<String,AnyObject>{
//                let data = JSON(result)["data"] as Array!
                for i in JSON(result)["data"]{
                    self.messages .append(i.1)
                    self.tableView .reloadData()
                }

            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }

    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = NewsTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier:"cell")

        let d = self.messages[indexPath.row] as! JSON
        cell.textLabel?.text = d["abstract"].stringValue
        cell.textLabel?.numberOfLines = 0

        let url = URL(string: d["media_avatar_url"].stringValue)
        cell.imageV?.kf.setImage(with:url )

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.setSelected(false, animated: false)

        let data = self.messages[indexPath.row] as! JSON
        let url = data["display_url"]
        let title = data["title"]

        let vc = UIViewController.init()
        vc.title = title.stringValue
        let webView = UIWebView.init(frame: vc.view.bounds)
        vc.view.addSubview(webView)
        webView.loadRequest(URLRequest.init(url: URL.init(string: url.stringValue)!))

        self.navigationController?.pushViewController(vc, animated: true)
    }

}

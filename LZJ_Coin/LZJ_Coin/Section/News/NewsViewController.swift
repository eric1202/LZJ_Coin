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

        let cell = UITableViewCell.init()

        let d = self.messages[indexPath.row] as! JSON
        cell.textLabel?.text = d["abstract"].stringValue
        cell.textLabel?.numberOfLines = 0

        cell.contentView.backgroundColor = UIColor.init(red:CGFloat((arc4random()%100))/100.0, green:CGFloat((arc4random()%100))/100.0, blue: CGFloat((arc4random()%100))/100.0, alpha: 0.9)

        let view = UIView()
        view.backgroundColor = UIColor.init(red: CGFloat(arc4random()), green:CGFloat(arc4random()), blue: CGFloat(arc4random()), alpha: 1)
        cell.contentView.addSubview(view)
        cell.textLabel?.snp.remakeConstraints({ (make) in
            make.left.equalTo(cell.contentView.snp.left).offset(15)
            make.width.lessThanOrEqualTo(cell.contentView.snp.width)
            make.bottom.equalTo(cell.contentView.snp.bottom).offset(-20)
            make.top.equalTo(cell.contentView.snp.top).offset(20)
        })
        view.snp.makeConstraints { (make) in
//            make.bottom.equalTo(cell.contentView.snp.bottom).offset(-20)
            make.top.equalTo(cell.contentView.snp.top).offset(20)
            make.right.equalTo(cell.contentView.snp.right).offset(-20)
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.left.equalTo(cell.textLabel!.snp.right).offset(20)
        }

        return cell
    }



}

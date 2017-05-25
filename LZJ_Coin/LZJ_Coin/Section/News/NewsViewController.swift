//
//  NewsViewController.swift
//  LZJ_Coin
//
//  Created by Heyz on 2017/5/25.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import UIKit
import SnapKit

class NewsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var bigLbl: UILabel!
    @IBOutlet weak var subLbl: UILabel!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.automaticallyAdjustsScrollViewInsets = false
        bigLbl.text = "News"
        subLbl.text = "some hot news"
      }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell.init()
        cell.textLabel?.text = "hi"
        cell.contentView.backgroundColor = UIColor.init(red: 0.3, green: 0.4, blue: 0.5, alpha: 1)

        let view = UIView()
        view.backgroundColor = UIColor.red
        cell.contentView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.bottom.equalTo(cell.contentView.snp.bottom).offset(-20)
            make.right.equalTo(cell.contentView.snp.right).offset(-20)
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.top.equalTo(cell.contentView.snp.top).offset(20)

        }

        return cell
    }



}

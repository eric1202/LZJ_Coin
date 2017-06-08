//
//  MusicTableViewController.swift
//  LZJ_Coin
//
//  Created by Heyz on 2017/6/8.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import UIKit

class MusicTableViewController: UITableViewController {

    var datas = [AnyObject]()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = String.init(format: "%ld - %ld", indexPath.section,indexPath.row)
        return cell!
    }

}

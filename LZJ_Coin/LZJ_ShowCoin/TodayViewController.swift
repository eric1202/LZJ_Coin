//
//  TodayViewController.swift
//  LZJ_ShowCoin
//
//  Created by Heyz on 2017/5/18.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import UIKit
import NotificationCenter
import SwiftyJSON
class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var showLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM-dd HH:mm:ss"
        showLbl.layer.masksToBounds = true
        showLbl.layer.cornerRadius = 5
        showLbl.backgroundColor = UIColor.white
        showLbl.text = "greetings! " + UIDevice.current.name + " ! " + dateformatter.string(from: date)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("showing ~")

        //http requset
        DispatchQueue.global().async {
            let url = URL(string:"https://www.okcoin.cn/api/v1/ticker.do?symbol=ltc_cny")
            //默认的会话配置
            let config = URLSessionConfiguration.default
            let request = URLRequest(url: url!)

            //还能设置会话超时时间，默认是1分钟，可以自己设定。
            config.timeoutIntervalForRequest = 5 // 设置为5秒

            let session = URLSession(configuration : config)
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if data != nil{
                    DispatchQueue.main.async {
                        let json = JSON(data!)
                        print(json)
                        self.showLbl?.text = "Buy：" + (json["ticker"]["buy"].stringValue) + " / Sell：" + (json["ticker"]["sell"].stringValue ) + " $\u{2003}"
                        
                    }
                }
            })

            task.resume()

            
        }



    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}

//
//  TodayViewController.swift
//  LZJ_ShowCoin
//
//  Created by Heyz on 2017/5/18.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var showLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MM-dd HH:mm:ss"
        showLbl.text = "greetings!     " + dateformatter.string(from: date)
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
            config.timeoutIntervalForRequest = 5 // 设置为10秒

            let session = URLSession(configuration : config)
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if data != nil{
                    DispatchQueue.main.async {

                        print(data)
                        self.showLbl?.text = "finished" + (data?.description)!
                        
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

//
//  ViewController.swift
//  LZJ_Coin
//
//  Created by Heyz on 2017/5/18.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import UIKit
import SwiftyJSON
import RxSwift
class ViewController: UIViewController {

    @IBOutlet weak var bitLbl: UILabel!
    @IBOutlet weak var liteLbl: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!

    private var chartView:CoinChartView? = nil

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 6, repeats: true) { (t) in
                self.loadData()
            }
        } else {
            // Fallback on earlier versions
        }
        let screenh = UIScreen.main.bounds.size.height
        let screenw = UIScreen.main.bounds.size.width
        self.chartView = CoinChartView(frame: CGRect(x: (screenw-300 )/2, y:screenh - 310, width: 300, height: 300), type: CoinChartView.ChartViewType.lite)
        self.view.addSubview(self.chartView!)

        LTCoin.getKline(type: "30min") { (arr, err) in
            if let coins = arr{
                self.chartView?.drawChart(points: coins)
            }
        }

        JuBiCoin.getTicker(type: .DOGE) { (coin, error) in
            if let c = coin{

                print("%@ coin : %@",JuBiCoin.CoinType.DOGE,c.description)
            }
        }
        
    }

    //MARK: - Event
    @IBAction func changeSegment(_ sender: UISegmentedControl) {

    }

    func loadData() {
        LTCoin .getCurrentPrice { (data, err) in
            if let error = err{
                print(error)
            }
            else{
                let lite = JSON(data!)
                self.liteLbl.text = lite["ticker"]["buy"].stringValue
                let low = lite["ticker"]["low"].stringValue
                let high = lite["ticker"]["high"].stringValue
                self.bitLbl.text = low+"  "+high
            }

        }
    }
    
    
}


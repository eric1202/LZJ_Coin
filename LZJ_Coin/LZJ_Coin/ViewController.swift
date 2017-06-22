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
    private var loadingView:UIActivityIndicatorView? = nil

    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configUI()
        self.loadLitCoinData()

    }

    //MARK: - UI
    func configUI() {
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 6, repeats: true) { (t) in
                self.changeSegment(self.segment)
            }
        } else {
            // Fallback on earlier versions
        }

        let screenh = UIScreen.main.bounds.size.height
        let screenw = UIScreen.main.bounds.size.width
        self.chartView = CoinChartView(frame: CGRect(x: (screenw-300 )/2, y:screenh - 310, width: 300, height: 300), type: CoinChartView.ChartViewType.lite)
        self.view.addSubview(self.chartView!)

        LTCoin.getKline(type: "1hour") { (arr, err) in
            if let coins = arr{
                self.chartView?.drawChart(points: coins)
            }
        }

        self.loadingView = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        self.loadingView!.center = self.view.center
        self.view.addSubview(self.loadingView!)
    }

    //MARK: - Event
    @IBAction func changeSegment(_ sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        NSLog("select segment index :%ld", index)
        switch index {
        case 0:
            self.loadLitCoinData()
            break

        default:
            self.loadJuBiData(index: index)
            break
        }
    }

    func loadLitCoinData() {
        self.loadingView!.startAnimating()
        LTCoin .getCurrentPrice { (data, err) in
            self.loadingView!.stopAnimating()
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

    func loadJuBiData(index:Int) -> () {
        self.loadingView!.startAnimating()
        let arr = [JuBiCoin.CoinType.IFC,JuBiCoin.CoinType.BTS,JuBiCoin.CoinType.XRP]
        JuBiCoin.getTicker(type:arr[index-1], completion: { (coin, err) in
            self.loadingView!.stopAnimating()
            if let c = coin{
                let low = c.lowPrice
                let high = c.highPrice
                self.bitLbl.text = String(low) + "   " + String(high)
                self.liteLbl.text = String(c.buyPrice)
            }
        })
    }


}


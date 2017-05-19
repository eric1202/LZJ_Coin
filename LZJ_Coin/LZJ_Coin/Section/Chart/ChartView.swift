//
//  ChartView.swift
//  LZJ_Coin
//
//  Created by Heyz on 2017/5/19.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import Foundation
import UIKit
import Charts

class CoinChartView: UIView {
    enum ChartViewType {
        case bit
        case lite
    }
    public var type : ChartViewType
    public var chart : LineChartView? = nil

    required init?(coder aDecoder: NSCoder) {
        self.type = .lite
            super.init(coder: aDecoder)
    }

    /// initialize function
    ///
    /// - Parameters:
    ///   - frame: frame parameter
    ///   - type: bit or lite
    init(frame:CGRect, type:ChartViewType){
        self.type = type
        super.init(frame: frame)
        self.chart = LineChartView(frame: self.bounds)

        self.addSubview(self.chart!)
        //add the real chart

    }

    func drawChart(points:[LTCoin]) {
        var dataEntries: [ChartDataEntry] = []
        for (idx,coin) in points.enumerated() {
            let entry = ChartDataEntry(x: Double(idx), y: coin.highPrice)
            dataEntries .append(entry)
        }

        let lineChartDataSet = LineChartDataSet(values: dataEntries, label: "折线图")
        lineChartDataSet.drawCirclesEnabled = false

        let lineChartData = LineChartData()
        lineChartData.addDataSet(lineChartDataSet)

        self.chart?.data = lineChartData


    }




}
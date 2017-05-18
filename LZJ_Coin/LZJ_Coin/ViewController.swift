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
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 6, repeats: true) { (t) in
                self.loadData()
            }
        } else {
            // Fallback on earlier versions
        }
        
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
                self.bitLbl.text = low + high
            }

        }
    }
    
    
}


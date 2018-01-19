//
//  JuBiCoin.swift
//  LZJ_Coin
//
//  Created by Heyz on 2017/5/23.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import UIKit
import Alamofire
class JuBiCoin: NSObject {
    enum CoinType : String{
        case IFC = "ifc"
        case EOS = "eos"
        case XRP = "xrp"
        case NEO = "neo"
    }

    var highPrice = 0.0
    var lowPrice = 0.0
    var buyPrice = 0.0
    var sellPrice = 0.0
    var lastPrice = 0.0
    var vol = 0.0


   class func getTicker(type:CoinType,completion:@escaping ((_ result:JuBiCoin?,_ error:NSError?)->())) -> () {
        let url = String.init(format: "https://www.okex.com/api/v1/ticker.do?symbol=%@_usdt", type.rawValue)
        Alamofire.request(url).responseJSON { (res) in
            if let err = res.error{
                completion(nil,err as NSError)
            }else{
                if let result : Dictionary = res.value as? Dictionary<String,AnyObject>{
                    let coin = JuBiCoin.init()
                    coin.highPrice = Double(result["ticker"]!["high"]! as! String)!
                    coin.lowPrice = Double(result["ticker"]!["low"]! as! String)!
                    coin.buyPrice = Double(result["ticker"]!["buy"]! as! String)!
                    coin.sellPrice = Double(result["ticker"]!["sell"]! as! String)!
                    coin.lastPrice = Double(result["ticker"]!["last"]! as! String)!
                    coin.vol = Double(result["ticker"]!["vol"]! as! String)!

                    completion(coin,nil)
                }

                else {
                    completion(nil,NSError.init(domain: "NoneData", code: 1001, userInfo: [NSLocalizedDescriptionKey : "NoneData"]))
                }

            }
        }
    }
}

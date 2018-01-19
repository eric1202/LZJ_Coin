//
//  LTCoin.swift
//  LZJ_Coin
//
//  Created by Heyz on 2017/5/18.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import HandyJSON


class LTCoin: HandyJSON {

    public var timeStamp = 0.0
    public var openPrice = 0.0
    public var highPrice = 0.0
    public var lowPrice = 0.0
    public var endPrice = 0.0
    public var tradeVolume = 0.0

    required init() {

    }

    class func getCurrentPrice(completion:@escaping(_ data:Any?,_ error:Error?)->()){

        Alamofire.request("https://www.okex.com/api/v1/ticker.do?symbol=ltc_usdt",method:.get).responseJSON{(res) in
            if let err = res.error{
                completion(nil,err)
            }
            else {

                completion(res.result.value,nil);
            }

        }

    }

    class func getKline(type:String,completion:@escaping(_ datas:[LTCoin]?,_ error:Error?)->Void) {
        let url = "https://www.okex.com/api/v1/kline.do?symbol=ltc_usdt&type="+type
        Alamofire.request(url).responseJSON { (res) in
            if let err = res.error{
                completion(nil,err)
            }
            else{
                var temps = [LTCoin]()
                let arrs = res.value as! NSArray
                // json to model
                for v in arrs{
                    let json = v as! [AnyObject]
                    let c = LTCoin.init()
                    c.timeStamp = Double(json[0] as! NSNumber)
                    c.openPrice = Double(json[1] as! String)!
                    c.highPrice = Double(json[2] as! String)!
                    c.lowPrice = Double(json[3] as! String)!
                    c.endPrice = Double(json[4] as! String)!
                    c.tradeVolume = Double(json[5] as! String)!

                    temps .append(c)
                }

                completion(temps,nil)

            }
        }
    }
}



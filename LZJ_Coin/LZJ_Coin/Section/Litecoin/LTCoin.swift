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

        Alamofire.request("https://www.okcoin.cn/api/v1/ticker.do?symbol=ltc_cny",method:.get).responseJSON{(res) in
            if let err = res.error{
                completion(nil,err)
            }
            else {

                completion(res.result.value,nil);
            }

        }

    }

    class func getKline(type:String,completion:@escaping(_ datas:[LTCoin]?,_ error:Error?)->Void) {
        let url = "https://www.okcoin.cn/api/v1/kline.do?symbol=ltc_cny&since=1491148800000&type="+type
        Alamofire.request(url).responseJSON { (res) in
            if let err = res.error{
                completion(nil,err)
            }
            else{
                var temps = [LTCoin]()
                let arrs = res.value as! NSArray
                // json to model
                for v in arrs{
                    let json = v as! NSArray
                    let c = LTCoin.init()
                    c.timeStamp = json[0] as! Double
                    c.openPrice = json[1] as! Double
                    c.highPrice = json[2] as! Double
                    c.lowPrice = json[3] as! Double
                    c.endPrice = json[4] as! Double
                    c.tradeVolume = json[5] as! Double

                    temps .append(c)
                }

                completion(temps,nil)

            }
        }
    }
}

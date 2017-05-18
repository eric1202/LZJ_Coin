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

class LTCoin: NSObject {
    public var price = 0
    public var amount = 0

    class func getCurrentPrice(completion:@escaping(_ data:Any?,_ error:Error?)->()){

        Alamofire.request("https://www.okcoin.cn/api/v1/ticker.do?symbol=ltc_cny",method:.get).responseJSON{(res) in
            if let err = res.error{
                completion(nil,err)
            }
            else {

                completion(res.result.value,nil);
            }

        }


//        Alamofire.request("https://www.okcoin.cn/api/v1/ticker.do?symbol=ltc_cny").validate().responseJSON { response in
//            switch response.result {
//            case .success:
//                completion(response,nil)
//            case .failure(let error):
//                completion(nil,error)
//            }
//        }
    }
}

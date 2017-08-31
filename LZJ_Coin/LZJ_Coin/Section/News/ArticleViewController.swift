//
//  ArticleViewController.swift
//  LZJ_Coin
//
//  Created by Heyz on 2017/7/13.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import UIKit
import Alamofire
import Spruce

class ArticleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        getArticle()
    }

    func getArticle() {
        Alamofire.request("https://interface.meiriyiwen.com/article/random?dev=1").responseJSON { (res) in
            guard let result = res.value  as? Dictionary<String,AnyObject> else{return}

            let textView = UITextView.init(frame: CGRect.init(x: 0, y: 64, width: self.view.frame.size.width, height: self.view.frame.size.height-64))
            textView.textColor = UIColor.white
            textView.font = UIFont.systemFont(ofSize: 16)
            textView.contentInset = UIEdgeInsetsMake(2, 2, 2, 2)
            textView.isDirectionalLockEnabled = true
            textView.backgroundColor = UIColor().hexStringToUIColor(hex: MAINCOLOR.first.rawValue)

            guard let data :Dictionary = result["data"] as! Dictionary<String,AnyObject> else {return}
            let t = data["content"] as? String
            try! textView.text = t?.convertHtmlSymbols()

            self.title = data["title"] as? String
            self.view.addSubview(textView)

            self.view.spruce.animate([StockAnimation.fadeIn], duration: 1, animationType: StandardAnimation.init(duration: 1), completion: { (b) in
                NSLog("loading spruce!")
            })

        }
    }
}


extension String {
    func convertHtmlSymbols() throws -> String? {
        guard let data = data(using: .utf8) else { return nil }

        return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil).string
    }
}

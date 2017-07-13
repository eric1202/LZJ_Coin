//
//  ArticleViewController.swift
//  LZJ_Coin
//
//  Created by Heyz on 2017/7/13.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import UIKit
import Alamofire

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
            textView.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)

            guard let data :Dictionary = result["data"] as! Dictionary<String,AnyObject> else {return}
            let t = data["content"] as? String
            try! textView.text = t?.convertHtmlSymbols()

            self.title = data["title"] as? String
            self.view.addSubview(textView)


        }
    }
}


extension String {
    func convertHtmlSymbols() throws -> String? {
        guard let data = data(using: .utf8) else { return nil }

        return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil).string
    }
}

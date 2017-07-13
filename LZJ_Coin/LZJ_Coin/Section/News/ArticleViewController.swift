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

            let textView = UITextView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
            textView.textColor = UIColor.white
            textView.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)

            guard let data :Dictionary = result["data"] as! Dictionary<String,AnyObject> else {return}
            textView.text = data["content"] as? String

            self.title = data["title"] as? String
            self.view.addSubview(textView)


        }
    }
}

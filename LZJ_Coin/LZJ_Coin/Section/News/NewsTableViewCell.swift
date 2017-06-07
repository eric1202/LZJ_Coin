//
//  NewsTableViewCell.swift
//  LZJ_Coin
//
//  Created by Heyz on 2017/6/5.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import UIKit
import SnapKit
class NewsTableViewCell: UITableViewCell {

    public var imageV : UIImageView?

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.imageV = UIImageView.init()
        self.imageV?.contentMode = .scaleAspectFit

        self.contentView.backgroundColor = UIColor.init(red:CGFloat((arc4random()%100))/100.0, green:CGFloat((arc4random()%100))/100.0, blue: CGFloat((arc4random()%100))/100.0, alpha: 0.3)

        self.contentView.addSubview(self.imageV!)

        weak var ws = self as NewsTableViewCell

        if let cell = ws {
            self.textLabel?.snp.remakeConstraints({ (make) in
                make.left.equalTo(cell.contentView.snp.left).offset(15)
                make.width.lessThanOrEqualTo(cell.contentView.snp.width)
                make.bottom.equalTo(cell.contentView.snp.bottom).offset(-20)
                make.top.equalTo(cell.contentView.snp.top).offset(20)
            })
            self.imageV!.snp.makeConstraints { (make) in
                make.top.equalTo(cell.contentView.snp.top).offset(20)
                make.right.equalTo(cell.contentView.snp.right).offset(-20)
                make.size.equalTo(CGSize(width: 100, height: 100))
                make.left.equalTo(cell.textLabel!.snp.right).offset(20)
                make.bottom.lessThanOrEqualTo(cell.contentView.snp.bottom).offset(-20)
            }
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

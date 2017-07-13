//
//  LoadingViewController.swift
//  LZJ_Coin
//
//  Created by Heyz on 2017/6/28.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LoadingViewController: UIViewController , NVActivityIndicatorViewable{

    override func viewDidLoad() {
        self.view.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        self.title = "Loading View"
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.loadTest()
    }


    func loadTest() {
        let cols = 4
        let rows = 8
        let cellWidth = Int(self.view.frame.width / CGFloat(cols))
        let cellHeight = Int((self.view.frame.height - 64) / CGFloat(rows))

        (NVActivityIndicatorType.ballPulse.rawValue ... NVActivityIndicatorType.audioEqualizer.rawValue).forEach {
            let x = ($0 - 1) % cols * cellWidth
            let y = ($0 - 1) / cols * cellHeight
            let frame = CGRect(x: x, y: y + 64, width: cellWidth, height: cellHeight)
            let activityIndicatorView = NVActivityIndicatorView(frame: frame,
                                                                type: NVActivityIndicatorType(rawValue: $0)!)
            let animationTypeLabel = UILabel(frame: frame)

            animationTypeLabel.text = String($0)
            animationTypeLabel.sizeToFit()
            animationTypeLabel.textColor = UIColor.white
            animationTypeLabel.frame.origin.x += 5
            animationTypeLabel.frame.origin.y += CGFloat(cellHeight) - animationTypeLabel.frame.size.height

            activityIndicatorView.padding = 20
            if $0 == NVActivityIndicatorType.orbit.rawValue {
                activityIndicatorView.padding = 0
            }
            self.view.addSubview(activityIndicatorView)
            self.view.addSubview(animationTypeLabel)
            activityIndicatorView.startAnimating()

            let button: UIButton = UIButton(frame: frame)
            button.tag = $0
            button.addTarget(self,
                             action: #selector(buttonTapped(_:)),
                             for: UIControlEvents.touchUpInside)
            self.view.addSubview(button)
        }
    }

    func buttonTapped(_ sender: UIButton) {
        let size = CGSize(width: 30, height: 30)

        startAnimating(size, message: "Loading...", type: NVActivityIndicatorType(rawValue: sender.tag)!)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
            NVActivityIndicatorPresenter.sharedInstance.setMessage("Authenticating...")
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            self.stopAnimating()
        }
    }


}

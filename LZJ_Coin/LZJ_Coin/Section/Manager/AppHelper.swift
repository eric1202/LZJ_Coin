//
//  AppHelper.swift
//  LZJ_Coin
//
//  Created by Heyz on 2017/6/9.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import UIKit
import AVFoundation

class AppHelper: NSObject {

    var player:AVQueuePlayer?

    var musics = [String]()

    static let sharedInstance: AppHelper = {
        let instance = AppHelper()
        instance.player = AVQueuePlayer()
        // setup code
        return instance
    }()

    func readyToPlay() {
        guard let player = self.player else {
            print("player is nil")
            return
        }
        if (player.items().count <= 1){
            //add items
            let items = ["Hotel California","ncssn"]

            for i in items {
                let url = Bundle.main.path(forResource: i, ofType: "mp3")
                player.insert(AVPlayerItem.init(url: URL.init(string: url ?? "")!), after: player.items().last)
            }

        }
        player.play()
    }

    func playMusic() -> () {
        player?.play()
    }
}

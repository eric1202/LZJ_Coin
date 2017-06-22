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
//        instance.player?.rate = 2
        // setup code
        return instance
    }()


    func readyToPlay() {
        guard let player = self.player else {
            print("player is nil")
            return
        }
        if (player.items().count == 1){
            //add items
            let items = ["Hotel California.mp3","好兄弟.mp3","你曾是少年.mp3"]

            for i in items {
                let path = Bundle.main.url(forResource: i, withExtension: nil)
                player.insert(AVPlayerItem.init(url: path!), after: player.items().last)
            }

        }
        player.play()
//        player.rate = 1.5
    }

    func playMusic()  {
        player?.play()
    }
}

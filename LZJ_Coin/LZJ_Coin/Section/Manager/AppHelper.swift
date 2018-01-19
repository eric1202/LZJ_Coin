//
//  AppHelper.swift
//  LZJ_Coin
//
//  Created by Heyz on 2017/6/9.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift

class AppHelper: NSObject {

    var player:AVQueuePlayer?

    var musics = [String]()

    var realmManager = try? Realm.init(configuration: Realm.Configuration.defaultConfiguration) 

    static let sharedInstance: AppHelper = {
        let instance = AppHelper()
        instance.player = AVQueuePlayer()
//        instance.player?.rate = 2
        // setup code
        return instance
    }()

    func test() -> () {


//        log.info("did test function")
//        let liter = LTCoin()
//        liter.endPrice = 113
//        liter.highPrice = 200
//        liter.lowPrice = 23
//        liter.tradeVolume = 1100



    }

    func readyToPlay() {
        guard let player = self.player else {
            print("player is nil")
            return
        }
        if (player.items().count == 1){
            //add items
            let path = Bundle.main.resourcePath //(forResourcesOfType: "mp3", inDirectory: "Resource") as [String]
            let fm = FileManager.default
            let s = fm.subpaths(atPath: path ?? "")
            let results = s?.filter({ (ss) -> Bool in
                if ss.contains(".mp3"){
                    return true
                }
                return false
            })
            let items = results!

            for i in items.shuffled() {
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

extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }

        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}


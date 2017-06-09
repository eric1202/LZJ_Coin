//
//  MusicTableViewController.swift
//  LZJ_Coin
//
//  Created by Heyz on 2017/6/8.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import UIKit
import AVFoundation
class MusicTableViewController: UITableViewController,AVAudioPlayerDelegate {

    var datas = [String]()
    var player = AppHelper.sharedInstance.player

    override func viewDidLoad() {
        super.viewDidLoad()

        //load local music

        //local path

        let path = Bundle.main.resourcePath //(forResourcesOfType: "mp3", inDirectory: "Resource") as [String]

        let fm = FileManager.default

        let s = fm.subpaths(atPath: path ?? "")
        //        NSLog("path : %@", s ?? "no")

        let results = s?.filter({ (ss) -> Bool in
            if ss.contains(".mp3"){
                return true
            }
            return false
        })

        NSLog("\n finally : %@",results ?? "")
        datas = results!

        tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")

        cell?.textLabel?.text = datas[indexPath.row]
        return cell!
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let url = datas[indexPath.row]

        let path = Bundle.main.url(forResource: url, withExtension: nil)

        if let player1 = AppHelper.sharedInstance.player {

            player1.pause()


            if let firstItem = player1.items().first{
                player1.insert(AVPlayerItem.init(url: path!), after:firstItem)
                player1.remove(firstItem)
            }else{
                player1.insert(AVPlayerItem.init(url: path!), after: player1.items().first)
            }

            player1.play()
        }else{
            print("no player")
        }
//        do {

//            player = try AVAudioPlayer(contentsOf: path!)
//            guard let player = player else { return }
//
//            player.delegate = self
//            player.prepareToPlay()
//            player.play()
//        } catch let error as NSError {
//            print(error.description)
//        }

    }

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag{
            print("*******audioPlayerDidFinishPlaying****")
            
        }
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if let e = error{
            print(e,"************")
        }
    }
    
}

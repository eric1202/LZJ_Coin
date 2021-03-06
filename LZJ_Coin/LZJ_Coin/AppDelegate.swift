//
//  AppDelegate.swift
//  LZJ_Coin
//
//  Created by Heyz on 2017/5/18.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import UIKit
import Bugly
import AVFoundation
import LeanCloud
import Alamofire
import XCGLogger

enum MAINCOLOR :String{
    case first = "004a7c"
    case second = "005691"
    case third = "E8F1F5"
    case fourth = "FAFAFA"

}

let log = XCGLogger.default

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var timer:Timer?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        Bugly.start(withAppId: "2c3f462d93")


//        log.setup(level: .debug, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: "path/to/file", fileLevel: .debug)
//
//        log.verbose("A verbose message, usually useful when working on a specific problem")
//        log.debug("A debug message")
//        log.info("An info message, probably useful to power users looking in console.app")
//        log.warning("A warning message, may indicate a possible error")
//        log.error("An error occurred, but it's recoverable, just info about what happened")
//        log.severe("A severe error occurred, we are likely about to crash now")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: .mixWithOthers)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")


                if #available(iOS 10.0, *) {
                    timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { (t) in

                        self.checkAndPlay()
                    })
                } else {
                    // Fallback on earlier versions
                    timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(checkAndPlay), userInfo: nil, repeats: true)
                }
            } catch {
                print(error)
                Bugly.reportError(error)
            }
        } catch {
            Bugly.reportError(error)
            print(error)
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        Bugly.reportException(withCategory: 1001, name: "applicationWillTerminate", reason: "maybe crash when open directly", callStack: [], extraInfo: [:], terminateApp: true)
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func checkAndPlay() {
        //timer check the play list
        if(AppHelper.sharedInstance.player?.items().count == 0){
            timer?.invalidate()
            return
        }
        AppHelper.sharedInstance.readyToPlay()

    }
}

extension UIColor {
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

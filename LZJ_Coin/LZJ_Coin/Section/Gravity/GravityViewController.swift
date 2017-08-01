//
//  GravityViewController.swift
//  LZJ_Coin
//
//  Created by Heyz on 2017/7/19.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import UIKit
import CoreMotion
class GravityViewController: UIViewController {

    var animator: UIDynamicAnimator!
    var motionMgr : CMMotionManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator.init(referenceView: self.view)
        motionMgr = CMMotionManager.init()

        var vs = [UIView]()

        for i in 0..<10{
            let random = arc4random()%30
            let v = UIImageView.init(frame: CGRect.init(x: 10 * i, y:(Int(10+15*random)), width: 10+10*i, height: 10+10*i))
            v.image = UIImage.init(named: "032-star")

//            let r = arc4random()%255
//            let g = arc4random()%255
//            let b = arc4random()%255
//            v.backgroundColor = UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)

            self.view .addSubview(v)
            vs .append(v)
        }

        let itemBehavior = UIDynamicItemBehavior.init(items:vs)
        animator.addBehavior(itemBehavior)

        let gravityBehavior = UIGravityBehavior.init(items: vs)
        gravityBehavior.magnitude = 2

        animator.addBehavior(gravityBehavior)

        let collisionBehavior = UICollisionBehavior.init(items: vs)
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true;


        animator.addBehavior(collisionBehavior)

        motionMgr .startDeviceMotionUpdates(to: OperationQueue.main) { (cm, error) in
            NSLog("device update : %@", cm?.attitude.description ?? "nothing")

            let grav : CMAcceleration = cm!.gravity;

            let x = CGFloat(grav.x)
            let y = CGFloat(grav.y)
            var p = CGPoint.init(x: x, y: y)

            // Have to correct for orientation.
            let orientation = UIApplication.shared.statusBarOrientation;

            if orientation == UIInterfaceOrientation.landscapeLeft {
                let t = p.x
                p.x = 0 - p.y
                p.y = t
            } else if orientation == UIInterfaceOrientation.landscapeRight {
                let t = p.x
                p.x = p.y
                p.y = 0 - t
            } else if orientation == UIInterfaceOrientation.portraitUpsideDown {
                p.x *= -1
                p.y *= -1
            }
            
            let v = CGVector(dx:p.x, dy:0 - p.y);
            gravityBehavior.gravityDirection = v;
        }
    }
    
    
}

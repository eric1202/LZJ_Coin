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
        self.title = "重力沙丘"
        animator = UIDynamicAnimator.init(referenceView: self.view)
        motionMgr = CMMotionManager.init()

        var vs = [UIView]()

        for _ in 0..<200{
            let random :Int = Int(arc4random()%14) + 1
            let v = UIView.init(frame: CGRect.init(x: 10 * random, y:(10+15*random), width: random, height: random))
            v.layer.masksToBounds = true
            v.layer.cornerRadius = CGFloat(random)/2.0
            let r = arc4random()%155
            let g = arc4random()%155
            let b = arc4random()%155
            v.backgroundColor = UIColor.init(red: CGFloat(r+8)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b+99)/255.0, alpha: 1)
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

        //框
        let leftV = UIView.init(frame: CGRect.init(x: 40, y: 300, width: 2, height: 100))
        leftV.backgroundColor = UIColor.blue
        self.view.addSubview(leftV)


        let middleV = UIView.init(frame: CGRect.init(x: 40, y: 400, width: 100, height: 2))
        middleV.backgroundColor = UIColor.orange
        self.view.addSubview(middleV)


        let rightV = UIView.init(frame: CGRect.init(x: 140, y: 300, width: 2, height: 100))
        rightV.backgroundColor = UIColor.cyan
        self.view.addSubview(rightV)

        collisionBehavior.addBoundary(withIdentifier: "right" as NSCopying, for: UIBezierPath.init(rect: rightV.frame))
        collisionBehavior.addBoundary(withIdentifier: "middle" as NSCopying, for: UIBezierPath.init(rect: middleV.frame))
        collisionBehavior.addBoundary(withIdentifier: "left" as NSCopying, for: UIBezierPath.init(rect: leftV.frame))

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

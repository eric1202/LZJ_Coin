//
//  FristViewController.swift
//  LZJ_Coin
//
//  Created by Heyz on 2017/9/4.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class FristViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //        NSLog("FristViewController did load")
        //        AppHelper.sharedInstance.test()
        let observable = Observable<Int>.range(start: 1, count: 10)
        observable.subscribe(onNext: { i in
            let n = Double(i)
            let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) /
                2.23606).rounded())

            print("fibonacci",fibonacci)
        }, onError: { (e) in
            print("e",e)

        }, onCompleted: {
            print("onCompleted")

        }, onDisposed: {
            print("onDisposed")

        })

        let subject = PublishSubject<String>()


        let subscriptionOne = subject.subscribe(onNext: { (string) in
            print(string)

        }, onError: { (e) in

        }, onCompleted: {

        }, onDisposed: {

        })

        let subscriptionTwo = subject.subscribe { event in
                print("2)", event.element ?? event)
        }
        subject.onNext("Is anyone listening?")

        subject.onNext("Is anyone looking?")
        subject.on(Event<String>.next("sdasdasdasdasd"))

        print("***********************")

        let subjectR = ReplaySubject<String>.create(bufferSize: 2)
        let disposeBag = DisposeBag()
        subjectR.onNext("1")
        subjectR.onNext("2")
        subjectR.onNext("3")
        subjectR.subscribe{
            print("1)",$0)
        }.addDisposableTo(disposeBag)
        subjectR
            .subscribe {
                print("2)",$0)

            }
            .addDisposableTo(disposeBag)
        subjectR.onNext("4")
        subjectR
            .subscribe {
                print("3)",$0)
            }
            .addDisposableTo(disposeBag)

        print("***********************")
        var variable = Variable<String>("Initial value")
        variable.value = "next value"
        variable.asObservable().subscribe(){
            print("v1",$0)
        }.addDisposableTo(disposeBag)

        variable.asObservable()
            .subscribe {
                print("2)", $0)
            }
            .addDisposableTo(disposeBag)
        variable.value = "2"

        print("***********************")

        let dictV = Variable<[String:Any]>(["name":"lzj","age":22])
        dictV.asObservable().subscribe(){
            print("now user info ",$0.element)
        }

        images.asObservable().subscribe { array in
            print("as value",array.element?.count)
        }

//        if #available(iOS 10.0, *) {
//            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (t) in
//                var d = dictV.value
//
//                let age = d["age"] as! Int
//                d["age"] = 1 + age
//
//                dictV.value = d
//
//                self.addImage(name: "12")
//            }
//        } else {
//            // Fallback on earlier versions
//        }


        self.label = UILabel.init(frame: CGRect(x: 10, y: self.textField.frame.maxY+2, width: 310, height: 300))
        self.label.numberOfLines = 0
        self.view.addSubview(self.label)


        self.textField = UITextField.init();
        self.textField.frame = CGRect.init(x: 10, y: 200, width: 200, height: 30)
        self.textField.center = CGPoint.init(x: self.view.center.x, y: self.view.center.y-100)
        self.view.addSubview(self.textField)
        self.textField.backgroundColor = .white

        self.textField.rx.text.subscribe { (text) in
            print(" --- text \(text)");
            self.label.text = text.element!

        }
    }

    private let bag = DisposeBag()
    private let images = Variable<[String]>([])
    private var textField = UITextField()
    private var label = UILabel()

    func addImage(name:String) ->Void{
        var temps = images.value
        temps.append(name)
        images.value = temps
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}

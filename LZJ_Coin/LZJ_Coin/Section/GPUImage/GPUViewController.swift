//
//  GPUViewController.swift
//  LZJ_Coin
//
//  Created by Heyz on 2017/8/10.
//  Copyright © 2017年 LZJ. All rights reserved.
//

import UIKit
import GPUImage
import AVFoundation



class GPUViewController: UIViewController {

    var camera : Camera!

    var basicOperation:BasicOperation!

    var renderView : RenderView!

    let btn = UIButton.init()

    lazy var imageView : UIImageView = {
        let imageView = UIImageView.init(frame: self.view.bounds)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.btn.frame = CGRect.init(x: 300, y: 80, width: 40, height: 30)
        self.btn.backgroundColor = UIColor.black
        self.btn.addTarget(self, action: #selector(CameraFiltering), for: UIControlEvents.touchUpInside)
        self.view .addSubview(self.btn)

        // Do any additional setup after loading the view.
        view.addSubview(imageView)
        imageView.image = UIImage.init(named: "food1.jpg")


        let delay = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: delay) {

            // Do something
            self.render1()
        }



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func render1(){

        // 创建一个BrightnessAdjustment颜色处理滤镜
        let brightnessAdjustment = BrightnessAdjustment()
        brightnessAdjustment.brightness = 0.3

        // 创建一个ExposureAdjustment颜色处理滤镜
        let exposureAdjustment = ExposureAdjustment()
        exposureAdjustment.exposure = 0.5

        let posterize = EmbossFilter()
        posterize.intensity = 2

        let beautifyShader = try? String.init(contentsOfFile: Bundle.main.path(forResource: "beauty", ofType: "txt")!)
        let beautifyAjustment = BasicOperation.init(fragmentShader: beautifyShader! , numberOfInputs: 3)

        // 2.使用管道处理
        // 创建图片输入
        let pictureInput = PictureInput(image: imageView.image!)
        // 创建图片输出
        let pictureOutput = PictureOutput()
        // 给闭包赋值
        pictureOutput.imageAvailableCallback = { image in
            // 这里的image是处理完的数据，UIImage类型
            NSLog("pictureOutput.imageAvailableCallback call")

            DispatchQueue.main.async {

                let iv = UIImageView.init(frame: CGRect.init(x: 10, y: 10, width: 200, height: 200))
                iv .image = image
                iv.isUserInteractionEnabled = true
                iv.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.tapImage(tap:))))
                self.view .addSubview(iv)

                UIView.animate(withDuration: 2, animations: {
                    iv.center = self.view.center
                })

                NSLog("DispatchQueue.main.async call")
            }
        }
        // 绑定处理链
//        pictureInput --> brightnessAdjustment --> exposureAdjustment --> pictureOutput
        pictureInput --> posterize --> pictureOutput
        // 开始处理 synchronously: true 同步执行 false 异步执行，处理完毕后会调用imageAvailableCallback这个闭包
        pictureInput.processImage(synchronously: true)
    }

    func tapImage(tap:UITapGestureRecognizer) -> () {
        let v = UIImageView.init(image: (tap.view as!UIImageView ).image)
        v.frame = UIApplication.shared.keyWindow!.bounds
        v.contentMode = .scaleAspectFit
        v.isUserInteractionEnabled = true
        v.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(disImage(tap:))))
        v.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(v)
        UIView.animate(withDuration: 1) {
            v.alpha = 1
        }
    }

    func disImage(tap:UITapGestureRecognizer) -> () {
        tap.view!.removeFromSuperview()
    }

    // MARK: - 实时视频滤镜
    func CameraFiltering() {

        // Camera的构造函数是可抛出错误的
        do {
            // 创建一个Camera的实例，Camera遵循ImageSource协议，用来从相机捕获数据

            /// Camera的指定构造器
            ///
            /// - Parameters:
            ///   - sessionPreset: 捕获视频的分辨率
            ///   - cameraDevice: 相机设备，默认为nil
            ///   - location: 前置相机还是后置相机，默认为.backFacing
            ///   - captureAsYUV: 是否采集为YUV颜色编码，默认为true
            /// - Throws: AVCaptureDeviceInput构造错误
            camera = try Camera(sessionPreset: AVCaptureSessionPreset1280x720,
                                cameraDevice: nil,
                                location: .backFacing,
                                captureAsYUV: true)

            // Camera的指定构造器是有默认参数的，可以只传入sessionPreset参数
            // camera = try Camera(sessionPreset: AVCaptureSessionPreset1280x720)

        } catch {

            print(error)
            return
        }

        // 创建一个Luminance颜色处理滤镜
        basicOperation = Luminance()

        // 创建一个RenderView的实例并添加到view上，用来显示最终处理出的内容
        renderView = RenderView(frame: view.bounds)
        view.addSubview(renderView)

        let posterize = EmbossFilter()
        posterize.intensity = 2

        basicOperation = posterize

        // 绑定处理链
        camera --> basicOperation --> renderView

        // 开始捕捉数据
        camera.startCapture()

        // 结束捕捉数据
        // camera.stopCapture()
    }

    deinit{
        NSLog("gpu view controller deinit")

    }

}

//
//  AVVedioViewController.swift
//  ChangingToSwift02
//
//  Created by Jason on 16/6/7.
//  Copyright © 2016年 Jason. All rights reserved.
//

import UIKit
import AVFoundation

class AVVedioViewController: UIViewController {
    
    @IBOutlet weak var vedioBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    var session : AVCaptureSession!
    var captureInput : AVCaptureDeviceInput!
    var imageOutput : AVCaptureStillImageOutput!
    var vedioLayer : AVCaptureVideoPreviewLayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCapture()
        self.cameraBtn.hidden = true
        self.vedioBtn.hidden = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:初始化摄像头
    func initCapture() {
        //1. 创建媒体管理会话
        session = AVCaptureSession.init()
        //判断分辨率是否支持1280*720，支持就设置为1280*720
        if session.canSetSessionPreset(AVCaptureSessionPreset1280x720) {
            session.sessionPreset = AVCaptureSessionPreset1280x720
        }
        //2. 获取后置摄像头设备对象
        var captureError : NSError?
        var device :AVCaptureDevice!
        let cameras = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        for camera in cameras {
            if camera.position == AVCaptureDevicePosition.Back {//取得后置摄像头
                device = camera as! AVCaptureDevice
            }
        }
        if device == nil {
            print("取得后置摄像头错误")
            return
        }
        //3. 创建输入数据对象
        do {
            captureInput = try AVCaptureDeviceInput.init(device: device)
        } catch let error as NSError {
            captureError = error
            captureInput = nil  // Nil cannot be assigned to type AVCaptureDeviceInput
            if captureError != nil { // new if
                print("error: \(captureError?.localizedDescription)")
            }
        }
        //4. 创建输出数据对象
        imageOutput = AVCaptureStillImageOutput.init()
        let setting = [ AVVideoCodecKey : AVVideoCodecJPEG ]
        imageOutput.outputSettings = setting
        //5. 添加输入数据对象和输出对象到会话中
        if session.canAddInput(captureInput) {
            session.addInput(captureInput)
        }
        if session.canAddOutput(imageOutput) {
            session.addOutput(imageOutput)
        }
        //6. 创建视频预览图层
        vedioLayer = AVCaptureVideoPreviewLayer.init(session: session)
        self.view.layer.masksToBounds = true
        vedioLayer.frame = self.view.bounds
        vedioLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        //插入图层在拍照按钮的下方
        self.view.layer .insertSublayer(vedioLayer, below: self.cameraBtn.layer)
        
    }
    
    @IBAction func cameraBtnClick(sender: UIButton) {
        //根据设备输出获得连接
        let connection = (imageOutput?.connectionWithMediaType(AVMediaTypeVideo))! as AVCaptureConnection
        //通过连接获得设备输出的数据
         print("about to request a capture from: \(imageOutput)")
            imageOutput.captureStillImageAsynchronouslyFromConnection(connection, completionHandler: { (imageSampleBuffer : CMSampleBuffer!, error:NSError!)-> Void in
                print("哈哈哈哈")
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageSampleBuffer)
                let image = UIImage.init(data: imageData)
                UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                self.vedioLayer.hidden = true
                self.cameraBtn.hidden = true
                self.vedioBtn.hidden = false
                self.session.stopRunning()

            })
    }
    
    @IBAction func vedioBtnClick(sender: UIButton) {
        self.vedioLayer.hidden = false;
        self.cameraBtn.hidden = false;
        self.vedioBtn.hidden = true;
        session.startRunning()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

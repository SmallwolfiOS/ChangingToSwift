//
//  CameraViewController.swift
//  ChangingToSwift02
//
//  Created by Jason on 16/6/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

import UIKit
import MobileCoreServices

class CameraViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var pickerVC:UIImagePickerController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        ininPickerViewController()
        
    }
    //MARK:点击按钮的事件初始化
    @IBAction func cameraAction(sender: UIButton) {
        pickerVC.mediaTypes = [kUTTypeImage as String]//设定拍照的媒体类型
        pickerVC.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Photo //设置摄像头捕捉模式为捕捉图片
        presentViewController(pickerVC, animated: true, completion: nil)
    }
    @IBAction func vedioBtnAction(sender: UIButton){
        pickerVC.mediaTypes = [kUTTypeMovie as String]//设定录像的媒体类型
        pickerVC.cameraCaptureMode = UIImagePickerControllerCameraCaptureMode.Video //设置摄像头捕捉模式为捕捉图片
        pickerVC.videoQuality = UIImagePickerControllerQualityType.TypeHigh //设置视频质量为高清
        presentViewController(pickerVC, animated: true, completion: nil)
    }
    //MARK:初始化拾取控制器
    func ininPickerViewController() {
        pickerVC = UIImagePickerController.init() //继承自UINavigationController
        pickerVC.sourceType = UIImagePickerControllerSourceType.Camera //设置拾取源为摄像头
        pickerVC.cameraDevice = UIImagePickerControllerCameraDevice.Rear //设置摄像头为后置
        pickerVC.editing = true;//设置运行编辑，即可以点击一些拾取控制器的控件
        pickerVC.delegate = self//设置代理、
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:/* 拍照或录像成功，都会调用 */
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let mediaType = info[UIImagePickerControllerMediaType] as!String//从info取出此时摄像头的媒体类型
        if mediaType == kUTTypeImage as String{//如果是拍照
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            //保存图像到相簿
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(CameraViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }else if mediaType == kUTTypeMovie as String {
            let url = info[UIImagePickerControllerMediaURL] as! NSURL
            let path = url.path!
            //判断能不能保存到相簿
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path) {
                //保存到相簿
                UISaveVideoAtPathToSavedPhotosAlbum(path, self, #selector(CameraViewController.vedio(_:didFinishSavingWithError:contextInfo:)), nil)
            }else{
                print("无法保存录像到相册")
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>){
        if (error as NSError?) != nil {
            print(error)
        }else{
            let ALertVC = UIAlertController.init(title: "保存成功", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            
            ALertVC.addAction(UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default, handler:{
                action in
                print("保存成功了")
                self.imageView.image = image
            }))
            presentViewController(ALertVC, animated: true, completion: nil)
        }
    }
    func vedio(videoPath: String, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>){
        if (error as NSError?) != nil {
            print(error)
        }else{
            let ALertVC = UIAlertController.init(title: "保存录像成功", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            
            ALertVC.addAction(UIAlertAction.init(title: "确定", style: UIAlertActionStyle.Default, handler:{
                action in
                print("保存录像成功了")
//                self.imageView.image = image
            }))
            presentViewController(ALertVC, animated: true, completion: nil)
        }
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

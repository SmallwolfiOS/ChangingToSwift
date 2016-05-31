//
//  HP_Util.swift
//  ChangingToSwift01
//
//  Created by Jason on 16/5/31.
//  Copyright © 2016年 MHP. All rights reserved.
//

import UIKit

class HP_Util: NSObject {
    //MARK:打电话
    /**
     拨打电话 建议的方式 ，会弹出提示窗
     
     - parameter number: 电话号码
     - parameter view:   当前视图
     */
    class func callNumberEndBackUpSuggest(number:String,view:UIView) {
        let webView = UIWebView.init(frame: CGRectZero)
        view.addSubview(webView)
        webView.loadRequest(NSURLRequest.init(URL: NSURL.init(string: "tel://" + number )!))
    }
    /**
     拨打电话，默认方式，不会出现提示，直接播放
     
     - parameter number: 电话号码
     */
    class func callNumber(number:String) {
        UIApplication.sharedApplication().openURL(NSURL.init(string: "tel://" + number)!)
    }
    /**
     拨打电话，会弹出提示窗，但是有被拒绝的危险
     
     - parameter number: 电话号码
     */
    class func callNumberEndBackUp(number:String) {
        UIApplication.sharedApplication().openURL(NSURL.init(string: "telprompt://" + number)!)
    }
    //MARK:发邮件
    /**
     发邮件
     
     - parameter emailaddress: 邮件地址
     */
    class func emailTo(emailaddress:String) {
        UIApplication.sharedApplication().openURL(NSURL.init(string: "mailto://" + emailaddress)!)
    }
    /**
     利用safari打开网址
     
     - parameter url: 网址
     */
    class func openInSafariUrl(url:String) {
        UIApplication.sharedApplication().openURL(NSURL.init(string: url)!)
    }
    /**
     向一个号码发送短信
     
     - parameter number: 电话号码
     */
    class func messageTo(number:String) {
        UIApplication.sharedApplication().openURL(NSURL.init(string: "sms://" + number)!)
    }
    
    
}

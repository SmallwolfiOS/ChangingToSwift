//
//  ViewController.swift
//  ChangingToSwift03
//
//  Created by Jason on 16/6/14.
//  Copyright © 2016年 Jason. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dateComp:NSDateComponents = NSDateComponents ()
        dateComp.year = 2016
        dateComp.month = 06
        dateComp.day = 15
        dateComp.hour = 14
        dateComp.minute = 38
        dateComp.timeZone = NSTimeZone.systemTimeZone()
        
        let calender:NSCalendar = NSCalendar.init(calendarIdentifier: NSCalendarIdentifierGregorian )!
        let date = calender.dateFromComponents(dateComp)
        
        let notification = UILocalNotification()
        notification.category = "FIRST_CATEGORY"
        notification.alertBody = "Hi, I am a notification"
        notification.fireDate = date
        notification.alertAction = "alertAction"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        
        
    }
    
    
    /**
     晃动的动画
     - parameter sender: 控件
     */
    func shakeAnimation(sender: AnyObject) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, 0]
        animation.keyTimes = [0, 1/6.0, 3/6.0, 5/6.0, 1]
        animation.duration = 0.4
        animation.additive = true
        sender.layer.addAnimation(animation, forKey: "shake")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


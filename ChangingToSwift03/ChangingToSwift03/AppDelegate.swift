//
//  AppDelegate.swift
//  ChangingToSwift03
//
//  Created by Jason on 16/6/14.
//  Copyright © 2016年 Jason. All rights reserved.
//

 /// 自定义通知的Action


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let notificationSettings : UIUserNotificationSettings! = UIApplication.sharedApplication().currentUserNotificationSettings()
        if notificationSettings.types == UIUserNotificationType.None {
            setupNotificationSettings()
        }
        return true
    }

    func setupNotificationSettings() {
        
        /*标示符（identifier）：字符串，标示了一个对于整个App唯一的字符串。很明显，你永远不应该在同一个App中定义两个同样地标示符。通过此标示符，我们可以决定在用户点击不同的通知时，调用哪个动作。
        标题（title）：用来在展示给用户的动作按钮上。可以是简单地或者本地化的字符串。为了让用户能马上理解动作的含义，一定要仔细考虑这个标题的值，最好是1到2个字符。
        （destructive）：布尔值。当设置为true时，通知中相应地按钮的背景色会变成红色。这只会在banner通知中出现。通常，当动作代表着删除、移除或者其他关键的动作是都会被标记为destructive以获得用户的注意。
        authenticationRequired：布尔值。当设置为true时，用户在点击动作之前必须确认自己的身份。当一个动作十分关键时这非常有用，因为为认证的操作有可能会破坏App的数据。
        ActivationMode：枚举。决定App在通知动作点击后是应该被启动还是不被启动。此枚举有两个值： （a）UIUserNotificationActivationModeForeground, （b）UIUserNotificationActivationModeBackground。在background中，App被给予了几秒中来运行 代码。*/
        
        let firstAction : UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        firstAction.identifier = "FIRST_ACTION"
        firstAction.title = "First Action"
        
        firstAction.activationMode = UIUserNotificationActivationMode.Background
        firstAction.destructive = true
        firstAction.authenticationRequired = false
        
        let secondAction : UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        secondAction.identifier = "SECOND_ACTION"
        secondAction.title = "Second Action"
        
        secondAction.activationMode = UIUserNotificationActivationMode.Foreground
        secondAction.destructive = false
        secondAction.authenticationRequired = false
        
        let thirdAction : UIMutableUserNotificationAction = UIMutableUserNotificationAction()
        thirdAction.identifier = "THIRD_ACTION"
        thirdAction.title = "Third Action"
        
        thirdAction.activationMode = UIUserNotificationActivationMode.Background
        thirdAction.destructive = true
        thirdAction.authenticationRequired = false
        
        //category
        let firstCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
        firstCategory.identifier = "FIRST_CATEGORY"
        
        let defaultActions = [firstAction,secondAction,thirdAction]
        let minimalACtions = [firstAction,secondAction]
        
        firstCategory.setActions(defaultActions, forContext: UIUserNotificationActionContext.Default)//在屏幕的中央展示一个完整的alert。(未锁屏时)        
        firstCategory.setActions(minimalACtions, forContext: UIUserNotificationActionContext.Minimal)//展示一个banner alert。
        
        //NSSet if our categories
        let categories = NSSet (object:firstCategory)
        
        let mySettings:UIUserNotificationSettings = UIUserNotificationSettings(forTypes:[.Badge, .Sound, .Alert] ,categories:categories as? Set<UIUserNotificationCategory>)
        UIApplication.sharedApplication().registerUserNotificationSettings(mySettings)
    }
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    /**
     *  通知的代理
     通过上述的方法，你可以得到所有UIUserNotificationSettings支持的类型。当你需要检查你的App所支持的通知和动作的类型时，这个方法非常有用。别忘了，用户可以通过用户设置来改变通知类型，所以我们不能保证，初始的通知类型一直都有效。
     */
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        print(notificationSettings.types.rawValue)
    }
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        print("Received Local Notification:")
        print(notification.alertBody)
    }
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        print(identifier)
        if identifier == "FIRST_ACTION" {
            print("哈哈哈哈哈")
        }else if identifier == "SECOND_ACTION"{
            print("嘿嘿嘿嘿嘿嘿")
        }
    }
}


//
//  DetailTableViewController.swift
//  ChangingToSwift01
//
//  Created by Jason on 16/5/26.
//  Copyright © 2016年 MHP. All rights reserved.
//

import UIKit
import MessageUI
import SafariServices


class DetailTableViewController: UITableViewController,MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate ,SFSafariViewControllerDelegate{

    var dataArray = ["发送带内容的短信","发送带内容的邮件","在App内部打开网址"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.tableFooterView = UIView.init(frame: CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! DetailTableViewCell
        
        cell.textString = self.dataArray[indexPath.row]
        cell .logData()
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        self.navigationController?.popViewControllerAnimated(true)
        ActionForCellWithIndexPath(indexPath)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    func ActionForCellWithIndexPath(indexPath:NSIndexPath) {
        switch indexPath.row {
        case 0:
            sendSMS("这里是短信内容" + "199103213213", recipientList: ["18810901468","18810901469"])
        case 1:
            sendMail("subject", recipients: ["1348748408@qq.com"], CcRecipients: ["1348748428@qq.com"], BccRecipients: ["1348748208@qq.com"], mailBody: "mailBody")
        case 2:
            openUrlInSFSafariVC("https://www.baidu.com")
        default:
            break
        }
    }
    func sendSMS(bodyOfMessage:String,recipientList:NSArray) {
        if MFMessageComposeViewController.canSendText() {
            let messageVC = MFMessageComposeViewController.init()
            messageVC.recipients = (recipientList as! [String])
            messageVC.body = bodyOfMessage
            messageVC.messageComposeDelegate = self;
            messageVC.navigationBar.tintColor = UIColor.redColor()//取消按钮的颜色
            self.presentViewController(messageVC, animated: true, completion: nil)
        }else {
            print("该设备不支持发送短信")
        }
    }
    
    //MARK: - MFMessageComposeViewControllerDelegate
    /**
     * 协议方法,在信息界面处理完信息结果时调用(比如点击发送,取消发送,发送失败)
     *
     * @param controller 信息控制器
     * @param result 返回的信息发送成功与否状态
     */
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        /** 发送完信息就回到原程序*/
        self.dismissViewControllerAnimated(true, completion: nil)
        switch result {
        case MessageComposeResultSent:
            print("发送成功")
        case MessageComposeResultFailed:
            print("发送失败")
        case MessageComposeResultCancelled:
            print("发送取消")
        default:
            break
        }
    }
    
    func sendMail(subject:String,recipients:[String],CcRecipients:[String],BccRecipients:[String],mailBody:String) {
        if MFMailComposeViewController.canSendMail() {
            let mailVC = MFMailComposeViewController.init()
            mailVC.setSubject(subject)//主题
            mailVC.setToRecipients(recipients)//收件人
            mailVC.setCcRecipients(CcRecipients)//抄送
            mailVC.setBccRecipients(BccRecipients)//密送
            mailVC.setMessageBody(mailBody, isHTML: false)//正文
            mailVC.mailComposeDelegate = self;
            self.presentViewController(mailVC, animated: true, completion: nil)
        }else{
            print("该设备不支持发送邮件")
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        switch result {
        case MFMailComposeResultSent:
            print("发送成功")
        case MFMailComposeResultFailed:
            print("发送失败")
        case MFMailComposeResultSaved:
            print("保存到草稿")
        case MFMailComposeResultCancelled:
            print("取消发送")
        default:
            break
        }
    }
    
    func openUrlInSFSafariVC(url:String) {
        let SFSafari = SFSafariViewController.init(URL: NSURL.init(string: url)!)
        SFSafari.view.tintColor = UIColor .redColor()
        SFSafari.delegate = self;
        self .presentViewController(SFSafari, animated: true, completion: nil)
    }
    //MARK:- SFSafariViewControllerDelegate
    func safariViewControllerDidFinish(controller: SFSafariViewController) {
        print("点击了Done")
        self .dismissViewControllerAnimated(true, completion: nil)
    }
    func safariViewController(controller: SFSafariViewController, didCompleteInitialLoad didLoadSuccessfully: Bool) {
        print("网页加载完成")
    }
//    func safariViewController(controller: SFSafariViewController, activityItemsForURL URL: NSURL, title: String?) -> [UIActivity] {
//        let textToShare = "微博跑"
//        let imageToShare = UIImage.init(named: "Group2")
//        let urlToShare = NSURL.init(string: "http://www.weibo.com")
//        let activityItems = [textToShare,urlToShare]
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ViewController.swift
//  ChangingToSwift01
//
//  Created by 马海平 on 16/5/25.
//  Copyright © 2016年 MHP. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var dataArray = ["打电话","发短信","发邮件","用Safari打开网址","拓展"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        changeBackgroundColor()
        self.tableView.tableFooterView = UIView.init()//影藏多余的cell
    }
    
    func changeBackgroundColor() {
        self.view.backgroundColor = UIColor.whiteColor()
    }
    
    
    //MARK:函数标签
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //TODO:要做的函数标签
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    //FIXME:修复bug
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        cell.textLabel?.text = String.init(format: "%@", dataArray[indexPath.row])
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("点击了第\(indexPath.section)组第\(indexPath.row)行")
        ActionForCellWithIndexPath(indexPath)
        
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func ActionForCellWithIndexPath(indexPath:NSIndexPath) {
        switch indexPath.row {
        case 0:
            print("点击了打电话")
            HP_Util.callNumberEndBackUpSuggest("18810901468", view: self.view)

        case 1:
            HP_Util.messageTo("18810901468")
        case 2:
            HP_Util.emailTo("swift@qq.com")
        case 3:
            HP_Util.openInSafariUrl("http://www.baidu.com")
        case 4:
            performSegueWithIdentifier("PushToDetail", sender: self.dataArray[indexPath.row])
        default:
            break
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let strValue = sender as! String
        if segue.identifier == "PushToDetail" {
            let pushVC = segue.destinationViewController
            pushVC.title = strValue
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


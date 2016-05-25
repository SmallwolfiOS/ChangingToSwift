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
    var dataArray = ["0","1","2","3","4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.changeBackgroundColor()
    }
    
    func changeBackgroundColor() {
        self.view.backgroundColor = UIColor.yellowColor()
    }
    
    
    //MARK:函数标签
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    //TODO:要做的函数标签
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    //FIXME:修复bug
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")!
        cell.textLabel?.text = String.init(format: "这是第%d行", indexPath.row)
        return cell
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


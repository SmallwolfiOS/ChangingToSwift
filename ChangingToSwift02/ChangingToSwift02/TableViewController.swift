//
//  TableViewController.swift
//  ChangingToSwift02
//
//  Created by Jason on 16/6/2.
//  Copyright © 2016年 Jason. All rights reserved.
//

import UIKit
class A {
    var number:Int {
        get{
            print("get")
            return 1
        }
        set{
            print("set")
        }
    }
}

class B: A {
    override var number: Int{
        willSet{
            print("willSet")
        }
        didSet{
            print("didSet")
        }
    }
}

class TableViewController: UITableViewController {
    var dataArray = ["使用原生UIImagePickerViewController","使用AVFoundation"]
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView.init(frame: CGRectZero)
        self.tableView.rowHeight = 60
        let b = B()
        
        b.number = 0
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]

        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.row
        if index == 0 {
            performSegueWithIdentifier("PushToDetail", sender: indexPath.row)
        }else if index == 1{
            performSegueWithIdentifier("PushToAv", sender: indexPath.row)
        }
        
    }
        /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

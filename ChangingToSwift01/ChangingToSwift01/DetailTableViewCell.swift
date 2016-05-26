//
//  DetailTableViewCell.swift
//  ChangingToSwift01
//
//  Created by Jason on 16/5/26.
//  Copyright © 2016年 MHP. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func logData() {
        print("居然成功了")
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

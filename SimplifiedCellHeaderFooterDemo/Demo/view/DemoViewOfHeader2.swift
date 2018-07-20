//
//  DemoViewOfHeader2.swift
//  SimplifiedCellHeaderFooterDemo
//
//  Created by Creater on 2018/7/20.
//  Copyright © 2018年 陈波. All rights reserved.
//

import UIKit

class DemoViewOfHeader2: UITableViewHeaderFooterView {
    let lbl1 = UILabel()
    let lbl2 = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(lbl1)
        lbl1.backgroundColor = UIColor.lightGray;
        lbl1.frame = CGRect(x: 15.0, y: 16.0, width: 180.0, height: 20.0)
        
        self.contentView.addSubview(lbl2)
        lbl2.backgroundColor = UIColor.lightGray;
        lbl2.frame = CGRect(x: UIScreen.main.bounds.size.width - 220.0, y: 40.0, width: 180.0, height: 20.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//
//  StartTVC.swift
//  SimplifiedCellHeaderFooterDemo
//
//  Created by 陈波 on 2017/8/26.
//  Copyright © 2017年 陈波. All rights reserved.
//

import UIKit

class StartTVC: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "StartTVC"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 20
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 60
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }
    
    // cell 数据源
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section % 2 == 0 {
            let cell = tableView.cell(aClass: DemoCell1.self)  as! DemoCell1
            cell.lblTitle.text = "DemoCell1"
            cell.lblSubTitle.text = "\(indexPath.section)  ==> \(indexPath.row)"
            return cell
        }
        else {
            let cell = tableView.cell(aClass: DemoCell2.self)  as! DemoCell2
            cell.lbl1.text = "\(indexPath.section)  ==> \(indexPath.row)"
            return cell
        }
    }
    
    // header 数据源
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 根据不同组来使用不同的header或footer
        if section % 2 == 0 {
            return tableView.headerFooter(aClass: DemoViewOfFooter1.self, closure: { (viewIn) in
                let v = viewIn as! DemoViewOfFooter1
                v.lbl1.text = "section: \(section)"
                v.lbl2.text = "as: Header"
                v.backgroundColor = .yellow
            })
        }
        else {
            return tableView.headerFooter(aClass: DemoViewOfFooter1.self, closure: { (viewIn) in
                let v = viewIn as! DemoViewOfFooter1
                v.lbl1.text = "section: \(section)"
                v.lbl2.text = "as: Header"
                v.backgroundColor = .yellow
            })
        }
    }
    
    // footer 数据源
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section % 2 == 1 {
            return tableView.headerFooter(aClass: DemoViewOfHeader1.self, closure: { (viewIn) in
                let v = viewIn as! DemoViewOfHeader1
                v.lbl1.text = "section: \(section)"
                v.lbl2.text = "as: Footer"
                v.backgroundColor = .green
            })
        }
        else {
            return tableView.headerFooter(aClass: DemoViewOfFooter1.self, closure: { (viewIn) in
                let v = viewIn as! DemoViewOfFooter1
                v.lbl1.text = "section: \(section)"
                v.lbl2.text = "as: Footer"
                v.backgroundColor = .cyan
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

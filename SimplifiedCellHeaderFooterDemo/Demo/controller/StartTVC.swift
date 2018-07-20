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
        else if indexPath.section % 3 == 1 {
            let cell = tableView.cell(aClass: DemoCell2.self)  as! DemoCell2
            cell.lbl1.text = "\(indexPath.section)  ==> \(indexPath.row)"
            return cell
        }
        else {
            let cell = tableView.cell(anyClass: DemoCell3.self)  as! DemoCell3
            cell.lbl1.text = "\(indexPath.section)  ==> \(indexPath.row)"
            cell.lbl2.text = "DemoCell3"
            return cell
        }
    }
    
    // header 数据源
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 根据不同组来使用不同的header或footer
        if section % 3 == 0 {
            let hf = tableView.headerFooter(aClass: DemoViewOfFooter1.self)as! DemoViewOfFooter1
            hf.lbl1.text = "section: \(section)"
            hf.lbl2.text = "as: Header"
            hf.backgroundColor = .yellow
            return hf
        }
        else if section % 3 == 1 {
            let hf = tableView.headerFooter(aClass: DemoViewOfHeader1.self)as! DemoViewOfHeader1
            hf.lbl1.text = "section: \(section)"
            hf.lbl2.text = "as: Header"
            hf.backgroundColor = .blue
            return hf
        }
        else {
            let hf = tableView.headerFooter(anyClass: DemoViewOfHeader2.self) as! DemoViewOfHeader2
            hf.lbl1.text = "section: \(section)"
            hf.lbl2.text = "DemoViewOfHeader2 as: Header"
            return hf
        }
    }
    
    // footer 数据源
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section % 2 == 1 {
            let hf = tableView.headerFooter(aClass: DemoViewOfHeader1.self)as! DemoViewOfHeader1
            hf.lbl1.text = "section: \(section)"
            hf.lbl2.text = "as: Footer"
            hf.backgroundColor = .green
            return hf
        }
        else {
            let hf = tableView.headerFooter(aClass: DemoViewOfFooter1.self)as! DemoViewOfFooter1
            hf.lbl1.text = "section: \(section)"
            hf.lbl2.text = "as: Footer"
            hf.backgroundColor = .cyan
            return hf
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

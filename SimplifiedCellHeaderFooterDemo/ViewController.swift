//
//  ViewController.swift
//  SimplifiedCellHeaderFooterDemo
//
//  Created by 陈波 on 2017/8/26.
//  Copyright © 2017年 陈波. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func btnBottomClick(_ sender: Any) {
        navigationController?.pushViewController(StartTVC(), animated: true)
    }
}


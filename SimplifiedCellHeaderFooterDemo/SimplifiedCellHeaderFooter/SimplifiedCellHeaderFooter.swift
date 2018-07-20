//
//  SimplifiedCellHeaderFooter.swift
//
//
//  Created by 陈波 on 2017/8/26.
//
//

import UIKit

extension UITableView {
    // 基于直接加载XIB复用Cell的函数
    func cell(aClass: UITableViewCell.Type?) -> UITableViewCell? {
        let className = "\(String(describing: aClass!))"
        var cell = self.dequeueReusableCell(withIdentifier: className)
        if cell == nil {
            cell = (Bundle.main.loadNibNamed(className, owner: nil, options: nil)?.first as! UITableViewCell)
        }
        return cell
    }
    
    // 基于直接加载XIB复用Cell的函数
    func cell(anyClass: UITableViewCell.Type) -> UITableViewCell? {
        let className = "\(String(describing: anyClass))"
        var cell = self.dequeueReusableCell(withIdentifier: className)
        if cell == nil {
            let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let cls:AnyObject = NSClassFromString(namespace + "." + className)!
            let initClass = cls as! UITableViewCell.Type
            cell = initClass.init(style: .default, reuseIdentifier: className)
        }
        return cell
    }

    
    // MARK: - 复用header或footer视图(XIB)
    func headerFooter(aClass: UIView.Type?) -> UIView? {
        let className = "\(String(describing: aClass!))"
        var headerFooter:UIView? = (self.dequeueReusableHeaderFooterView(withIdentifier: className))
        // 新创建
        if headerFooter == nil {
            headerFooter = ((Bundle.main.loadNibNamed(className, owner: nil, options: nil)?.first) as! UIView)
        }
        return headerFooter;
    }
    
    // MARK: - 复用header或footer视图(XIB)
    func headerFooter(anyClass: UIView.Type?) -> UIView? {
        let className = "\(String(describing: anyClass!))"
        var headerFooter:UIView? = self.dequeueReusableHeaderFooterView(withIdentifier: className)
        // 新创建
        if headerFooter == nil {
            let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let cls:AnyObject = NSClassFromString(namespace + "." + className)!
            let initClass = cls as! UITableViewHeaderFooterView.Type
            headerFooter = initClass.init(reuseIdentifier: className)
        }
        return headerFooter;
    }
}

// MARK: - 加载XIB第一个视图
extension UIView {
    static func loadViewFromBundle1st(view nibName:String) -> UIView {
        return ((Bundle.main.loadNibNamed(nibName, owner: nil, options: nil))?.first) as! UIView
    }
}


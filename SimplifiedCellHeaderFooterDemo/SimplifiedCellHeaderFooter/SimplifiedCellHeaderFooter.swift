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
    
    // MARK: - 复用header或footer视图
    func headerFooter(aClass: UIView.Type?, closure:(UIView)->()) -> BaseTableViewHeaderFooterView {
        let hf: BaseTableViewHeaderFooterView?
        let className = "\(String(describing: aClass!))"
        var headerFooter = self.dequeueReusableHeaderFooterView(withIdentifier: className)
        // 新创建
        if headerFooter == nil {
            headerFooter = BaseTableViewHeaderFooterView(reuseIdentifier: className)
            hf = headerFooter as? BaseTableViewHeaderFooterView
            hf?.viewReuse = UIView.loadViewFromBundle1st(view: className)
            hf?.viewReuse.frame = (headerFooter?.bounds)!
            headerFooter?.addSubview((hf?.viewReuse)!)
        }
        else {
            hf = headerFooter as? BaseTableViewHeaderFooterView
        }
        closure((hf?.viewReuse)!)
        return hf!
    }
}

// MARK: - 加载XIB第一个视图
extension UIView {
    static func loadViewFromBundle1st(view nibName:String) -> UIView {
        return ((Bundle.main.loadNibNamed(nibName, owner: nil, options: nil))?.first) as! UIView
    }
}


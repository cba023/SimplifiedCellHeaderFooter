# SimplifiedCellHeaderFooter

史上最科学！Swift 3.0 UITableView最佳实践 XIB极速实现UITableViewCell,UITableViewHeaderFooterView

##开发环境

 Mac OS 10.12+ / Xcode 8+ / Swift 3+
## 支持环境
iOS 8+, iPhone & iPad
## 项目获取
此处代码由Swift3.1展示，推荐使用Swift项目已经上传至github中[SimplifiedCellHeaderFooter](https://github.com/cba023/SimplifiedCellHeaderFooter)(https://github.com/cba023/SimplifiedCellHeaderFooter)
若要使用，请导入文件到您的项目。

## 功能展示

![desc.gif](http://upload-images.jianshu.io/upload_images/2484280-2e20b067d4103cdc.gif?imageMogr2/auto-orient/strip)


## 使用说明
### 导入项目
####  手动导入
![手动导入项目需要将该文件夹的所有内容引入项目中](http://upload-images.jianshu.io/upload_images/2484280-69d65d89763f9de3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
如图所示，将“SimplifiedCellHeaderFooter”文件夹拖入要用到该框架的工程中，在Swift项目中，可直接对其进行使用。

#### 函数调用

* cell数据源调用
```
// cell 数据源
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.cell(aClass: DemoCell1.self)  as! DemoCell1
      cell.lbl1.text = "\(indexPath.section)  ==> \(indexPath.row)"
      return cell
    }
```

* header数据源 或 footer数据源
```
 // header 数据源
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 根据不同组来使用不同的header或footer
        return tableView.headerFooter(aClass: DemoViewOfHeader1.self, closure: { (viewIn) in
                let v = viewIn as! DemoViewOfHeader1
                v.lbl1.text = "section: \(section)"
                v.lbl2.text = "as: Header"
                v.backgroundColor = .orange
            })
    }
```

### 实现原理



#### 函数封装

cell数据源函数封装

```
 // 基于直接加载XIB复用Cell的函数
    func cell(aClass: UITableViewCell.Type?) -> UITableViewCell? {
        let className = "\(String(describing: aClass!))"
        var cell = self.dequeueReusableCell(withIdentifier: className)
        if cell == nil {
            cell = (Bundle.main.loadNibNamed(className, owner: nil, options: nil)?.first as! UITableViewCell)
        }
        return cell
    }
```

header或footer数据源函数封装
```
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
```

 XIB第一个视图的加载
```
// MARK: - 加载XIB第一个视图
extension UIView {
    static func loadViewFromBundle1st(view nibName:String) -> UIView {
        return ((Bundle.main.loadNibNamed(nibName, owner: nil, options: nil))?.first) as! UIView
    }
}
```


#### XIB创建与关联
* 创建cell和XIB，创建后要检查XIB与复用的cell（header或footer）是否关联


![创建Cell和XIB](http://upload-images.jianshu.io/upload_images/2484280-337f13daf3c73474.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![关联XIB与Cell](http://upload-images.jianshu.io/upload_images/2484280-7bd28216676cc5bd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

通过简单的封装UITableView可以在非常简洁的情况下调用cell,header,footer等视图了，免去了每次在数据源函数判断视图是否为空或在UITableView初始化时注册的麻烦，没有读懂？请原谅我写得不太优美，欢迎去github下载https://github.com/cba023/SimplifiedCellHeaderFooter。亲，学会了吧？赶快去嗨皮吧！

## 致读者
该项目已经上传至github中[SimplifiedCellHeaderFooter](https://github.com/cba023/SimplifiedCellHeaderFooter)(https://github.com/cba023/SimplifiedCellHeaderFooter)
可以在那里直接star 或者fork 该项目，它可能会长期的帮助您高效地进行程序开发，当然也欢迎留言，有不足或者错误的地方可以随时指正，您的指导和建议是我前行路上新的动力！

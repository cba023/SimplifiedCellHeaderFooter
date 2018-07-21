# SimplifiedCellHeaderFooter
史上最科学！Swift UITableView最佳实践 XIB极速实现UITableViewCell,UITableViewHeaderFooterView

## 开发环境

 Mac OS 10.12+ / Xcode 8+ / Swift 3+
## 支持环境
iOS 8+, iPhone & iPad
## 项目获取
项目已经上传至github中，若要使用，请导入文件到您的项目。
Swift版本： [SimplifiedCellHeaderFooter](https://github.com/cba023/SimplifiedCellHeaderFooter)(https://github.com/cba023/SimplifiedCellHeaderFooter) 
Objective-C版本：[SimplifiedCellHeaderFooterOC](https://github.com/cba023/SimplifiedCellHeaderFooterOC)(https://github.com/cba023/SimplifiedCellHeaderFooterOC)

## 功能展示

![功能演示](http://upload-images.jianshu.io/upload_images/2484280-2e20b067d4103cdc.gif?imageMogr2/auto-orient/strip)


## 使用说明
### 导入项目
####  手动导入
![手动导入项目需要将该文件夹的所有内容引入项目中](http://upload-images.jianshu.io/upload_images/2484280-69d65d89763f9de3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

如图所示，将“SimplifiedCellHeaderFooter”文件夹拖入要用到该框架的工程中，在Swift项目中，可直接对其进行使用。

#### 函数调用

> Swift

* cell数据源调用

```
// cell 数据源Swift
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
        if section % 2 == 0 {
            let hf = tableView.headerFooter(aClass: DemoViewOfFooter1.self)as! DemoViewOfFooter1
            hf.lbl1.text = "section: \(section)"
            hf.lbl2.text = "as: Header"
            hf.backgroundColor = .yellow
            return hf
        }
        else {
            let hf = tableView.headerFooter(aClass: DemoViewOfHeader1.self)as! DemoViewOfHeader1
            hf.lbl1.text = "section: \(section)"
            hf.lbl2.text = "as: Header"
            hf.backgroundColor = .blue
            return hf
        }
    }
    
```

> Objective-C

* cell数据源调用

```


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DemoCell1 * cell = [tableView cellWithClass:[DemoCell1 class] fileType:FileTypeNib];
    return cell;
}
    
```

* header数据源 或 footer数据源

```
 
// header 数据源
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     DemoHeaderFooterView2 * hf = [tableView headerFooterFromNib:[DemoHeaderFooterView2 class]];
    return hf;
}
    
```

### 实现原理



#### 函数封装

> Swift

* cell数据源函数封装(XIB)

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

* cell数据源函数封装(手写代码)

```
// 基于直接加载手写代码复用Cell的函数
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
```

* header或footer数据源函数封装(XIB)


```
// 复用header或footer视图(XIB)
    func headerFooter(aClass: UIView.Type?) -> UIView? {
        let className = "\(String(describing: aClass!))"
        var headerFooter:UIView? = (self.dequeueReusableHeaderFooterView(withIdentifier: className))
        // 新创建
        if headerFooter == nil {
            headerFooter = ((Bundle.main.loadNibNamed(className, owner: nil, options: nil)?.first) as! UIView)
        }
        return headerFooter;
    }
```

* header或footer数据源函数封装(手写代码)

```
// 复用header或footer视图(手写代码)
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
```

> Objective-C

* cell数据源函数封装

```
- (id)cellWithClass:(Class)class fileType:(FileType)fileType {
    NSString *classString = [self getClassNameWithClass:class];
    id cell = [self dequeueReusableCellWithIdentifier:classString];
    if (!cell) {
        switch (fileType) {
            case FileTypeNib:
                cell = ([[NSBundle mainBundle] loadNibNamed:classString owner:nil options:nil].firstObject);
                break;
            case FileTypeClass:
                cell = [[class alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:classString];
                break;
            default:
                break;
        }
    }
    return cell;
}
```

* header或footer数据源函数封装(XIB)


```
/** 根据xib创建header或footer */
- (id)headerFooterFromNib:(Class)nibClass {
    NSString *classString = [self getClassNameWithClass:nibClass];
    UIView *headerFooter = [self dequeueReusableHeaderFooterViewWithIdentifier:classString];
    if (!headerFooter) {
        headerFooter = [[NSBundle mainBundle] loadNibNamed:classString owner:nil options:nil].firstObject;
    }
    return headerFooter;
}
```

* header或footer数据源函数封装(手写代码)

```
/** 通过类注册创建header或footer */
- (id)headerFooterFromClass:(Class)aClass {
    NSString *classString = [self getClassNameWithClass:aClass];
    UIView *headerFooter = [self dequeueReusableHeaderFooterViewWithIdentifier:classString];
    if (!headerFooter) {
        headerFooter = [[aClass alloc] initWithReuseIdentifier:classString];
    }
    return headerFooter;
}
```


#### XIB创建与关联
* 创建cell和XIB，创建后要检查XIB与复用的cell（header或footer）是否关联


![创建Cell和XIB](http://upload-images.jianshu.io/upload_images/2484280-337f13daf3c73474.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![关联XIB与Cell](http://upload-images.jianshu.io/upload_images/2484280-7bd28216676cc5bd.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

通过简单的封装UITableView可以在非常简洁的情况下调用cell,header,footer等视图了，免去了每次在数据源函数判断视图是否为空或在UITableView初始化时注册的麻烦。亲，学会了吧？赶快去嗨皮吧！

## 致读者
该项目已经上传至github中[SimplifiedCellHeaderFooter](https://github.com/cba023/SimplifiedCellHeaderFooter)(https://github.com/cba023/SimplifiedCellHeaderFooter)。另有Objective-C版本，请打开[SimplifiedCellHeaderFooterOC](https://github.com/cba023/SimplifiedCellHeaderFooterOC) 链接即可。
可以在那里直接star 或者fork 该项目，它可能会长期的帮助您高效地进行程序开发，当然也欢迎留言，有不足或者错误的地方可以随时指正，您的指导和建议是我前行路上新的动力！





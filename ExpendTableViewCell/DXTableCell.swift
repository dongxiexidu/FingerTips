//
//  DXTableCell.swift
//  ExpendTableViewCell
//
//  Created by fashion on 2017/6/15.
//  Copyright © 2017年 lidongxi. All rights reserved.
//

import UIKit

enum DXShowCellTextType {
    case normal
    case expand
}

class DXTableCell: UITableViewCell {
    
    var normalLabel: UILabel!
    var expandLabel: UILabel!
    var superTableView: UITableView!
    var cellType : DXShowCellTextType
    
    static let identify = "cell"
    
    class func cellWithTableView(tableView : UITableView) -> DXTableCell {
        
        
        var cell = tableView.dequeueReusableCell(withIdentifier: identify) as? DXTableCell
        if cell == nil {
            cell = DXTableCell.init(style: .default, reuseIdentifier: identify)
            cell?.superTableView = tableView
        }
        return cell!
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.cellType = .normal
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        setupContentView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   fileprivate func setupContentView() {
        normalLabel = UILabel.init(frame: CGRect.init(x: 10, y: 10, width: kScreenW-20, height: 0))
        expandLabel = UILabel.init(frame: CGRect.init(x: 10, y: 10, width: kScreenW-20, height: 0))
        
        normalLabel?.textColor = UIColor.gray
        expandLabel?.textColor = UIColor.black
        
        normalLabel?.font = UIFont.systemFont(ofSize: 14)
        expandLabel?.font = UIFont.systemFont(ofSize: 14)
        
        normalLabel?.numberOfLines = 4
        expandLabel?.numberOfLines = 0
        
        normalLabel?.alpha = 1
        expandLabel?.alpha = 0
        
        self.contentView.addSubview(normalLabel)
        self.contentView.addSubview(expandLabel)
    }
    
    var model : DXCellModel? {
        didSet{
            self.cellType = (model?.cellType)!
            if model?.cellType == .expand {
                normalLabel.alpha = 0
                expandLabel.alpha = 1
                normalLabel.frame = CGRect.init(x: 10, y: 10, width: kScreenW-20, height: 10)
                expandLabel.frame = CGRect.init(x: 10, y: 10, width: kScreenW-20, height: 10)
            }else{
                normalLabel.alpha = 1
                expandLabel.alpha = 0
                normalLabel.frame = CGRect.init(x: 10, y: 10, width: kScreenW-20, height: 10)
                expandLabel.frame = CGRect.init(x: 10, y: 10, width: kScreenW-20, height: 10)
            }
            normalLabel.text = model?.contentStr
            expandLabel.text = model?.contentStr
            
            normalLabel.sizeToFit()
            expandLabel.sizeToFit()
        }
    }
    
   open func clickCell() {
        
        switch cellType {
        case .normal:
            self.cellType = .expand
            self.model?.cellType = .expand
            self.model?.cellHeigh = (self.model?.expandHeigh)!
            cellAnimate(cellType: .normal)
            self.superTableView.beginUpdates()
            self.superTableView.endUpdates()
        case .expand:
            self.cellType = .normal
            self.model?.cellType = .normal
            self.model?.cellHeigh = (self.model?.normalHeigh)!
            cellAnimate(cellType: .expand)
            self.superTableView.beginUpdates()
            self.superTableView.endUpdates()
        default:
            break
        }
    }
    
    func cellAnimate(cellType : DXShowCellTextType){
        if cellType == .normal {
            UIView.animate(withDuration: 0.35, animations: { 
                self.expandLabel.alpha = 1
                self.normalLabel.alpha = 0
            })
        }else{
            UIView.animate(withDuration: 0.35, animations: {
                self.expandLabel.alpha = 0
                self.normalLabel.alpha = 1
            })
        }
    }
    

}

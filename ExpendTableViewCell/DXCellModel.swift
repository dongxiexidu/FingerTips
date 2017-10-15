//
//  DXCellModel.swift
//  ExpendTableViewCell
//
//  Created by lidongxi on 17/1/2.
//  Copyright © 2017年 lidongxi. All rights reserved.
//

import UIKit

public let kScreenW = UIScreen.main.bounds.size.width
public let kScreenH = UIScreen.main.bounds.size.height

class DXCellModel: NSObject {

    var contentStr : String?
    var cellHeigh : CGFloat = 0.0
    var normalHeigh : CGFloat = 0.0
    var expandHeigh : CGFloat = 0.0
    var cellType : DXShowCellTextType!
    
    
    init(contentStr : String) {
        
        self.contentStr = contentStr
        self.cellType = DXShowCellTextType.normal
        
        let height1 = DXCellModel.getSpaceLabelHeight(text: contentStr, font: 14, width: kScreenW-20.0)
        let height2 = DXCellModel.getSpaceLabelHeight(text: "one", font: 14, width: kScreenW-20.0)
        self.expandHeigh = height1 + 20.0
        
        let normalTextHeight = height1 >= 4*height2 ? 4*height2 : height1
        self.normalHeigh = normalTextHeight + 20
        self.cellHeigh = self.normalHeigh
    }
    
    //MARK: --计算文字的高度
     fileprivate class func getSpaceLabelHeight(text:String,font:CGFloat,width:CGFloat) -> CGFloat {
        
        let paraDic:[String : Any] = [NSFontAttributeName:UIFont.systemFont(ofSize: font)]
        let size = text.boundingRect(with: CGSize(width:width,height:CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: paraDic, context: nil)
        return size.height;
    }
   
}

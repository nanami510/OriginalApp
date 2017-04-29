//
//  CalenderCellCollectionViewCell.swift
//  Original
//
//  Created by 後藤奈々美 on 2017/04/29.
//  Copyright © 2017年 litech. All rights reserved.
//

import UIKit

class CalenderCellCollectionViewCell: UICollectionViewCell {
    var textLabel: UILabel!
    
    required init (coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        //UILabelを生成
        textLabel = UILabel(frame: CGRect(x:0,y:0,width:self.frame.width,height:self.frame.height))
        textLabel.font = UIFont(name: "HiraKakuProN-W3", size: 12)
        textLabel.textAlignment = .center
        
        //cellに追加
        self.addSubview(textLabel!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    
}

//
//  ClasstableCollectionViewCell.swift
//  Original
//
//  Created by 後藤奈々美 on 2017/05/14.
//  Copyright © 2017年 litech. All rights reserved.
//

import UIKit

class ClasstableCollectionViewCell: UICollectionViewCell {
    var textLabel: UILabel!
    var textWeekLabel: UILabel!

    
    
    
    required init (coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        //UILabelを生成
        textLabel = UILabel(frame: CGRect(x:0,y:0,width:self.frame.width,height:self.frame.height))
        textLabel.font = UIFont(name: "HiraKakuProN-W3", size: 9)
        textLabel.textAlignment = .center
        
        textWeekLabel = UILabel(frame: CGRect(x:0,y:0,width:self.frame.width,height:self.frame.height))
        textWeekLabel.font = UIFont(name: "HiraKakuProN-W3", size: 12)
        textWeekLabel.textAlignment = .center
        

        
        //cellに追加
        self.addSubview(textLabel!)
        self.addSubview(textWeekLabel!)

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    
}

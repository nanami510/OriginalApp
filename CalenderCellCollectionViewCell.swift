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
    var textWeekLabel: UILabel!
    var textTitleLabel: UILabel!
    var textTitle2Label: UILabel!

    
    
    required init (coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
        //UILabelを生成
        textLabel = UILabel(frame: CGRect(x:0,y:0,width:self.frame.width,height:self.frame.height*1/5))
        textLabel.font = UIFont(name: "HiraKakuProN-W3", size: 9)
        textLabel.textAlignment = .center
        
        textWeekLabel = UILabel(frame: CGRect(x:0,y:0,width:self.frame.width,height:self.frame.height))
        textWeekLabel.font = UIFont(name: "HiraKakuProN-W3", size: 12)
        textWeekLabel.textAlignment = .center
        
        textTitleLabel = UILabel(frame: CGRect(x:0,y:0,width:self.frame.width,height:self.frame.height*4/5))
        textTitleLabel.font = UIFont(name: "HiraKakuProN-W3", size: 9)
        textTitleLabel.textAlignment = .center
        textTitleLabel.textColor=UIColor.purple
        textTitle2Label = UILabel(frame: CGRect(x:0,y:0,width:self.frame.width,height:self.frame.height*7/5))
        textTitle2Label.font = UIFont(name: "HiraKakuProN-W3", size: 9)
        textTitle2Label.textAlignment = .center
        textTitle2Label.textColor=UIColor.purple
        
        //cellに追加
        self.addSubview(textLabel!)
        self.addSubview(textWeekLabel!)
        self.addSubview(textTitleLabel!)
        self.addSubview(textTitle2Label!)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    
}



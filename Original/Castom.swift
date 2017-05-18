//
//  Castom.swift
//  Original
//
//  Created by 後藤奈々美 on 2017/05/18.
//  Copyright © 2017年 litech. All rights reserved.
//

import UIKit

class Castom: UIButton {

        @IBDesignable class CustomButton: UIButton {
            
            // 角丸の半径(0で四角形)
            @IBInspectable var cornerRadiuss: CGFloat = 0.0
            
            // 枠
            @IBInspectable var borderColors: UIColor = UIColor.clear
            @IBInspectable var borderWidths: CGFloat = 0.0
            
            override func draw(_ rect: CGRect) {
                // 角丸
                self.layer.cornerRadius = cornerRadiuss
                self.clipsToBounds = (cornerRadius > 0)
                
                // 枠線
                self.layer.borderColor = borderColors.cgColor
                self.layer.borderWidth = borderWidths
                
                super.draw(rect)
            
        }
    }
}

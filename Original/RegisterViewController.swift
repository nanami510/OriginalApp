//
//  RegisterViewController.swift
//  Original
//
//  Created by 後藤奈々美 on 2017/04/29.
//  Copyright © 2017年 litech. All rights reserved.
//
import Foundation
import UIKit

class RegisterViewController: UIViewController {

    
    
    @IBAction func onTouchBootMenuButton(_ sender: UIButton) {
        guard let rootViewController = rootViewController() else { return }
        rootViewController.presentMenuViewController()
    }



    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

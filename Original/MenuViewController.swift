//
//  MenuViewController.swift
//  Original
//
//  Created by 後藤奈々美 on 2017/04/29.
//  Copyright © 2017年 litech. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController : UIViewController {
    @IBAction func onTouchCloseButton(_ sender: UIButton) {
        guard let rootViewController = rootViewController() else {return }
        rootViewController.dismissMenuViewController()
    }
    
    @IBAction func onTouchContentButton(_ sender: UIButton) {
        guard let rootViewController = rootViewController() else {return }
        rootViewController.dismissMenuViewController()
        
        let profileViewController = self.storyboard!.instantiateViewController(withIdentifier: "content")
        rootViewController.set(contentViewController: profileViewController)
    }
    
    @IBAction func onTouchRegisterButton(_ sender: UIButton) {
        guard let rootViewController = rootViewController() else {return }
        rootViewController.dismissMenuViewController()
        
        let registerViewController = self.storyboard!.instantiateViewController(withIdentifier: "register")
        rootViewController.set(contentViewController: registerViewController)
    }
    @IBAction func onTouchTimeTableButton(_ sender: UIButton) {
        guard let rootViewController = rootViewController() else {return }
        rootViewController.dismissMenuViewController()
        
        let timeTableViewController = self.storyboard!.instantiateViewController(withIdentifier: "timetable")
        rootViewController.set(contentViewController: timeTableViewController)
    }
}

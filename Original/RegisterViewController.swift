//
//  RegisterViewController.swift
//  Original
//
//  Created by 後藤奈々美 on 2017/04/29.
//  Copyright © 2017年 litech. All rights reserved.
//
import Foundation
import UIKit
import RealmSwift

class RegisterViewController: UIViewController {

     @IBOutlet weak var week: UITextField!
     @IBOutlet weak var period: UITextField!
     @IBOutlet weak var classOfTitle: UITextField!
    
    @IBAction func onTouchBootMenuButton(_ sender: UIButton) {
        guard let rootViewController = rootViewController() else { return }
        rootViewController.presentMenuViewController()
    }

    
    @IBAction func addButton(_sender: Any) {
        let realm = try! Realm()
        
        let timetable = TimeTable()
        timetable.title = classOfTitle.text!
        timetable.dayOfTheWeek = week.text!
        timetable.period = Int(period.text!)!
        timetable.id=(realm.objects(TimeTable.self).max(ofProperty: "id") as Int? ?? 0) + 1
        try! realm.write {
            realm.add(timetable)
        }
        self.dismiss(animated: true, completion: nil)
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

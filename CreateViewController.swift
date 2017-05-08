//
//  CreateViewController.swift
//  RealmApp
//
//  Created by 後藤奈々美 on 2017/05/04.
//  Copyright © 2017年 litech. All rights reserved.
//

import UIKit
import RealmSwift

class Todo: Object {
    dynamic var todo_id = ""
    dynamic var title = ""
    dynamic var date = ""
    dynamic var starttime = ""
    dynamic var endtime = ""
    dynamic var memo = ""
    }

class TimeTable: Object {
    dynamic var timetable_id = ""
    dynamic var title = ""
    dynamic var dayOfTheWeek = ""
    dynamic var period=""
    
}

class Note:Object{
    dynamic var note_id = ""
    dynamic var title = ""
    dynamic var dayOfTheWeek = ""
    dynamic var period=""
    dynamic var date = ""
}


class CreateViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var date:UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var start: UITextField!
    @IBOutlet weak var end: UITextField!
    @IBOutlet weak var textView:UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        date.text = selectedDay
        start.delegate = self
        end.delegate = self
        textField.delegate = self
        textField.returnKeyType = .done
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(textFieldDidChange),
            name: NSNotification.Name.UITextFieldTextDidChange,
            object: textField)
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        textView.isEditable = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldDidChange(notification: NSNotification) {
        let textFieldString = notification.object as! UITextField
        if let text = textFieldString.text {
            if text.characters.count > 8 {
                textField.text = text.substring(to: text.index(text.startIndex, offsetBy: 3))
            }
        }
    }
    
    @IBAction func createButton(_sender: Any) {
        let realm = try! Realm()
        
        let todo = Todo()
        todo.title = textField.text!
        todo.date = selectedDay!
        todo.starttime = start.text!
        todo.endtime = end.text!
        
        todo.memo = textView.text
        try! realm.write {
            realm.add(todo)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

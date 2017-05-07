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
    dynamic var title = ""
    dynamic var date = ""
    
}


class CreateViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        textField.delegate = self
    }
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func createButton(_sender: Any) {
        let realm = try! Realm()
        
        let todo = Todo()
        todo.title = textField.text!
        todo.date = selectedDay!
        try! realm.write {
            realm.add(todo)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }
    
    
    
    
}

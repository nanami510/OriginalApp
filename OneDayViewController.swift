//
//  OneDayViewController.swift
//  
//
//  Created by 後藤奈々美 on 2017/05/16.
//
//

import UIKit
import RealmSwift


class OneDayViewController: UIViewController, UITextFieldDelegate {
    var selectedID:Int!
    let realm = try! Realm() //いつもの
   
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var start: UITextField!
    @IBOutlet weak var end: UITextField!
    @IBOutlet weak var textView:UITextView!
    
    let nowDate = NSDate()
    let dateFormat = DateFormatter()
    let inputDatePicker = UIDatePicker()
    let inputStartDatePicker = UIDatePicker()
    let inputEndDatePicker = UIDatePicker()
    let timeFormat = DateFormatter()
    let inputStartTimePicker = UIDatePicker()
    let inputEndTimePicker = UIDatePicker()
    
    
    
    
    @IBOutlet weak var dateSelecter: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let todoCollection = realm.objects(Todo.self)
        let todo = todoCollection.filter("id  == %@",selectedID )
        if todo.count != 0 {
        self.textField.text=todo[0].title
        }
        
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
        
        
        //日付フィールドの設定
        dateFormat.dateFormat = "yyyy年MM月dd日"
        dateSelecter.text = dateFormat.string(from: todo[0].date as Date)
        self.dateSelecter.delegate = self
        
        // DatePickerの設定(日付用)
        inputDatePicker.datePickerMode = UIDatePickerMode.date
        dateSelecter.inputView = inputDatePicker
        
        // キーボードに表示するツールバーの表示
        let pickerToolBar = UIToolbar(frame: CGRect(x:0, y:self.view.frame.size.height/6,width: self.view.frame.size.width,height: 40.0))
        pickerToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        pickerToolBar.barStyle = .blackTranslucent
        pickerToolBar.tintColor = UIColor.white
        pickerToolBar.backgroundColor = UIColor.black
        
        //ボタンの設定
        //右寄せのためのスペース設定
        let spaceBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,target: self,action: nil)
        
        
        //完了ボタンを設定
        let toolBarBtn      = UIBarButtonItem(title: "完了", style: .done, target: self, action:#selector(toolBarBtnPush(sender:)))
        
        
        //ツールバーにボタンを表示
        pickerToolBar.items = [spaceBarBtn,toolBarBtn]
        dateSelecter.inputAccessoryView = pickerToolBar
        
        
        
        //日付フィールドの設定
        timeFormat.dateFormat = "kk:mm"
        start.text = todo[0].starttime
        self.start.delegate = self
        
        // DatePickerの設定(時間用)
        inputStartTimePicker.datePickerMode = UIDatePickerMode.time
        start.inputView = inputStartTimePicker
        
        //完了ボタンを設定
        let toolStartBarBtn      = UIBarButtonItem(title: "完了", style: .done, target: self, action:#selector(toolStartBarBtnPush(sender:)))
        // キーボードに表示するツールバーの表示
        let pickerStartToolBar = UIToolbar(frame: CGRect(x:0, y:self.view.frame.size.height/6,width: self.view.frame.size.width,height: 40.0))
        pickerStartToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        pickerStartToolBar.barStyle = .blackTranslucent
        pickerStartToolBar.tintColor = UIColor.white
        pickerStartToolBar.backgroundColor = UIColor.black
        
        //ツールバーにボタンを表示
        pickerStartToolBar.items = [spaceBarBtn,toolStartBarBtn]
        start.inputAccessoryView = pickerStartToolBar
        
        //日付フィールドの設定
        
        end.text = todo[0].endtime
        self.end.delegate = self
        
        // DatePickerの設定(日付用)
        inputEndTimePicker.datePickerMode = UIDatePickerMode.time
        end.inputView = inputEndTimePicker
        
        //完了ボタンを設定
        let toolEndBarBtn      = UIBarButtonItem(title: "完了", style: .done, target: self, action:#selector(toolEndBarBtnPush(sender:)))
        // キーボードに表示するツールバーの表示
        let pickerEndToolBar = UIToolbar(frame: CGRect(x:0, y:self.view.frame.size.height/6,width: self.view.frame.size.width,height: 40.0))
        pickerEndToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        pickerEndToolBar.barStyle = .blackTranslucent
        pickerEndToolBar.tintColor = UIColor.white
        pickerEndToolBar.backgroundColor = UIColor.black
        
        //ツールバーにボタンを表示
        pickerEndToolBar.items = [spaceBarBtn,toolEndBarBtn]
        end.inputAccessoryView = pickerEndToolBar
        
        
        
    }
    
    func toolBarBtnPush(sender: UIBarButtonItem){
        
        let pickerDate = inputDatePicker.date
        dateSelecter.text = dateFormat.string(from: pickerDate)
        
        self.view.endEditing(true)
    }
    func toolStartBarBtnPush(sender: UIBarButtonItem){
        
        let pickerStartTime = inputStartTimePicker.date
        start.text = timeFormat.string(from: pickerStartTime)
        
        self.view.endEditing(true)
    }
    func toolEndBarBtnPush(sender: UIBarButtonItem){
        
        let pickerEndTime = inputEndTimePicker.date
        end.text = timeFormat.string(from: pickerEndTime)
        
        self.view.endEditing(true)
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
    
    @IBAction func save(_sender: Any) {
        let todoCollection = realm.objects(Todo.self)
        let todo = todoCollection.filter("id  == %@",selectedID )[0]
        if let title = textField.text, let date = dateFormat.date(from: dateSelecter.text!) , let starttime=start.text,let endtime=end.text,let memo = textView.text{
            try! realm.write {
                todo.title = title
                todo.date = date as NSDate
                todo.starttime = starttime
                todo.endtime = endtime
                todo.id=(realm.objects(Todo.self).max(ofProperty: "id") as Int? ?? 0) + 1
                todo.memo = memo
            }
            self.dismiss(animated: true, completion: nil)
        }
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

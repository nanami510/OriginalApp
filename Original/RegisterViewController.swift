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

class RegisterViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

     @IBOutlet weak var week: UITextField!
     @IBOutlet weak var periodtext: UITextField!
     @IBOutlet weak var classOfTitle: UITextField!
     let weekArray = ["月","火","水","木","金","土"]
     let periodArray = ["0","1","2","3","4","5","6"]
    
    @IBAction func onTouchBootMenuButton(_ sender: UIButton) {
        guard let rootViewController = rootViewController() else { return }
        rootViewController.presentMenuViewController()
    }
    

    
    @IBAction func addButton(_sender: Any) {
        let realm = try! Realm()
        
        let timetable = TimeTable()
        if let title = classOfTitle.text, let dayOFweek = week.text ,let period = Int(periodtext.text!) {
        timetable.title = title
        timetable.dayOfTheWeek = dayOFweek
        timetable.period = period
        timetable.id=(realm.objects(TimeTable.self).max(ofProperty: "id") as Int? ?? 0) + 1
        try! realm.write {
            realm.add(timetable)
        
        }
        self.dismiss(animated: true, completion: nil)
            let alert = UIAlertController(title:"Complete!", message: "講義:"+title+"を追加しました。", preferredStyle: UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (action: UIAlertAction!) in
                
            })
            
            
            alert.addAction(action)
            classOfTitle.text=nil
            week.text=nil
            periodtext.text=nil
            
           
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weekpickerView = UIPickerView()
        let periodpickerView = UIPickerView()
        
        //pickerView1
        weekpickerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: weekpickerView.bounds.size.height)
        weekpickerView.tag = 1             // <<<<<<<<<<　追加
        weekpickerView.delegate   = self
        weekpickerView.dataSource = self
        
        let vi1 = UIView(frame: weekpickerView.bounds)
        vi1.backgroundColor = UIColor.white
        vi1.addSubview(weekpickerView)
        
        week.inputView = vi1
        
        let toolBar1 = UIToolbar()
        toolBar1.barStyle = UIBarStyle.default
        toolBar1.isTranslucent = true
        toolBar1.tintColor = UIColor.black
        let doneButton1   = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(RegisterViewController.donePressed))
        let spaceButton1  = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar1.setItems([spaceButton1, doneButton1], animated: false)
        toolBar1.isUserInteractionEnabled = true
        toolBar1.sizeToFit()
        week.inputAccessoryView = toolBar1
        
        //pickerView2
        periodpickerView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: periodpickerView.bounds.size.height)
        periodpickerView.tag = 2             // <<<<<<<<<<　追加
        periodpickerView.delegate   = self
        periodpickerView.dataSource = self
        
        let vi2 = UIView(frame: periodpickerView.bounds)
        vi2.backgroundColor = UIColor.white
        vi2.addSubview(periodpickerView)
        
        periodtext.inputView = vi2
        
        let toolBar2 = UIToolbar()
        toolBar2.barStyle = UIBarStyle.default
        toolBar2.isTranslucent = true
        toolBar2.tintColor = UIColor.black
        let doneButton2   = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(RegisterViewController.donePressed))
        let spaceButton2  = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar2.setItems([spaceButton2, doneButton2], animated: false)
        toolBar2.isUserInteractionEnabled = true
        toolBar2.sizeToFit()
        periodtext.inputAccessoryView = toolBar2
        // Do any additional setup after loading the view, typically from a nib.
    }
    func donePressed() {
        view.endEditing(true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {    // <<<<<<<<<<　変更
            return weekArray.count
        } else {
            return periodArray.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {    // <<<<<<<<<<　変更
            return weekArray[row]
        } else {
            return periodArray[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {    // <<<<<<<<<<　変更
             week.text =  weekArray[row]
        } else {
            periodtext.text =  periodArray[row]
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

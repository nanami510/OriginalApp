//
//  DetailClassViewController.swift
//  Original
//
//  Created by 後藤奈々美 on 2017/05/18.
//  Copyright © 2017年 litech. All rights reserved.
//

import UIKit
import RealmSwift

class DetailClassViewController: UIViewController {
    var timetableID:Int!
    var classdate :NSDate!
    var titleOfclass: String!
    var youbi: String!
    
    @IBOutlet weak var titletext: UILabel!
    @IBOutlet weak var daytext: UILabel!
    @IBOutlet weak var notetext: UITextView!
    let dateFormat = DateFormatter()
    let realm = try! Realm() //いつもの


    override func viewDidLoad() {
        super.viewDidLoad()
        let noteCollection = realm.objects(Note.self)
       
        let note = noteCollection.filter("date  == %@",classdate).filter("deleate  == 0").filter("timetable_id  == %@",timetableID)
        if(note.count != 0 ){
            notetext.text = note[0].memo
        }
         dateFormat.dateFormat = "yyyy年MM月dd日"
         daytext.text=dateFormat.string(from: classdate as Date)
         titletext.text = titleOfclass

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func createButton() {
        let realm = try! Realm()
        if let date = classdate , let timetableid=timetableID,let memo = notetext.text{
            
            let note = Note()
            note.date = date as NSDate
            note.timetable_id = timetableid
            
            note.id=(realm.objects(Todo.self).max(ofProperty: "id") as Int? ?? 0) + 1
            note.memo = memo
            
            let noteCollection = realm.objects(Note.self)
            let notes = noteCollection.filter("date  == %@",classdate).filter("deleate  == 0").filter("timetable_id  == %@",timetableID)
            if(notes.count != 0){
                 note.edit_id = notes[0].id
            }
           
           
            try! realm.write {
                if(notes.count != 0){
                    notes[0].edit=1
                }
                realm.add(note)
            }
            
            let alert = UIAlertController(title:"Complete!", message: "ノート保存しました。", preferredStyle: UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (action: UIAlertAction!) in
                
            })
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
            
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

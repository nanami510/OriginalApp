//
//  TableViewController.swift
//  RealmApp
//
//  Created by 後藤奈々美 on 2017/05/04.
//  Copyright © 2017年 litech. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {
    var selectedDate:String!
    let dateFormat = DateFormatter()
    var selectedID:Int!
    let weekOfComp=Calendar.Component.weekday
    let weekArray = ["","日","月","火","水","木","金","土"]
    var selectedtimetableID:Int!
    var selectclassdate:NSDate!
    var titleofclass:String!
    var selectedyoubi:String!


    
    
   
    let realm = try! Realm() //いつもの
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormat.dateFormat = "yyyy年MM月dd日"
        self.title=dateFormat.string(from: dateOfSelectedDay)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "予定追加", style: .plain, target: self, action: #selector(self.goCreate))
   //     navigationItem.leftBarButtonItem = UIBarButtonItem(title: "戻る", style: .plain, //target: self, action: #selector(self.unwindToTop(segue:)))
        
    }
    
    
    
    func goCreate() {
        performSegue(withIdentifier: "goCreate", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goOneDay") {
            let oneDayVC: OneDayViewController = (segue.destination as? OneDayViewController)!
            // ViewControllerのtextVC2にメッセージを設定
            oneDayVC.selectedID=selectedID
        }else if(segue.identifier == "goCreateNote"){
            let detailclassVC: DetailClassViewController = (segue.destination as? DetailClassViewController)!
            detailclassVC.timetableID=selectedtimetableID
            dateFormat.dateFormat = "yyyy年MM月dd日"
            detailclassVC.classdate = selectclassdate
            detailclassVC.titleOfclass=titleofclass
            detailclassVC.youbi = selectedyoubi
            
        }
    }

    override func tableView(_ table: UITableView,didSelectRowAt indexPath: IndexPath) {
        // [indexPath.row] から画像名を探し、UImage を設定
        selectedID=nil
        let todoCollection = realm.objects(Todo.self)
        
        // Realmに保存されているTodo型のobjectsを取得。
       
        
        let todo = todoCollection.filter("date  == %@",dateOfSelectedDay ).filter("deleate  == 0").sorted(byKeyPath: "starttime", ascending: true)
        let timetableCollection = realm.objects(TimeTable.self)
        let weekday = NSCalendar.current.component(weekOfComp, from: dateOfSelectedDay)
        let youbi = weekArray[weekday]
        let timetable = timetableCollection.filter("dayOfTheWeek  == %@",youbi).filter("deleate  == 0").sorted(byKeyPath: "period", ascending: true)
        if indexPath.row < timetable.count {
            let element = timetable[indexPath.row]
            selectedtimetableID = element.id
            selectclassdate=dateOfSelectedDay as NSDate!
            titleofclass=element.title
            selectedyoubi=element.dayOfTheWeek
            performSegue(withIdentifier: "goCreateNote",sender: self.selectedID)
            
        }else{
            let element = todo[indexPath.row - timetable.count]
            selectedID = element.id
            if selectedID != nil {
                // SubViewController へ遷移するために Segue を呼び出す
                performSegue(withIdentifier: "goOneDay",sender: self.selectedID)
            }
            
            
        }
        
    }
 
   override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
           let todoCollection = realm.objects(Todo.self)
                    
                    // Realmに保存されているTodo型のobjectsを取得。
           let todo = todoCollection.filter("date  == %@",dateOfSelectedDay as NSDate).filter("deleate  == 0").sorted(byKeyPath: "starttime", ascending: true)
            
           let timetableCollection = realm.objects(TimeTable.self)
           let weekday = NSCalendar.current.component(weekOfComp, from: dateOfSelectedDay)
           let youbi = weekArray[weekday]
           let timetable = timetableCollection.filter("dayOfTheWeek  == %@",youbi).filter("deleate  == 0").sorted(byKeyPath: "period", ascending: true)
           if indexPath.row < timetable.count {
                    let element = timetable[indexPath.row]
            try! realm.write {
                element.deleate=1
            }
            }else{
                let element = todo[indexPath.row - timetable.count]
                try! realm.write {
                    element.deleate=1
                }

            }
            
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let todoCollection = realm.objects(Todo.self)
        
        // Realmに保存されているTodo型のobjectsを取得。
        let todo = todoCollection.filter("date  == %@",dateOfSelectedDay as NSDate).filter("deleate  == 0").filter("edit  == 0").sorted(byKeyPath: "starttime", ascending: true)
        let timetableCollection = realm.objects(TimeTable.self)
        let weekday = NSCalendar.current.component(weekOfComp, from: dateOfSelectedDay)
        let youbi = weekArray[weekday]
        let timetable = timetableCollection.filter("dayOfTheWeek  == %@",youbi).filter("deleate  == 0").sorted(byKeyPath: "period", ascending: true)
                return todo.count + timetable.count // 総todo数を返している
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let todoCollection = realm.objects(Todo.self)
        let timetableCollection = realm.objects(TimeTable.self)
        let weekday = NSCalendar.current.component(weekOfComp, from: dateOfSelectedDay)
        let youbi = weekArray[weekday]
        let timetable = timetableCollection.filter("dayOfTheWeek  == %@",youbi).filter("deleate  == 0").sorted(byKeyPath: "period", ascending: true)
        // Realmに保存されているTodo型のobjectsを取得。
        let noteCollection = realm.objects(Note.self)
       

        let todo = todoCollection.filter("date  == %@",dateOfSelectedDay ).filter("deleate  == 0").filter("edit  == 0").sorted(byKeyPath: "starttime", ascending: true)
      
        if indexPath.row < timetable.count {
            if timetable.count != 0   {
                let note = noteCollection.filter("timetable_id  == %@",timetableCollection.filter("dayOfTheWeek  == %@",youbi).filter("deleate  == 0").sorted(byKeyPath: "period", ascending: true)[indexPath.row].id)
                if(note.count != 0){
                let sum: Int = note.sum(ofProperty: "attendance")
                cell.textLabel?.text = timetable[indexPath.row].dayOfTheWeek + "曜 " + String(timetable[indexPath.row].period) + " 限 " + timetable[indexPath.row].title + "　出席:" + String(sum) + "回"
                }else{
                     cell.textLabel?.text = timetable[indexPath.row].dayOfTheWeek + "曜 " + String(timetable[indexPath.row].period) + " 限 " + timetable[indexPath.row].title + "　出席:0回"
                }
                 cell.textLabel?.textColor=UIColor.lightRed()
            }
            

        } else if  indexPath.row < timetable.count + todo.count {
            cell.textLabel?.text  = todo[indexPath.row - timetable.count].title+"  (開始時間:"+todo[indexPath.row - timetable.count].starttime+")"

        }
       return cell
    }
    
    


}


    


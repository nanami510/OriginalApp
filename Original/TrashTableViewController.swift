//
//  TrashTableViewController.swift
//  Original
//
//  Created by 後藤奈々美 on 2017/05/18.
//  Copyright © 2017年 litech. All rights reserved.
//

import UIKit
import RealmSwift

class TrashTableViewController: UITableViewController {
    let realm = try! Realm() //いつもの

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

   /* override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let todoCollection = realm.objects(Todo.self)
            
            // Realmに保存されているTodo型のobjectsを取得。
            let todo = todoCollection.filter("deleate  == 1").sorted(byKeyPath: "date", ascending: true)
            
            let timetableCollection = realm.objects(TimeTable.self)
            let timetable = timetableCollection.filter("deleate  == 1").sorted(byKeyPath: "period", ascending: true)
            if indexPath.row < timetable.count {
                let element = timetable[indexPath.row]
                try! realm.write {
                    element.deleate=0
                }
            }else{
                let element = todo[indexPath.row - timetable.count]
                try! realm.write {
                    element.deleate=0
                }
                
            }
            
            self.tableView.reloadData()
        }
    }*/
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "復元") { (action, index) -> Void in
            let realm = try! Realm()
            let todoCollection = realm.objects(Todo.self)
            
            // Realmに保存されているTodo型のobjectsを取得。
            let todo = todoCollection.filter("deleate  == 1").sorted(byKeyPath: "date", ascending: true)
            
            let timetableCollection = realm.objects(TimeTable.self)
            let timetable = timetableCollection.filter("deleate  == 1").sorted(byKeyPath: "period", ascending: true)
            if indexPath.row < timetable.count {
                let element = timetable[indexPath.row]
                try! realm.write {
                    element.deleate=0
                }
            }else{
                let element = todo[indexPath.row - timetable.count]
                try! realm.write {
                    element.deleate=0
                }
                
            }
        
            self.tableView.reloadData()
            
        }
        deleteButton.backgroundColor = UIColor.red
        
        return [deleteButton]
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
        let todo = todoCollection.filter("deleate  == 1").sorted(byKeyPath: "date", ascending: true)
        let timetableCollection = realm.objects(TimeTable.self)
        let timetable = timetableCollection.filter("deleate  == 1").sorted(byKeyPath: "period", ascending: true)
        return todo.count + timetable.count // 総todo数を返している
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let todoCollection = realm.objects(Todo.self)
        let timetableCollection = realm.objects(TimeTable.self)
       
        let timetable = timetableCollection.filter("deleate  == 1").sorted(byKeyPath: "period", ascending: true)
        // Realmに保存されているTodo型のobjectsを取得。
        
        let todo = todoCollection.filter("deleate  == 0").sorted(byKeyPath: "date", ascending: true)
        if indexPath.row < timetable.count {
            if timetable.count != 0   {
                cell.textLabel?.text = timetable[indexPath.row].dayOfTheWeek + "曜 " + String(timetable[indexPath.row].period) + " 限 " + timetable[indexPath.row].title
            }
            
            
        } else if  indexPath.row < timetable.count + todo.count {
            cell.textLabel?.text  = todo[indexPath.row - timetable.count].title+"  (開始時間:"+todo[indexPath.row - timetable.count].starttime+")"
            
        }
        return cell
    }

}

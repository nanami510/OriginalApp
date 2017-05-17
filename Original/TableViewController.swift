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
          //  let element = timetable[indexPath.row]
            
        }else{
            let element = todo[indexPath.row - timetable.count]
            selectedID = element.id
            if selectedID != nil {
                // SubViewController へ遷移するために Segue を呼び出す
                performSegue(withIdentifier: "goOneDay",sender: nil)
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
        let todo = todoCollection.filter("date  == %@",dateOfSelectedDay as NSDate).filter("deleate  == 0").sorted(byKeyPath: "starttime", ascending: true)
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

        let todo = todoCollection.filter("date  == %@",dateOfSelectedDay ).filter("deleate  == 0").sorted(byKeyPath: "starttime", ascending: true)
        if indexPath.row < timetable.count {
            if timetable.count != 0   {
                cell.textLabel?.text = timetable[indexPath.row].dayOfTheWeek + "曜 " + String(timetable[indexPath.row].period) + " 限 " + timetable[indexPath.row].title
            }
            

        } else if  indexPath.row < timetable.count + todo.count {
            cell.textLabel?.text  = todo[indexPath.row - timetable.count].title+"  (開始時間:"+todo[indexPath.row - timetable.count].starttime+")"

        }
       return cell
    }
    
    

 /*func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            
            // これはRealmSwiftでデータを削除しているケース
            let todoCollection = realm.objects(Todo.self)
            let todo = todoCollection.filter("date  == %@",dateOfSelectedDay ).filter("deleate  == 0").sorted(byKeyPath: "starttime", ascending: true)
            let deleteHistory = todo[indexPath.row]
            // トランザクションを開始してオブジェクトを削除します
            try! realm.write {
                deleteHistory.deleate = 1
            }
            
            
            // TableViewを再読み込み.
            self.tableView.reloadData()
            
            
        }
    }*/
}

    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    


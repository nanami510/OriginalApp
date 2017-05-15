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
    
   /* override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = try! Realm()
            let todoCollection = realm.objects(Todo.self)
            let todo = todoCollection[indexPath.row]
            try! realm.write({
                todo.deleate = 1
            })
           tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }*/
    
   /* override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if(editingStyle == UITableViewCellEditingStyle.delete) {
            do{
                let realm = try Realm()
                try realm.write {
                    let todoCollection = realm.objects(Todo.self)
                    let todo = todoCollection[indexPath.row]
                    try! realm.write({
                        todo.deleate = 1
                    })

                }
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableViewRowAnimation.fade)
            }catch{
            }
            tableView.reloadData()
        }
    }*/
   /* override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = try! Realm()
            let todoCollection = realm.objects(Todo.self)
            let todo = todoCollection[indexPath.row]
            try! realm.write({
                todo.deleate = 1
            })

            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }*/
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton: UITableViewRowAction = UITableViewRowAction(style: .normal, title: "削除") { (action, index) -> Void in
            let realm = try!Realm()
            let todo  = realm.objects(Todo.self)
            try! realm.write {
                todo[index.row].deleate = 1
            }

            
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
        let todo = todoCollection.filter("date  == %@",dateOfSelectedDay as NSDate).filter("deleate  == 0").sorted(byKeyPath: "id", ascending: true)
                return todo.count // 総todo数を返している
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let todoCollection = realm.objects(Todo.self)
        // Realmに保存されているTodo型のobjectsを取得。
        
       // dateFormat.dateFormat = "yyyy年MM月dd日"
       // let selectordate = dateFormat.date(from: selectedDay)

        let todo = todoCollection.filter("date  == %@",dateOfSelectedDay ).filter("deleate  == 0").sorted(byKeyPath: "id", ascending: true)
        if todo.count != 0   {
         cell.textLabel?.text = todo[indexPath.row].title+"  (開始時間:"+todo[indexPath.row].starttime+")"
        return cell
        } else {
            return cell
        }
    }
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
    


//
//  OneDayViewController.swift
//  
//
//  Created by 後藤奈々美 on 2017/05/16.
//
//

import UIKit
import RealmSwift


class OneDayViewController: UIViewController {
    var selectedID:Int!
    let realm = try! Realm() //いつもの
    @IBOutlet var text:UILabel!

    override func viewDidLoad() {
        
        
        let todoCollection = realm.objects(Todo.self)
        // Realmに保存されているTodo型のobjectsを取得。
        
        let todo = todoCollection.filter("id  == %@",selectedID )
       
        text.text=todo[0].title
        
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

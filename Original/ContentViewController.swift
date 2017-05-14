//
//  ContentViewController.swift
//  Original
//
//  Created by 後藤奈々美 on 2017/04/29.
//  Copyright © 2017年 litech. All rights reserved.
//
import Foundation
import UIKit
import RealmSwift
var selectedDay : String!
var dateOfSelectedDay:Date!

class realmDataSet: Object {
    
    dynamic var now = NSDate()
    dynamic var ID = String()
    dynamic var Message = String()
    dynamic var Message2 = String()
    
}


extension UIColor {
    class func lightBlue() -> UIColor {
        return UIColor(red: 92.0 / 255, green: 192.0 / 255, blue: 210.0 / 255, alpha: 1.0)
    }
    
    class func lightRed() -> UIColor {
        return UIColor(red: 195.0 / 255, green: 123.0 / 255, blue: 175.0 / 255, alpha: 1.0)
    }
}

    class ContentViewController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        
        let dateManager = DateManager()
        let daysPerWeek: Int = 7
        let cellMargin: CGFloat = 2.0
        var selectedDate = Date()
        var today: Date!
        let weekArray = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
        var selectDate:String?

        
        
        @IBOutlet weak var headerPrevBtn: UIButton!
        @IBOutlet weak var headerNextBtn: UIButton!
        @IBOutlet weak var headerTitle: UILabel!
        @IBOutlet weak var calenderHeaderView: UIView!
        @IBOutlet weak var calenderCollectionView: UICollectionView!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            calenderCollectionView.delegate = self
            calenderCollectionView.dataSource = self
            calenderCollectionView.backgroundColor = UIColor.white
            calenderCollectionView.reloadData()
            // 🔴修正前 (date: selectedDate)
            headerTitle.text = changeHeaderTitle()
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        //1
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 2
        }
        //2
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            // Section毎にCellの総数を変える.
            if section == 0 {
                return 7
            } else {
                return dateManager.daysAcquisition() //ここは月によって異なる(後ほど説明します)
            }
        }
        //3
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! CalenderCellCollectionViewCell
           
            if (indexPath.row % 7 == 0) {
                cell.textLabel.textColor = UIColor.lightRed()
                cell.textWeekLabel.textColor = UIColor.lightRed()
            } else if (indexPath.row % 7 == 6) {
                cell.textLabel.textColor = UIColor.lightBlue()
                cell.textWeekLabel.textColor = UIColor.lightBlue()
            } else {
                cell.textLabel.textColor = UIColor.gray
                cell.textWeekLabel.textColor = UIColor.gray
            }
            //テキスト配置
            if indexPath.section == 0 {
                cell.textWeekLabel.text = weekArray[indexPath.row]
                
            } else {
                cell.textLabel.text = dateManager.conversionDateFormat(indexPath: indexPath)
                let formatterYear: DateFormatter = DateFormatter()
                formatterYear.dateFormat="yyyy"
                let formatterMonth: DateFormatter = DateFormatter()
                formatterMonth.dateFormat="M"
                let calendar = Calendar(identifier: .gregorian)
                let serchday = calendar.date(from: DateComponents(year: Int(formatterYear.string(from:selectedDate)), month:  Int(formatterMonth.string(from:selectedDate)), day:Int(dateManager.conversionDateFormat(indexPath: indexPath)) ))
                let realm = try! Realm()
                let todoCollection = realm.objects(Todo.self)
                
                // Realmに保存されているTodo型のobjectsを取得。
                let todo = todoCollection.filter("date  == %@",serchday!).filter("deleate  == 0")
                 if todo.count > 1 {
                    cell.textTitleLabel.text = todo[0].title
                    cell.textTitle2Label.text = todo[1].title
                } else if todo.count != 0 {
                    cell.textTitleLabel.text = todo[0].title
                }
                //月によって1日の場所は異なる
            }
            return cell
        }
        
        
        //セルのサイズを設定
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let numberOfMargin: CGFloat = 8.0
            let width: CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin) / CGFloat(daysPerWeek)
            let height: CGFloat = width * 1.0
            // 🔴修正前 CGSizeMake(width, height)
            return CGSize(width: width, height: height)
        }
        //セルの垂直方向のマージンを設定
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return cellMargin
        }
        
        //セルの水平方向のマージンを設定
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return cellMargin
        }
        
        func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath: IndexPath){
            // [indexPath.row] から画像名を探し、UImage を設定
            selectDate = dateManager.conversionDateFormat(indexPath: indexPath)
            dateOfSelectedDay=selectedDate
            if selectDate !=  "" {
                // SubViewController へ遷移するために Segue を呼び出す
               // let formatter: DateFormatter = DateFormatter()
             //   formatter.dateFormat = "yyyy年M月"
                let formatterYear: DateFormatter = DateFormatter()
                formatterYear.dateFormat="yyyy"
                let formatterMonth: DateFormatter = DateFormatter()
                formatterMonth.dateFormat="M"
                let calendar = Calendar(identifier: .gregorian)
                dateOfSelectedDay=calendar.date(from: DateComponents(year: Int(formatterYear.string(from:selectedDate)), month:  Int(formatterMonth.string(from:selectedDate)), day:Int(selectDate!) ))
                //selectedDay = formatter.string(from: selectedDate) + selectDate!+"日"
                performSegue(withIdentifier: "toTableViewController",sender: nil)
                
                
            }
            
                   }
        
               
        //headerの月を変更
        // 🔴修正前 (date: NSDate)
        func changeHeaderTitle() -> String {
            let formatter: DateFormatter = DateFormatter()
            //let formatter = DateFormatter() // 🔴これでもOKです
            formatter.dateFormat = "yyyy年M月"
            // 🔴修正前 formatter.string(from: date as Date)
            let selectMonth = formatter.string(from: selectedDate)
            return selectMonth
        }
        
        //①タップ時
        // 🔴修正前 (sender: UIButton)
        @IBAction func tappedHeaderPrevBtn(_ sender: UIButton) {
            // 🔴修正前 (selectedDate)
            selectedDate = dateManager.prevMonth(date: selectedDate)
            calenderCollectionView.reloadData()
            // 🔴修正前 (date: selectedDate)
            headerTitle.text = changeHeaderTitle()
        }
        //②タップ時
        // 🔴修正前 (sender: UIButton)
        @IBAction func tappedHeaderNextBtn(_ sender: UIButton) {
            // 🔴修正前 (selectedDate)
            selectedDate = dateManager.nextMonth(date: selectedDate)
            calenderCollectionView.reloadData()
            // 🔴修正前 (date: selectedDate)
            headerTitle.text = changeHeaderTitle()
        }
        
        @IBAction func onTouchBootMenuButton(sender: UIButton) {
            guard let rootViewController = rootViewController() else { return }
            rootViewController.presentMenuViewController()
        }
        
        @IBAction func onTouchCloseMenuButton(sender: UIButton) {
            guard let rootViewController = rootViewController() else {return }
            rootViewController.dismissMenuViewController()
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

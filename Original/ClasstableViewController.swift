//
//  ClasstableViewController.swift
//  Original
//
//  Created by 後藤奈々美 on 2017/05/14.
//  Copyright © 2017年 litech. All rights reserved.
//

import UIKit
import RealmSwift

class ClasstableViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
     let weekArray = ["Period","Mon","Tue","Wed","Thu","Fri","Sat"]
    
     let cellMargin: CGFloat = 2.0
     @IBOutlet weak var classtableCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    //2
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Section毎にCellの総数を変える.
        if section == 0 {
            return 7
        } else {
            return 49
        }
    }
    //3
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! ClasstableCollectionViewCell
        
        if (indexPath.row % 7 == 0) {
            cell.textLabel.textColor = UIColor.lightRed()
        }
        //テキスト配置
        if indexPath.section == 0 {
            cell.textWeekLabel.text = weekArray[indexPath.row]
            cell.textLabel.text = ""
        } else {
            cell.textWeekLabel.text = ""
            cell.textLabel.text = "aiueokakikukeko"
            let realm = try! Realm()
            let timetableCollection = realm.objects(TimeTable.self)
            /*
            // Realmに保存されているTodo型のobjectsを取得。
            let timetable = timetableCollection.filter("date  == %@",serchday!).filter("deleate  == 0")
            if todo.count > 1 {
                cell.textTitleLabel.text = todo[0].title
                cell.textTitle2Label.text = todo[1].title
            } else if todo.count != 0 {
                cell.textTitleLabel.text = todo[0].title
            }
            //月によって1日の場所は異なる*/
        }
        return cell
    }
    
    
    //セルのサイズを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfMargin: CGFloat = 8.0
        let width: CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin) / CGFloat(7)
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
    
  /*  func collectionView(_ collectionView:UICollectionView, didSelectItemAt indexPath: IndexPath){
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
 
        
    }*/


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

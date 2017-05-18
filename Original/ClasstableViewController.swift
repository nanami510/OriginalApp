//
//  ClasstableViewController.swift
//  Original
//
//  Created by 後藤奈々美 on 2017/05/14.
//  Copyright © 2017年 litech. All rights reserved.
//
extension UIView {
    
    enum BorderPosition {
        case Top
        case Right
        case Bottom
        case Left
    }
    
    func border(borderWidth: CGFloat, borderColor: UIColor?, borderRadius: CGFloat?) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor?.cgColor
        if let _ = borderRadius {
            self.layer.cornerRadius = borderRadius!
        }
        self.layer.masksToBounds = true
    }
    
    func border(positions: [BorderPosition], borderWidth: CGFloat, borderColor: UIColor?) {
        
        let topLine = CALayer()
        let leftLine = CALayer()
        let bottomLine = CALayer()
        let rightLine = CALayer()
        
        self.layer.sublayers = nil
        self.layer.masksToBounds = true
        
        if let _ = borderColor {
            topLine.backgroundColor = borderColor!.cgColor
            leftLine.backgroundColor = borderColor!.cgColor
            bottomLine.backgroundColor = borderColor!.cgColor
            rightLine.backgroundColor = borderColor!.cgColor
        } else {
            topLine.backgroundColor = UIColor.white.cgColor
            leftLine.backgroundColor = UIColor.white.cgColor
            bottomLine.backgroundColor = UIColor.white.cgColor
            rightLine.backgroundColor = UIColor.white.cgColor
        }
        
        if positions.contains(.Top) {
            topLine.frame = CGRect(x:0.0, y:0.0, width:self.frame.width, height:borderWidth)
            self.layer.addSublayer(topLine)
        }
        if positions.contains(.Left) {
            leftLine.frame = CGRect(x:0.0,y: 0.0, width:borderWidth,height: self.frame.height)
            self.layer.addSublayer(leftLine)
        }
        if positions.contains(.Bottom) {
            bottomLine.frame = CGRect(x:0.0,y: self.frame.height - borderWidth, width:self.frame.width, height:borderWidth)
            self.layer.addSublayer(bottomLine)
        }
        if positions.contains(.Right) {
            rightLine.frame = CGRect(x:self.frame.width - borderWidth, y:0.0,width: borderWidth, height:self.frame.height)
            self.layer.addSublayer(rightLine)
        }
        
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let _ = self.layer.borderColor {
                return UIColor(cgColor: self.layer.borderColor!)
            }
            return nil
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
}

import UIKit
import RealmSwift

class ClasstableViewController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let realm = try! Realm() //いつもの
    let daysPerWeek: Int = 7
    let cellMargin: CGFloat = 2.0
    
    
    let weekArray = ["限","月","火","水","木","金","土"]
    
    
    
    
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CollectionView.delegate = self
        CollectionView.dataSource = self
        CollectionView.backgroundColor = UIColor.white
        CollectionView.reloadData()
        // 🔴修正前 (date: selectedDate)
        
        
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
            return 49
        }
    }
    //3
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as! ClasstableCollectionViewCell
        
        if (indexPath.row % 7 == 0) {
            cell.textLabel.textColor = UIColor.lightRed()
            cell.textWeekLabel.textColor = UIColor.lightRed()
        } else {
            cell.textLabel.textColor = UIColor.gray
            cell.textWeekLabel.textColor = UIColor.gray
        }
        //テキスト配置
        if indexPath.section == 0 {
            cell.textWeekLabel.text = weekArray[indexPath.row]
            cell.textLabel.text=""
            
        } else {
            
            cell.textLabel.text=""
            if (indexPath.row % 7 == 0) {
            cell.textWeekLabel.text = String(indexPath.row / 7 )
            } else  {
               let timetableCollection = realm.objects(TimeTable.self)
                let youbi = weekArray[indexPath.row % 7]
                var periodserch:Int!
                    periodserch = ( ( indexPath.row - ( indexPath.row % 7 ) ) / 7 )
                let timetable = timetableCollection.filter("dayOfTheWeek  == %@",youbi).filter("deleate  == 0").filter("period  == %@",periodserch)
                if timetable.count != 0{
                cell.textWeekLabel.text = timetable[0].title
                }
            }
            
           
        }
        cell.textWeekLabel.border(positions:[.Top,.Left,.Right,.Bottom],borderWidth:1,borderColor:UIColor.black)
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
    @IBAction func onTouchBootMenuButton(_ sender: UIButton) {
        guard let rootViewController = rootViewController() else { return }
        rootViewController.presentMenuViewController()
    }
    
    
        //3
    /* func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor.cyan
     
     
     
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
            
            
        }*/
 
        
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

//
//  DateManager.swift
//  Original
//
//  Created by 後藤奈々美 on 2017/04/29.
//  Copyright © 2017年 litech. All rights reserved.
//

import UIKit

extension Date {
    // 🔴修正前 -> NSDate
    func monthAgoDate() -> Date {
        let addValue = -1
        // 🔴修正前 = NSCalendar.currentCalendar()
        let calendar = Calendar.current
        // 🔴修正前 let dateComponents = DateComponents()
        var dateComponents = DateComponents()
        dateComponents.month = addValue
        // 🔴修正前 return calendar.dateByAddingComponents(dateComponents, toDate: self, options: NSCalendarOptions(rawValue: 0))!
        return calendar.date(byAdding: dateComponents, to: self)!
    }
    // 🔴修正前 -> NSDate
    func monthLaterDate() -> Date {
        let addValue: Int = 1
        // 🔴修正前 = NSCalendar.currentCalendar()
        let calendar = Calendar.current
        // 🔴修正前 let dateComponents = DateComponents()
        var dateComponents = DateComponents()
        dateComponents.month = addValue
        
        // 🔴修正前 return calendar.dateByAddingComponents(dateComponents, toDate: self, options: NSCalendarOptions(rawValue: 0))!
        return calendar.date(byAdding: dateComponents, to: self)!
    }
}

class DateManager: NSObject {
    
    var currentMonthOfDates = [NSDate]() //表記する月の配列
    // 🔴修正前 NSDate()
    var selectedDate = Date()
    let daysPerWeek: Int = 7
    // 🔴修正前 Int!
    var numberOfItems: Int! = 0 //セルの個数 nilが入らないようにする
    
    //月ごとのセルの数を返すメソッド
    func daysAcquisition() -> Int {
        // 🔴修正前 NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.WeekOfMonth, inUnit: NSCalendarUnit.Month, forDate: firstDateOfMonth())
        let rangeOfWeeks = Calendar.current.range(of: .weekOfMonth, in: .month, for: firstDateOfMonth() as Date)
        
        // 🔴修正前 rangeOfWeeks.length
        let numberOfWeeks = Int((rangeOfWeeks?.count)!) //月が持つ週の数
        numberOfItems = numberOfWeeks * daysPerWeek //週の数×列の数
        return numberOfItems
    }
    //月の初日を取得
    func firstDateOfMonth() -> Date {
        // 🔴修正前 let components = NSCalendar.currentCalendar().components([.Year, .Month, .Day], fromDate: selectedDate)
        var components = Calendar.current.dateComponents([.year, .month, .day], from:selectedDate)
        components.day = 1
        // 🔴修正前 NSCalendar.currentCalendar().dateFromComponents(components)!
        let firstDateMonth = Calendar.current.date(from: components)!
        return firstDateMonth
    }
    
    // ⑴表記する日にちの取得
    func dateForCellAtIndexPath(numberOfItem: Int) {
        // ①「月の初日が週の何日目か」を計算する
        // 🔴修正前 NSCalendar.currentCalendar().ordinalityOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.WeekOfMonth, forDate: firstDateOfMonth())
        let ordinalityOfFirstDay = Calendar.current.ordinality(of: .day, in: .weekOfMonth, for: firstDateOfMonth())
        // 🔴修正前 for var i = 0; i < numberOfItems; i++ {
        for i in 0 ..< numberOfItems {
            // ②「月の初日」と「indexPath.item番目のセルに表示する日」の差を計算する
            var dateComponents = DateComponents()
            // 🔴修正前 (ordinalityOfFirstDay - 1)
            dateComponents.day = i - (ordinalityOfFirstDay! - 1)
            // ③ 表示する月の初日から②で計算した差を引いた日付を取得
            // 🔴修正前 NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: firstDateOfMonth(), options: NSCalendarOptions(rawValue: 0))!
            let date = Calendar.current.date(byAdding: dateComponents as DateComponents, to: firstDateOfMonth() as Date)!
            // ④配列に追加
            // 🔴修正前 (date)
            currentMonthOfDates.append(date as NSDate)
        }
    }
    
    // ⑵表記の変更
    // 🔴修正前 (indexPath: NSIndexPath)
    func conversionDateFormat(indexPath: IndexPath) -> String {
        // 🔴修正前 (numberOfItems)
        dateForCellAtIndexPath(numberOfItem: numberOfItems)
        // 🔴修正前 NSDateFormatter = NSDateFormatter()
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "d"
        // 🔴修正前 return formatter.stringFromDate(currentMonthOfDates[indexPath.row])
        return formatter.string(from: currentMonthOfDates[indexPath.row] as Date)
    }
    
    //前月の表示
    // 🔴修正前 (date: NSDate) -> NSDate
    func prevMonth(date: Date) -> Date {
        currentMonthOfDates = []
        selectedDate = date.monthAgoDate()
        return selectedDate
    }
    
    //次月の表示
    // 🔴修正前 (date: NSDate) -> NSDate
    func nextMonth(date: Date) -> Date {
        currentMonthOfDates = []
        selectedDate = date.monthLaterDate()
        return selectedDate
    }
}

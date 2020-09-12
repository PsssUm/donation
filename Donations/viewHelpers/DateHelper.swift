//
//  DateHelper.swift
//  Donations
//
//  Created by spbiphones on 11.09.2020.
//  Copyright © 2020 mountainheads. All rights reserved.
//

import Foundation
class DateHelper {
   static func transformTimeIntervalToDate(interval : Double) -> String{
        let date = Date(timeIntervalSince1970: interval)
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd.MM.YYYY"
        
        let dateString = dayTimePeriodFormatter.string(from: date)
        return dateString
    }
   static func transformTimeIntervalToHoursMinutes(interval : Double) -> String{
        let date = Date(timeIntervalSince1970: interval)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "HH:mm"
        let dateString = dayTimePeriodFormatter.string(from: date)
        return dateString
    }
   static func transformTimeToHumanReadable(interval : Double) -> String{
        let now = Date(timeIntervalSince1970: interval)
//        let dateFormatter = DateFormatter()
//        dateFormatter.doesRelativeDateFormatting = true
//        dateFormatter.dateStyle = .medium
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "dd MMMM"
        
        let time = "\(timeFormatter.string(from: now))"
        return time
    }
    func timeStampToDay(timeStampInSecond:Double) -> Int {
        let date = Date()
        let todaysDateStamp = date.timeIntervalSince1970
        let timeStampDate = Date(timeIntervalSince1970: timeStampInSecond)
        var secBetween = Date(timeIntervalSince1970: todaysDateStamp).timeIntervalSince(timeStampDate)
        return Int(abs(secBetween - 86400) / 86400)
    }
   static func transformTimeToSectionHeader(interval : Double) -> String{
        let date = Date(timeIntervalSince1970: interval)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd MMMM, HH:mm"
        let dateString = dayTimePeriodFormatter.string(from: date)
        return dateString
    }
  static  func compareDates3Day(timeIntervalSince1970 : Double) -> Bool{
        if timeIntervalSince1970 > 0 {
            return Date() >= Date(timeIntervalSince1970: timeIntervalSince1970)
        } else {
            return false
        }
    }
}

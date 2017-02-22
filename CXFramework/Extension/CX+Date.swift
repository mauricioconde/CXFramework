//
//  CX+Date.swift
//  CXFramework
//
//  Created by Mauricio Conde on 15/02/17.
//  Copyright © 2017 Mauricio Conde Xinastle. All rights reserved.
//

import Foundation


public extension Date {
    /// Modifies the hours, minutes and seconds of this NSDate
    /// - return: A new NSDate with the hours, minutes & seconds specified
    func dateWith(hour: Int, minute: Int, seconds: Int) -> Date{
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self as Date)
        components.hour = hour
        components.minute = minute
        components.second = seconds
        return calendar.date(from: components)!
    }
    
    static func dateFromMilliseconds(ms: String) -> Date {
        return Date(timeIntervalSince1970: Double(ms)! / 1000.0)
    }
    
    func toMillisAsString() -> String{
        return String(Int64(timeIntervalSince1970 * 1000))
    }
    
    /// Returns a date as milliseconds from a date expresed
    /// in the format 'yyyy-MM-dd'
    static func toMillisFromDateFormat(format: String) -> String?{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: format){
            return date.toMillisAsString()
        }
        return nil
    }
    
    /// Returns a date as milliseconds from a date expresed
    /// in a specifc format
    static func toMillisFromDateFormat(date: String,
                                       format: String,
                                       andTimeZone timeZone: String) -> String?{
        let formatter = DateFormatter()
        let timezone = NSTimeZone(name: timeZone)
        formatter.timeZone = timezone as TimeZone!
        formatter.dateFormat = format
        if let date = formatter.date(from: date){
            return date.toMillisAsString()
        }
        return nil
    }
    
    /// Returns a date with the format 'dd-MMM-yyyy' from a string
    /// representing a date in milliseconds
    static func formatDateFromMillis(millis: String) -> String{
        let date = Date.dateFromMilliseconds(ms: millis)
        
        let formatter = DateFormatter()
        let timeZone = NSTimeZone(name: "UTC")
        formatter.timeZone = timeZone as TimeZone!
        formatter.dateFormat = "dd-MMM-yyyy"
        return formatter.string(from: date)
    }
    
    /// Returns a date with the format 'dd-MMM-yyyy' from a date
    func formatFromDate() -> String{
        let dateFormatter = DateFormatter()
        let timeZone = NSTimeZone(name: "UTC")
        dateFormatter.timeZone = timeZone as TimeZone!
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        
        return String(dateFormatter.string(from: self))
    }
    
    /// Returns a date with the format specified
    func toFormatDate(format: String) -> String{
        let dateFormatter = DateFormatter()
        let timeZone = NSTimeZone(name: "UTC")
        dateFormatter.timeZone = timeZone as TimeZone!
        dateFormatter.dateFormat = format
        
        return String(dateFormatter.string(from: self))
    }
    
    /// Compares two dates by day
    func isGreaterThan(date: Date) -> Bool{
        let order = Calendar
            .current
            .compare(self,
                     to: date,
                     toGranularity: .day)
        
        switch order {
        case .orderedDescending:
            return true
        case .orderedAscending:
            return false
        case .orderedSame:
            return false
        }
    }
    
    func isGreaterThanDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isGreater = false
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(dateToCompare: Date) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == ComparisonResult.orderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func addDays(daysToAdd: Int) -> Date {
        let secondsInDays: TimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: Date = self.addingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func addHours(hoursToAdd: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
    
    func yearsFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.year], from: date, to: self)
        return components.year!
    }
    func monthsFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.month], from: date, to: self)
        return components.month!
    }
    func weeksFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.weekday], from: date, to: self)
        return components.weekday!
    }
    func daysFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: date, to: self)
        return components.day!
    }
    func hoursFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.hour], from: date, to: self)
        return components.hour!
    }
    func minutesFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.minute], from: date, to: self)
        return components.minute!
    }
    func secondsFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.second], from: date, to: self)
        return components.second!
    }
    
    func dateFrom(date: Date) -> DateComponents{
        let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
        let unitFlags: Set<Calendar.Component> = [.year, .month, .day]
        let components = gregorian.dateComponents(unitFlags, from: date, to: self)
        /*
        let years = components.year
        let months = components.month
        let days = components.day
        */
        
        return components
    }
}

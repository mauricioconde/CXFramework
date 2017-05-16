//
//  CX+Date.swift
//  CXFramework
//
//  Created by Mauricio Conde on 15/02/17.
//  Copyright © 2017 Mauricio Conde Xinastle. All rights reserved.
//

import Foundation


public extension Date {
    
    // MARK:- Computing variables
    /// Returns the corresponding **Date representation** in milliseconds
    public var cx_toMillisAsStr: String {
        return String(Int64(timeIntervalSince1970 * 1000))
    }
    
    
    
    // MARK:- Instance methods
    /// Modifies the **hours, minutes and seconds** of this Date
    /// - return: A new Date with the hours, minutes & seconds specified
    public func cx_dateWith(hours: Int, minutes: Int, seconds: Int) -> Date{
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self as Date)
        components.hour = hours
        components.minute = minutes
        components.second = seconds
        return calendar.date(from: components)!
    }
    
    /// Returns true if this date is greater thant the other one
    public func cx_isGreaterThan(date: Date) -> Bool {
        return self.compare(date) == .orderedDescending
    }
    
    /// Returns true if this date is less thant the other one
    public func cx_isLessThan(date: Date) -> Bool {
        return self.compare(date) == .orderedAscending
    }
    
    /// Returns true if both dates are equals
    public func cx_isEqualTo(date: Date) -> Bool {
        return self.compare(date) == .orderedSame
    }
    
    /// Returns a new date with the **days added**
    public func cx_add(days: Int) -> Date {
        let secondsInDays: TimeInterval = Double(days) * 60 * 60 * 24
        let dateWithDaysAdded: Date = self.addingTimeInterval(secondsInDays)
        return dateWithDaysAdded
    }
    
    /// Returns a new date with the **hours added**
    public func cx_add(hours: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hours) * 60 * 60
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)
        return dateWithHoursAdded
    }
    
    /// Returns a date expressing the **time interval from date to self**
    public func cx_dateFrom(date: Date) -> DateComponents {
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
    
    /// Returns the number of years from `date` to **self**
    public func cx_yearsFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.year], from: date, to: self)
        return components.year!
    }
    
    /// Returns the number of months from `date` to **self**
    public func cx_monthsFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.month], from: date, to: self)
        return components.month!
    }
    
    /// Returns the number of weeks from `date` to **self**
    public func cx_weeksFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.weekday], from: date, to: self)
        return components.weekday!
    }
    
    /// Returns the number of days from `date` to **self**
    public func cx_daysFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: date, to: self)
        return components.day!
    }
    
    /// Returns the number of hours from `date` to **self**
    public func cx_hoursFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.hour], from: date, to: self)
        return components.hour!
    }
    
    /// Returns the number of minutes from `date` to **self**
    public func cx_minutesFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.minute], from: date, to: self)
        return components.minute!
    }
    
    /// Returns the number of seconds from `date` to **self**
    public func cx_secondsFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.second], from: date, to: self)
        return components.second!
    }
    
    
    
    // MARK:- Static funtions
    /// Returns a **Date** corresponding to the specified millisecods
    public static func cx_dateFromMilliseconds(ms: String) -> Date {
        return Date(timeIntervalSince1970: Double(ms)! / 1000.0)
    }
    
    /// Returns a **milliseconds representation** from a date expresed in a specifc format
    public static func cx_toMillisFrom(date: String,
                                       withFormat format: String,
                                       andTimeZoneID timeZoneID: String? = nil) -> String? {
        let formatter = DateFormatter()
        if let tzID = timeZoneID {
            formatter.timeZone = NSTimeZone(name: tzID) as TimeZone!
        }
        formatter.dateFormat = format
        if let date = formatter.date(from: date) {
            return date.cx_toMillisAsStr
        }
        return nil
    }
    
    /// Returns a **date representation** with a format 
    /// from a string representing a date in milliseconds
    public static func cx_toFormatedDateFrom(millis: String,
                                             withFormat format: String,
                                             andTimeZoneID timeZoneID: String? = nil) -> String {
        let date = Date.cx_dateFromMilliseconds(ms: millis)
        
        let formatter = DateFormatter()
        if let tzID = timeZoneID {
            formatter.timeZone = NSTimeZone(name: tzID) as TimeZone! // "UTC"
        }
        formatter.dateFormat = format   // "dd/mm/yyyy"
        return formatter.string(from: date)
    }
}

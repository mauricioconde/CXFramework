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
    /// The date year
    var cxYear: Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: Timezone.utc.rawValue)!
        
        return calendar.component(.year, from: self)
    }
    
    /// The date month
    var cxMonth: Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: Timezone.utc.rawValue)!
        
        return calendar.component(.month, from: self)
    }
    
    /// The date day
    var cxDay: Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: Timezone.utc.rawValue)!
        
        return calendar.component(.day, from: self)
    }
    
    /// The date weekday
    var cxWeekday: Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: Timezone.utc.rawValue)!
        
        return calendar.component(.weekday, from: self)
    }
    
    // The date hour
    var cxHours: Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: Timezone.utc.rawValue)!
        
        return calendar.component(.hour, from: self)
    }
    
    /// The date minutes
    var cxMinutes: Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: Timezone.utc.rawValue)!
        
        return calendar.component(.minute, from: self)
    }
    
    /// Returns the corresponding **Date representation** in milliseconds
    var cx_toMillisAsStr: String {
        return String(Int64(timeIntervalSince1970 * 1000))
    }
    
    /// Returns the total month days of the date
    var cxTotalMonthDays: Int {
        var totalDays = 0
        var calendar = Calendar.current
        
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        if #available(iOS 10.0, *) {
            let interval = calendar.dateInterval(of: .month, for: self)!
            totalDays = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
        } else {
            totalDays = calendar.range(of: .day, in: .month, for: self)!.upperBound
        }
        
        return totalDays
    }
    
    // MARK:- Instance methods
    /// Modifies the **hours, minutes and seconds** of this Date
    /// - return: A new Date with the hours, minutes & seconds specified
    func cx_dateWith(hours: Int, minutes: Int, seconds: Int) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self as Date)
        components.hour = hours
        components.minute = minutes
        components.second = seconds
        return calendar.date(from: components)!
    }
    
    /// Modifies the **hours, minutes and seconds** of this Date
    /// - return: A new Date with the hours, minutes & seconds specified
    mutating func cxModify(hour: Int, minutes: Int, seconds: Int) {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self as Date)
        components.hour = hour
        components.minute = minutes
        components.second = seconds
        self = calendar.date(from: components)!
    }
    
    /// Returns true if this date is greater thant the other one
    func cxIsGreaterThan(date: Date) -> Bool {
        return self.compare(date) == .orderedDescending
    }
    
    /// Returns true if this date is less thant the other one
    func cxIsLessThan(date: Date) -> Bool {
        return self.compare(date) == .orderedAscending
    }
    
    /// Returns true if both dates are equals
    func cxIbsEqualTo(date: Date) -> Bool {
        return self.compare(date) == .orderedSame
    }
    
    /// Returns a new date with the **days added**
    func cx_add(days: Int) -> Date {
        let secondsInDays: TimeInterval = Double(days) * 60 * 60 * 24
        let dateWithDaysAdded: Date = self.addingTimeInterval(secondsInDays)
        return dateWithDaysAdded
    }
    
    /// Returns a new date with the **hours added**
    func cx_add(hours: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hours) * 60 * 60
        let dateWithHoursAdded: Date = self.addingTimeInterval(secondsInHours)
        return dateWithHoursAdded
    }
    
    /// Returns a new date with the **minutes added**
    func cxAdd(minutes: Int) -> Date {
        let secondsInMinutes: TimeInterval = Double(minutes) * 60
        let dateWithMinutesAdded: Date = self.addingTimeInterval(secondsInMinutes)
        return dateWithMinutesAdded
    }
    
    /// Returns a date expressing the **time interval from date to self**
    func cx_dateFrom(date: Date) -> DateComponents {
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
    func cx_yearsFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.year], from: date, to: self)
        return components.year!
    }
    
    /// Returns the number of months from `date` to **self**
    func cx_monthsFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.month], from: date, to: self)
        return components.month!
    }
    
    /// Returns the number of weeks from `date` to **self**
    func cx_weeksFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.weekday], from: date, to: self)
        return components.weekday!
    }
    
    /// Returns the number of days from `date` to **self**
    func cx_daysFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.day], from: date, to: self)
        return components.day!
    }
    
    /// Returns the number of hours from `date` to **self**
    func cx_hoursFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.hour], from: date, to: self)
        return components.hour!
    }
    
    /// Returns the number of minutes from `date` to **self**
    func cx_minutesFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.minute], from: date, to: self)
        return components.minute!
    }
    
    /// Returns the number of seconds from `date` to **self**
    func cx_secondsFrom(date:Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([Calendar.Component.second], from: date, to: self)
        return components.second!
    }
    
    /// Returns a localized date format string representing the date
    func localizedDate(localeID id: String) -> String {
        let dateFormatter = DateFormatter()
        let format = DateFormatter.dateFormat(fromTemplate: "dMMMMyyyy",
                                              options:0,
                                              locale: NSLocale(localeIdentifier: "pt_BR") as Locale)
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    // MARK:- Static funtions
    
    /// Returns a new date in **UTC time zone** with the current device hour
    static func cxNewInstance() -> Date {
        let now = Date()
        let dateFormatter = DateFormatter()
        let dateFormat = "yyyy.MM.dd HH:mm:ss"
        
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = dateFormat
        let dateStr = dateFormatter.string(from: now)
        
        // UTC is the default time zone
        dateFormatter.timeZone = TimeZone(abbreviation: Timezone.utc.rawValue)
        return dateFormatter.date(from: dateStr)!
    }
    
    /// Returns a new **date instance** in **UTC timeZone** from specific year, month & day
    static func cxNewDate(fromYear year: Int, month: Int, day: Int) -> Date? {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(abbreviation: Timezone.utc.rawValue)!
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        
        return calendar.date(from: dateComponents)
    }
    
    /// Returns a **Date** corresponding to the specified millisecods
    static func cx_dateFromMilliseconds(ms: String) -> Date {
        return Date(timeIntervalSince1970: Double(ms)! / 1000.0)
    }
    
    /// Returns a **date** from a date expresed in a specifc format
    static func cxDateFrom(string: String, withFormat format: String) -> Date? {
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone(abbreviation: Timezone.utc.rawValue)!
        formatter.dateFormat = format
        
        if let date = formatter.date(from: string) {
            return date
        }
        
        return nil
    }
    
    /// Returns a **milliseconds representation** from a date expresed in a specifc format
    static func cx_toMillisFrom(date: String,
                                       withFormat format: String,
                                       andTimeZoneID timeZoneID: String? = nil) -> String? {
        let formatter = DateFormatter()
        if let tzID = timeZoneID {
            formatter.timeZone = TimeZone(identifier: tzID)
        }
        formatter.dateFormat = format
        if let date = formatter.date(from: date) {
            return date.cx_toMillisAsStr
        }
        return nil
    }
    
    /// Returns a **date representation** with a format
    /// from a string representing a date in milliseconds
    static func cxToFormatedDateFrom(millis: String,
                                             withFormat format: String,
                                             andTimeZoneAbbreviation abbreviation: String? = nil) -> String {
        let date = Date.cx_dateFromMilliseconds(ms: millis)
        
        let formatter = DateFormatter()
        if let tzID = abbreviation {
            formatter.timeZone = TimeZone(abbreviation: tzID)
        } else {
            formatter.timeZone = TimeZone(abbreviation: "UTC")
        }
        formatter.dateFormat = format   // "dd/mm/yyyy"
        return formatter.string(from: date)
    }
    
    /// Returns a **date representation** with a format 
    /// from a string representing a date in milliseconds
    static func cx_toFormatedDateFrom(millis: String,
                                             withFormat format: String,
                                             andTimeZoneID timeZoneID: String? = nil) -> String {
        let date = Date.cx_dateFromMilliseconds(ms: millis)
        
        let formatter = DateFormatter()
        if let tzID = timeZoneID {
            formatter.timeZone = TimeZone(identifier: tzID) // "UTC"
        }
        formatter.dateFormat = format   // "dd/mm/yyyy"
        return formatter.string(from: date)
    }
    
    /// Returns a **date representation** with a format
    func cxToFormat(_ format: String, withTimeZoneID ab: String = Timezone.utc.rawValue) -> String {
        let dateFormatter = DateFormatter()
        
        let timeZone = TimeZone(abbreviation: ab)
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = format
        
        return String(dateFormatter.string(from: self))
    }
    
    // MARK:- Keys
    enum Timezone: String {
        case utc = "UTC"
    }
}

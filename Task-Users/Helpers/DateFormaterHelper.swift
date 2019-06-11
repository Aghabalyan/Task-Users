//
//  DateFormaterHelper.swift
//  Task-Users
//
//  Created by Grigor Aghabalyan on 6/11/19.
//  Copyright © 2019 Grigor Aghabalyan. All rights reserved.
//

import Foundation

enum DateFormat: String {
    case ShortDate = "MM/dd/yyyy"
    case LongDate = "MMMM dd, yyyy"
    case EventClientDate = "dd MMMM yyyy"
    case ShortTime = "HH.mm"
    case ShortDataRevers = "dd/MM/yy"
    case HoursAndSeconds = "HH:mm"
    case StandartDate = "yyyy-MM-dd"
    case specific = "d MMM yyyy"
}

enum DateFormatterFormats: String {
    case long = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    case middle = "yyyy-MM-dd'T'HH:mm:ss"
    case short = "yyyy-MM-dd"
}

class DateFormattingHelper {
    
    static private let formatter = DateFormatter()
    
    static let formatterForParse = { (_ format: DateFormatterFormats ) -> DateFormatter in
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter
    }
    
    static func stringFrom(date: Date?, format: DateFormat) -> String {
        guard let date = date else {
            return ""
        }
        formatter.dateFormat = format.rawValue
        return formatter.string(from: date)
    }
    
    static func dateFrom(string: String, format: DateFormat) -> Date {
        formatter.dateFormat = format.rawValue
        return formatter.date(from: string) ?? Date()
    }
}

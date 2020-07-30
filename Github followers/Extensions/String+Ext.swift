//
//  String+Ext.swift
//  Github followers
//
//  Created by rs on 30.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import Foundation

extension String {
    
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from: self)
    }
    
    func convertToMonthDay() -> String? {
        let date = self.convertToDate()
        return date?.convertToMonthYearString()
    }
}

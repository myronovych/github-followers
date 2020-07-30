//
//  Date+Ext.swift
//  Github followers
//
//  Created by rs on 30.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import Foundation

extension Date {
    func convertToMonthYearString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"
        return dateFormatter.string(from: self)
    }
}

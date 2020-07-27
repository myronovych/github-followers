//
//  ErrorMessages.swift
//  Github followers
//
//  Created by rs on 27.07.2020.
//  Copyright © 2020 Oleksandr Myronovych. All rights reserved.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidUsername = "Invalid username which lead to error."
    case unableToPerformRequest = "Error occured. Unable to complete request"
    case badResponse = "Bad response from server. Try again later."
    case invalidData = "Invalid data received from server."
}

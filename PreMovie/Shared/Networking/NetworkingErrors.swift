//
//  NetworkingErrors.swift
//  PreMovie (iOS)
//
//  Created by Cédric Bahirwe on 09/10/2021.
//

import Foundation

enum NetworkErrors: Error {
    case invalidUrl
    case internetIssues
    case invalidResponse
    case invalidData
    case unableToDecodeData
    case unableToEncodeData
    case canNotProcessData(error: String)
    case unknownError(message: String)
    case serverError
    
    case internetConnection
    
    var message: String {
        switch self {
        case .invalidUrl:
            return "Invalid url"
        case .internetIssues:
            return "Check your internet connection"
        case .invalidResponse:
            return "The response found is not valid"
        case .unableToDecodeData:
            return "We could not process the result."
        case .unableToEncodeData:
            return "Unable to encode the entered data,"
        case .canNotProcessData(error: let message):
            return message
        case .unknownError(message: let message):
            return message
        case .serverError:
            return "There is an error on the server."
        case .internetConnection:
            /// A simple customizable error message to present in an alert
            return "Check your internet connection and try again."
        default:
            return "An unknown error occured, "
        }
    }
    
}

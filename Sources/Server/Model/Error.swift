//
//  File.swift
//  
//
//  Created by user on 20/12/2019.
//

import Foundation
import Vapor

public struct ErrorResponse<T: Error & RawRepresentable>: Error, Content where T.RawValue == String {
    public let errorType: String
    public let errorDescription: String
    
    public var localizedDescription: String {
        return errorDescription
    }
    
    public init(_ error: T) {
        self.errorType = error.localizedDescription
        self.errorDescription = error.rawValue
    }
}

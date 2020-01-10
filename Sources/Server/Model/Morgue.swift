//
//  File.swift
//  
//
//  Created by user on 11/12/2019.
//

import Foundation
import Vapor
import FluentMySQL


public struct Morgue {
    public var id: Int?
    public var address: String
    public var freeSpace: Int
    public var cathegory: String
    public var phoneNumber: String
    
    public init(
        id: Int? = nil,
        address: String,
        freeSpace: Int,
        cathegory: String,
        phoneNumber: String)
    {
        self.id = id
        self.address = address
        self.freeSpace = freeSpace
        self.cathegory = cathegory
        self.phoneNumber = phoneNumber
    }
}


extension Morgue: Content {}
extension Morgue: MySQLModel {}
extension Morgue: MySQLMigration {}

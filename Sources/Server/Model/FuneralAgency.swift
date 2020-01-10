//
//  File.swift
//  
//
//  Created by user on 11/12/2019.
//

import Foundation
import Vapor
import FluentMySQL

public struct FuneralAgency {
    public var id: Int?
    public var headOfficeAddress: String
    public var name: String
    public var phoneNumber: String
    
    public init(
        id: Int? = nil,
        headOfficeAddress: String,
        name: String,
        phoneNumber: String)
    {
        self.id = id
        self.headOfficeAddress = headOfficeAddress
        self.name = name
        self.phoneNumber = phoneNumber
    }
}


extension FuneralAgency: Content {}
extension FuneralAgency: MySQLModel {}
extension FuneralAgency: MySQLMigration {}

public extension FuneralAgency {
    var orders: Children<FuneralAgency, Order> {
        return children(\.idFuneralAgency)
    }
}

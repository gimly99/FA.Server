//
//  File.swift
//  
//
//  Created by user on 11/12/2019.
//

import Foundation
import Vapor
import FluentMySQL


public struct ProductDepartment{
    public var id: Int?
    public var address: String
    public var typeOfWork: String
    public var phoneNumber: String
    
    public init(
        id: Int? = nil,
        address: String,
        typeOfWork: String,
        phoneNumber: String)
    {
        self.id = id
        self.address = address
        self.typeOfWork = typeOfWork
        self.phoneNumber = phoneNumber
    }
}


extension ProductDepartment: Content {}
extension ProductDepartment: MySQLModel {}
extension ProductDepartment: MySQLMigration {}

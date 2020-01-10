//
//  File.swift
//  
//
//  Created by user on 11/12/2019.
//

import Foundation
import Vapor
import FluentMySQL

public struct Cemetery {
    public var id: Int?
    public var address: String
    public var freeSpace: Int
    
    public init(
        id: Int? = nil,
        address: String,
        freeSpace: Int)
    {
        self.id = id
        self.address = address
        self.freeSpace = freeSpace
    }
}

extension Cemetery: Content {}
extension Cemetery: MySQLModel {}
extension Cemetery: MySQLMigration {}


public extension Cemetery {
    var oders: Children<Cemetery, Order> {
        return children(\.idCemetery)
    }
}

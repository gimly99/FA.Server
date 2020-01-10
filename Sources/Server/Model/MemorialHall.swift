//
//  File.swift
//  
//
//  Created by user on 11/12/2019.
//

import Foundation
import Vapor
import FluentMySQL


public struct MemorialHall {
    public var id: Int?
    public var address: String
    public var capacity: Int
    
    public init(
        id: Int? = nil,
        address: String,
        capacity: Int)
    {
        self.id = id
        self.address = address
        self.capacity = capacity
    }
}


extension MemorialHall: Content {}
extension MemorialHall: MySQLModel {}
extension MemorialHall: MySQLMigration {}

public extension MemorialHall {
    var orders: Children<MemorialHall, Order> {
        return children(\.idMemorialHall)
    }
}

//
//  File.swift
//  
//
//  Created by user on 11/12/2019.
//

import Foundation
import Vapor
import FluentMySQL

public struct Client {
    public var id: Int?
    public var surname: String
    public var name: String
    public var patronymic: String
    public var dateOfBirth: Date
    public var dateOfDeath: Date
    public var causeOfDeath: String
    public var condition: String
    public var currentStatus: String
    
    public init(
        id: Int? = nil,
        surname: String,
        name: String,
        patronymic: String,
        dateOfBirth: Date,
        dateOfDeath: Date,
        causeOfDeath: String,
        condition: String,
        currentStatus: String)
        {
            self.id = id
            self.surname = surname
            self.name = name
            self.patronymic = patronymic
            self.dateOfBirth = dateOfBirth
            self.dateOfDeath = dateOfDeath
            self.causeOfDeath = causeOfDeath
            self.condition = condition
            self.currentStatus = currentStatus
        }
    
}

extension Client: Content {}
extension Client: MySQLModel {}
extension Client: MySQLMigration {}


public extension Client {
    var orders: Children<Client, Order> {
        return children(\.idClient)
    }
}

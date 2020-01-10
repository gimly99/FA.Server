//
//  File.swift
//  
//
//  Created by user on 11/12/2019.
//

import Foundation
import Vapor
import FluentMySQL

public struct Customer {
    public var id: Int?
    public var idUser: Int?
    public var surname: String
    public var name: String
    public var patronymic: String
    public var eMail: String
    public var phoneNumber: String
    
    public init(
        id: Int? = nil,
        idUser: Int? = nil,
        surname: String,
        name: String,
        patronymic: String,
        eMail: String,
        phoneNumber: String)
        {
        self.id = id
        self.idUser = idUser
        self.surname = surname
        self.name = name
        self.patronymic = patronymic
        self.eMail = eMail
        self.phoneNumber = phoneNumber
        }
    
}

extension Customer: Content {}
extension Customer: MySQLModel {}
extension Customer: MySQLMigration {}


public extension Customer {
    var user: Parent<Customer, User>? {
        return parent(\.idUser)
    }
//    
//    var orders: Children<Customer, Order> {
//        return children(\.idCustomer)
//    }
}

//
//  File.swift
//  
//
//  Created by user on 12/12/2019.
//

import Foundation
import Vapor
import FluentMySQL
import Authentication
public struct User {
    public var id: Int?
    public var password: String
    public var typeUser: TypeUser
    public var login: String
    
    public init(
        id: Int? = nil,
        password: String,
        typeUser: TypeUser,
        login: String)
    {
        self.id = id
        self.password = password
        self.typeUser = typeUser
        self.login = login
    }
}

extension User: Content {}
extension User: MySQLModel {}
extension User: MySQLMigration {}
    
public extension User {
    enum TypeUser: Int,  MySQLEnumType {
        case customer, employee
        public static func reflectDecoded() throws -> (User.TypeUser, User.TypeUser) {
            return (.customer, .employee)
        }
    }
}


public extension User {
    var customers: Children<User, Customer> {
        return children(\.idUser)
    }
    
    var employees: Children<User, Employee> {
        return children(\.idUser)
    }
}

extension User: BasicAuthenticatable {
    public static let usernameKey: WritableKeyPath<User, String> = \.login
    public static let passwordKey: WritableKeyPath<User, String> = \.password
}



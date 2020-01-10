//
//  File.swift
//  
//
//  Created by user on 20/12/2019.
//

import Foundation
import Vapor
import FluentMySQL
import Authentication

// MARK: - Main struct
public struct Token {
    public var id: Int?
    public var token: String
    public var employeeId: Employee.ID
    
    public init(id: Int? = nil, token: String, employeeId: Employee.ID) {
        self.id = id
        self.token = token
        self.employeeId = employeeId
    }
}

// MARK: - Vapor extensions
extension Token: Content {}
extension Token: MySQLModel {}
extension Token: MySQLMigration {}

// MARK: - Token extensions
extension Token: BearerAuthenticatable {
    public static var tokenKey: WritableKeyPath<Token, String> {
        return \.token
    }
}

extension Token: Authentication.Token {
    public typealias UserType = Employee
    public typealias UserIDType = Employee.ID
    public static var userIDKey: WritableKeyPath<Token, Employee.ID> {
        return \.employeeId
    }
}

// MARK: - Developer accesor
public extension Token {
    var empoloyee: Parent<Token, Employee> {
        return parent(\.employeeId)
    }
}

// MARK: - Public struct
public extension Token {
    struct Public: Content {
        public var token: String
        public var employee: Employee.Public
        public init(token: String, employee: Employee.Public) {
            self.token = token
            self.employee = employee
        }
    }
}

public extension EventLoopFuture where T == Token {
    func createPublic(for employee: Employee) -> EventLoopFuture<Token.Public>{
        return self.map { (token) in
            return Token.Public(token: token.token, employee: employee.public)
        }
    }
}

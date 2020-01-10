//
//  File.swift
//  
//
//  Created by user on 11/12/2019.
//

import Foundation
import FluentMySQL
import Vapor
import Authentication



public struct Employee {
    public var id: Int?
    public var idUser: Int?
    public var surname: String
    public var name: String
    public var patronymic: String?
    public var experience: Int
    public var position: String?
    public var phoneNumber: String
    public var eMail: String
    public var password: String
    
    public init(
        id: Int? = nil,
        idUser: Int? = nil,
        surname: String,
        name: String,
        patronymic: String? = nil,
        experience: Int,
        position: String? = nil,
        phoneNumber: String,
        eMail: String,
        password: String)
    {
        self.id = id
        self.idUser = idUser
        self.surname = surname
        self.name = name
        self.patronymic = patronymic
        self.experience = experience
        self.position = position
        self.phoneNumber = phoneNumber
        self.eMail = eMail
        self.password = password
    }
}


extension Employee: Content {}
extension Employee: MySQLModel {}
extension Employee: MySQLMigration {}

public extension Employee {
    var user: Parent<Employee, User>? {
        return parent(\.idUser)
    }
}

extension Employee: TokenAuthenticatable {
    public typealias TokenType = Token
}

public extension Employee {
    struct Public: Content {
        let name: String
        let surname: String
        
        init(name: String, surname: String) {
            self.name = name
            self.surname = surname
        }
    }
    var `public`: Public {
        return Public(name: self.name, surname: self.surname)
    }
}

public extension Employee {
    struct Login: Content {
        let eMail: String
        let password: String
        
        init(eMail: String, password: String) {
            self.eMail = eMail
            self.password = password
        }
    }
    
    var login: Login {
        return Login(eMail: self.eMail, password: self.password)
    }
}

public extension Employee {
    struct RegisterForm: Content {
        public var eMail: String
        public var name: String
        public var surname: String
        public var password: String
        public var phoneNumber: String
        public var experience: Int
    }
    
    init(registerForm: RegisterForm) {
        self = Employee(surname: registerForm.surname, name: registerForm.name, experience: registerForm.experience, phoneNumber: registerForm.phoneNumber, eMail: registerForm.eMail, password: registerForm.password)
    }
}

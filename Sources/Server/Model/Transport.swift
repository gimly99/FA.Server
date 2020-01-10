//
//  File.swift
//  
//
//  Created by user on 11/12/2019.
//

import Foundation
import Vapor
import FluentMySQL

public struct Transport{
    public var id: Int?
    public var name: String
    public var mark: String
    public var number: String
    public var cathegory: String
    
    public init(
        id: Int? = nil,
        name: String,
        mark: String,
        number: String,
        cathegory: String)
    {
        self.id = id
        self.name = name
        self.mark = mark
        self.number = number
        self.cathegory = cathegory
    }
}


extension Transport: Content {}
extension Transport: MySQLModel {}
extension Transport: MySQLMigration {}

//
//  File.swift
//  
//
//  Created by user on 15/12/2019.
//

import Foundation
import Vapor
import FluentMySQL

final class Todo: Parameter, Content, MySQLModel, MySQLMigration {

    //MARK: Properties
    var id: Int?
    var title: String

    init(id: Int? = nil, title: String) {
        self.id = id
        self.title = title
    }
}


//extension Todo: Content {}
//extension Todo: MySQLModel {}
//extension Todo: MySQLMigration {}
//extension Todo: Parameter {}

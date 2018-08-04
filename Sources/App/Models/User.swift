//
//  User.swift
//  App
//
//  Created by Podul on 2018/8/3.
//

import FluentSQLite
import Vapor

final class User: Codable {
    var id: UUID?
    var name: String
    var username: String
    
    init(name: String, username: String) {
        self.name = name
        self.username = username
    }
}

extension User: SQLiteUUIDModel {}
extension User: Content {}
extension User: Migration {}
extension User: Parameter {}

extension User {
    var info: Children<User, UserInfos> {
        return children(\.userID)
    }
    
}

//
//  SQLiteController.swift
//  App
//
//  Created by Podul on 2018/8/2.
//

import FluentSQLite
import Vapor

// 必须要 final
final class UserInfos: Codable {
    var id: Int?
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

extension UserInfos: SQLiteModel {}
extension UserInfos: Content {}
extension UserInfos: Migration {}


struct SQLiteController: RouteCollection {
    func boot(router: Router) throws {
        let group = router.grouped("api")
        group.get(use: getAllInfos)
        group.post(use: saveInfos)
    }
    
    func getAllInfos(_ req: Request) throws -> Future<[UserInfos]> {
        return UserInfos.query(on: req).all()
    }
    
    func saveInfos(_ req: Request) throws -> Future<UserInfos> {
        let userInfos = try req.content.decode(UserInfos.self)
        return userInfos.save(on: req)
    }
}

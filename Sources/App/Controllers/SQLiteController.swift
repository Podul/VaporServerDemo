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
extension UserInfos: Parameter {}


struct SQLiteController: RouteCollection {
    func boot(router: Router) throws {
        let group = router.grouped("api")
        group.get(use: getAllInfos)
        group.post(use: saveInfos)
        // UserInfos.parameter 可以拿到 /api/ 后的参数
        group.get(UserInfos.parameter, use: getInfo)
        
        group.delete(UserInfos.parameter, use: deleteInfo)
        group.put(UserInfos.parameter, use: updateInfo)
    }
    
    /// 获取所有
    func getAllInfos(_ req: Request) throws -> Future<[UserInfos]> {
        return UserInfos.query(on: req).all()
    }
    
    /// 添加一条
    func saveInfos(_ req: Request) throws -> Future<UserInfos> {
        let userInfos = try req.content.decode(UserInfos.self)
        return userInfos.save(on: req)
    }
    
    /// 获取一条
    func getInfo(_ req: Request) throws -> Future<UserInfos> {
        return try req.parameters.next(UserInfos.self)
    }
    
    /// 删除一条
    func deleteInfo(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(UserInfos.self).flatMap { info in
            return info.delete(on: req).transform(to: HTTPStatus.noContent)
        }
    }
    
    /// 更新
    func updateInfo(_ req: Request) throws -> Future<UserInfos> {
        return try flatMap(to: UserInfos.self, req.parameters.next(UserInfos.self), req.content.decode(UserInfos.self)) { info, updateInfo in
            info.name = updateInfo.name
            info.age = updateInfo.age
            return info.save(on: req)
        }
    }
}

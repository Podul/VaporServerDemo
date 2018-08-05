//
//  MySQLController.swift
//  App
//
//  Created by Podul on 2018/7/26.
//

import Vapor
import FluentMySQL


struct LoginRequest: MySQLModel {
    var id: Int?
    var email: String
    var password: String
}

extension LoginRequest: Content {}
extension LoginRequest: Migration {}
extension LoginRequest: Parameter {}



class MySQLController: RouteCollection {
    func boot(router: Router) throws {
        
        let group = router.grouped("mysql")
        group.post(use: createMySQL)
        
        
//        router.post("mysql") { (req) -> Future<String> in
//            return req.withPooledConnection(to: .mysql) { (conn) in
////                req.content.decod
//                let que = conn.query("select * from test")
//                let title = que.map { rows -> String in
//                    var arr = Array<Any>()
//                    var dic = Dictionary<String, Any>()
//                    for row in rows {
//                        dic["test_title"] = row.firstValue(forColumn: "test_title")?.string()
//                        dic["test_author"] = row.firstValue(forColumn: "test_author")?.string()
//                        dic["test_id"] = row.firstValue(forColumn: "test_id")?.string()
//                        arr.append(dic)
//                    }
//
//                    let dictionary = ["list": arr]
//
//                    let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
//                    let jsonStr = String.init(data: data, encoding: .utf8)
//                    return jsonStr!                }
//
//                return title
//            }
//        }
    }
    
    func createMySQL(_ req: Request) throws -> Future<LoginRequest> {
        let info = try ["email": "baidu@qq.com", "password": "123456"].encode(for: req)
        let bbb = info.flatMap(to: LoginRequest.self) { (res) -> Future<LoginRequest> in
            return try res.content.decode(LoginRequest.self)
        }
        bbb.save(on: req)
//        return try
//        req.content.syncd
        let aaa = try req.content.decode(LoginRequest.self).save(on: req)
        return aaa
    }
}


struct Test: Codable {
    var test_title: String?
    var test_author: String?
    var test_id: String?
}

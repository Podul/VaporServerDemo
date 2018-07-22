//
//  TestController.swift
//  TestServerPackageDescription
//
//  Created by Podul on 2018/7/18.
//

import Vapor
import MySQL




struct Test: Codable {
    let test_id: Int
    let title: String
}


class TestController: RouteCollection {
//    func requestRouter(_ req: Request) throws -> ResponseEncodable {
//
//    }

    
    func boot(router: Router) throws {
        router.get("hello", use: filterWordData)
        
        router.get("sql", use: testSql)
    }
}

extension TestController {
    
    func testSql(_ req: Request) throws -> Future<String> {
        req.query(Model.Protocol)
//        return req.withPooledConnection(to: .mysql, closure: { (conn) in
//            let future = conn.query("select * from test")
//            let json = future.map(to: Array.self) { rows in
//                return rows
//            })
//            return json
//        })
        
        
        return req.withPooledConnection(to: .mysql, closure: connect)
    }
    
    func connect(conn: MySQLConnection) -> Future<String> {
        return conn.raw("select * from test").all(decoding: Test.self).map {
                return $0.last?.title ?? "null"
        }
//        return conn.query("select * from test").map(to: String.self) {
//            print($0.first!)
//            return try $0.first!.firstValue(forColumn: "title")?.decode(String.self) ?? "n/a"
//        }
    }
    
    func filterWordData(_ req: Request) throws -> Future<Response> {
        let arr = ["mssage":"Hello!","desc":"Welcome to visit my repository address: https://github.com/Jinxiansen/Guardian"]
        let data = try arr.encode(for: req)
        return data
    }
}






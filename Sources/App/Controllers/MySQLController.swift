//
//  MySQLController.swift
//  App
//
//  Created by Podul on 2018/7/26.
//

import Vapor
import MySQL


class MySQLController: RouteCollection {
    func boot(router: Router) throws {
        /*
        router1.post("mysql") { req in
            return req.withPooledConnection(to: .mysql, closure: self.connect)
        }
        */
        
        router.post("mysql") { (req) -> Future<String> in
            return req.withPooledConnection(to: .mysql) { (conn) in
                let que = conn.query("select * from test")
                let title = que.map { rows -> String in
                    var arr = Array<Any>()
                    var dic = Dictionary<String, Any>()
                    for row in rows {
                        dic["test_title"] = row.firstValue(forColumn: "test_title")?.string()
                        dic["test_author"] = row.firstValue(forColumn: "test_author")?.string()
                        dic["test_id"] = row.firstValue(forColumn: "test_id")?.string()
                        arr.append(dic)
                    }
                    
                    let dictionary = ["list": arr]
                    
                    let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
                    let jsonStr = String.init(data: data, encoding: .utf8)
                    return jsonStr!
                    
//                    return ["list": arr]
                    //            return rows.first?.firstValue(forColumn: "test_title")?.string() ?? "NULL"
                }
                
                return title
            }
        }
    }
    /*
    
    func connect(conn: MySQLConnection) -> Future<Array<Any>> {
        let que = conn.query("select * from test")
        let title = que.map { rows in
            var arr = Array<Any>()
            var dic = Dictionary<String, Any>()
            for row in rows {
                dic["test_title"] = row.firstValue(forColumn: "test_title")
                dic["test_title"] = row.firstValue(forColumn: "test_author")
                dic["test_title"] = row.firstValue(forColumn: "test_id")
                arr.append(dic)
            }
            
            
            let tmp = arr.encode(for: Request)
            
            
            return
//            return rows.first?.firstValue(forColumn: "test_title")?.string() ?? "NULL"
        }
        
        return title
    }
 
 */
}


struct Test: Codable {
    var test_title: String?
    var test_author: String?
    var test_id: String?
    
    
}

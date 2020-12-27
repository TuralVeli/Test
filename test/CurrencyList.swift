//
//  CurrencyList.swift
//  test
//
//  Created by Tural Veliyev on 12/23/20.
//

import Foundation
import ObjectMapper
import SocketIO
class CurrencyList: Mappable {

    var code : String?
    var az : String?
    var ru : String?
    var en : String?
    var tr : String?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
    
        code <- map["code"]
        az <- map["az"]
        ru <- map["ru"]
        en <- map["en"]
        tr <- map["tr"]
  
    }
    
}


class CurrencyListRate: Mappable {

    var from : String?
    var to : String?
    var result : Double?
    var date : String?
    var menbe : String?

    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        
    
        from <- map["from"]
        to <- map["to"]
        result <- map["result"]
        date <- map["date"]
        menbe <- map["menbe"]
  
    }
    
}



//let serverURL = "https://q.investaz.az/live"
//
//class SocketOpration {
//
//    static let shared = SocketOpration(socketURL: URL(string: serverURL)!)
//
//    let socketURL: URL
//    var socket:SocketIOClient!
//    var manager:SocketManager!
//
//
//   init(socketURL: URL) {
//        self.socketURL = socketURL
//        self.manager = SocketManager(socketURL: self.socketURL, config: [.log(false)])
//        self.socket = self.manager.defaultSocket
//   }
//
//    func setup() {
//
//          socket.on(clientEvent: .connect) {[weak self] data, ack in
//              print("socket connected")
//          }
//
//          socket.on(clientEvent: .disconnect) {[weak self] data, ack in
//            print("socket disconnected")
//          }
//
//
//        // Get emit Call via On method ( emit will fire from Node )
//
//         socket.on("messages") { [weak self](data, ack) in
//            if data.count > 0 {
//                print(data)
//            }
//         }
//
//    }
//
//}

//
//  GlobalMethod.swift
//
//  Created by Tural Veliyev on 12/23/20.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import SocketIO
class GlobalMethod: NSObject {

    static let objGlobalMethod = GlobalMethod()
    let base_url = "https://valyuta.com/api/"

    func ServiceMethodPost(url:String, controller:UIViewController, parameters:Parameters, completion: @escaping (_ result: DataResponse<Any>) -> Void){
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        headers["Content-Type"] = "application/json"
        Alamofire.request(base_url + url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:headers
            ).responseJSON
            {
                response in
                completion(response)
        }
    }


    func ServiceMethodGet(url:String, controller:UIViewController, completion: @escaping (_ result: DataResponse<Any>) -> Void){
        let headers = Alamofire.SessionManager.defaultHTTPHeaders
        Alamofire.request(base_url + url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers:headers
            ).responseJSON
            {
                response in
                completion(response)
        }
    }

}





//class MySocket: NSObject {
//    var socketManager:SocketManager!
//    let manager = SocketManager(socketURL: NSURL(string: "https://q.investaz.az/live")! as URL, config: [
//        .log(true),
//        .compress,
//        .reconnects(true),
//        .reconnectWait(1)
//    ])
//
//    func connected() {
//        print("socket try to connecting.....")
//
//        let socket = manager.socket(forNamespace: "/swift")
//
//        socket.on(clientEvent: .connect) {data, ack in
//            print("socket connected")
//        }
//
//        socket.on(clientEvent: .error) {data, ack in
//            print("socket error")
//        }
//
//        socket.on("messages") {data, ack in
//            guard let cur = data[0] as? Double else { return }
//
//            print("socket listen for itsMyPersonalChanel : ", cur)
//
//        }
//
//        socket.connect()
//    }
//}






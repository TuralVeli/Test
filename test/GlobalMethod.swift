//
//  GlobalMethod.swift
//
//  Created by Tural Veliyev on 12/23/20.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class GlobalMethod: NSObject {

    static let objGlobalMethod = GlobalMethod()
    //dev. her ikisinde yoxle file urlde
    let base_url = "https://valyuta.comapi/api/"

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

    func ServiceMethodPostWithToken(url:String, controller:UIViewController, parameters:[String: AnyObject]?, completion: @escaping (_ result: DataResponse<Any>) -> Void){
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        let token = SessionManager().getToken()
        headers["authorization"] = "TOKEN \(token)"
        headers["Content-Type"] = "application/json"
        Alamofire.request(base_url + url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:headers
            ).responseJSON
            {
                response in
                completion(response)
        }
    }

    func ServiceMethodPatch(url:String, controller:UIViewController, parameters:[String: AnyObject]?, completion: @escaping (_ result: DataResponse<Any>) -> Void){
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        let token = SessionManager().getToken()
        headers["authorization"] = "TOKEN \(token)"
        headers["Content-Type"] = "application/json"
        Alamofire.request(base_url + url, method: .patch, parameters: parameters, encoding: JSONEncoding.default, headers:headers
            ).responseJSON
            {
                response in
                completion(response)
        }
    }

    func ServiceMethodGet(url:String, controller:UIViewController, completion: @escaping (_ result: DataResponse<Any>) -> Void){
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        let token = SessionManager().getToken()
        headers["authorization"] = "TOKEN \(token)"
        Alamofire.request(base_url + url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers:headers
            ).responseJSON
            {
                response in
                completion(response)
        }
    }
    func ServiceMethodGeting(url:String, controller:UIViewController, completion: @escaping (_ result: DataResponse<Any>) -> Void){
        
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        let token = SessionManager().getToken()
        headers["authorization"] = "TOKEN \(token)"
        Alamofire.request(base_url + url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers:headers
            ).responseJSON
            {
                response in
                completion(response)
        }
    }
}


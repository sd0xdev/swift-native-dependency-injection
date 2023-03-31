//
//  BaseAPIServices.swift
//  ActualCombatSwiftNetwork
//
//  Created by 陳囿豪 on 2019/7/27.
//  Copyright © 2019 yasuoyuhao. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

public protocol ServicesURLProtocol {
    var url: String { get }
}

public protocol APIServicesURLProtocol: ServicesURLProtocol {
    var rootURL: String { get }
}

struct ServicesURL {
    
    static var baseurl: String {
        return "https://yasuoyuhao-restfulapi.herokuapp.com/api/"
    }
}

enum AuthAPIURL: APIServicesURLProtocol {
    
    public var rootURL: String {
        return  "accounts/"
    }
    
    case login
    case signup
    
    public var url: String {
        return getURL()
    }
    
    private func getURL() -> String {
        var resource = ""
        
        switch self {
        case .login:
            resource = "login"
        case .signup:
            resource = "signup"
        }
        
        return "\(rootURL)\(resource)"
    }
}

enum ProductAPIURL: APIServicesURLProtocol {
    
    public var rootURL: String {
        return  "products/"
    }
    
    case fetch
    
    public var url: String {
        return getURL()
    }
    
    private func getURL() -> String {
        var resource = ""
        
        switch self {
        case .fetch:
            resource = ""
        }
        
        return "\(rootURL)\(resource)"
    }
}

class AuthToken {
    static let shared = AuthToken()
    
    var token: String?
}

class BaseAPIServices {
    
    /**
     Base Http Request Generator
     - Parameter url: 請求資源位置
     - Parameter parameters: Parameters
     - Parameter method: HTTPMethod
     - Parameter encoding: URLEncoding
     */
    public func requestGenerator(route: APIServicesURLProtocol, parameters: Parameters? = nil, method: HTTPMethod = .get, encoding: ParameterEncoding = URLEncoding.default) -> DataRequest {
        
        let url = ServicesURL.baseurl + route.url
        
        var headers: HTTPHeaders?
        
        if let token = AuthToken.shared.token {
            headers = HTTPHeaders()
            headers?.updateValue(token, forKey: "Authorization")
        }
        
        return Alamofire.request(
            url,
            method: method,
            parameters: parameters,
            encoding: encoding,
            headers: headers
        )
    }
    
    /**
     Base API Producer
     - Parameter dataRequest: 請求數據
     - Parameter type: 回應模型
     - Returns: Promise.
     */
    public func setupResponse<T: Codable>(_ dataRequest: DataRequest, type: T.Type) -> Promise<T> {
        return Promise<T>.init(resolver: { (resolver) in
            dataRequest.validate().responseJSON(queue: DispatchQueue.global(), options: JSONSerialization.ReadingOptions.mutableContainers, completionHandler: { (response) in
                
                switch response.result {
                    
                case .success(let json):
                    do {
                        let decoder: JSONDecoder = JSONDecoder()
                        let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                        let content = try decoder.decode(T.self, from: jsonData)
                        resolver.fulfill(content)
                    } catch let error {
                        resolver.reject(error)
                    }
                case .failure(let error):
                    print(error)
                    
                    if let aferror = error as? AFError {
                        
                        // Error Catch
                        
                        switch aferror {
                            
                        case .invalidURL:
                            ()
                        case .parameterEncodingFailed:
                            ()
                        case .multipartEncodingFailed:
                            ()
                        case .responseValidationFailed:
                            ()
                        case .responseSerializationFailed:
                            ()
                        }
                    }
                    resolver.reject(error)
                }
            })
        })
    }
}

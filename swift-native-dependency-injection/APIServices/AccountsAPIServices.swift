//
//  AccountsAPIServices.swift
//  ActualCombatSwiftNetwork
//
//  Created by 陳囿豪 on 2019/7/27.
//  Copyright © 2019 yasuoyuhao. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

class AccountsAPIServices: BaseAPIServices {
    
    static let shared = AccountsAPIServices()
    
    func login(email: String, password: String) -> Promise<String> {
        // 返回 Promise
        return Promise<String>.init(resolver: { (resolver) in
            
            // 組合參數
            var parameters = [String: AnyObject]()
            
            parameters.updateValue(email as AnyObject, forKey: "email")
            parameters.updateValue(password as AnyObject, forKey: "password")
            
            // 生成 Request
            let req = self.requestGenerator(route: AuthAPIURL.login, parameters: parameters, method: .post, encoding: JSONEncoding.default)
            
            firstly {
                // 發送請求，並且給予型別
                self.setupResponse(req, type: LoginResult.self)
                }.then { (tokenRes) -> Promise<String> in
                    // 處理回應
                    return Promise<String>.init(resolver: { (resolver) in
                        print(tokenRes)
                        // Token 處理，解碼與儲存
                        if let token = tokenRes.token {
                            AuthToken.shared.token = token
                            resolver.fulfill(token)
                        } else {
                            resolver.reject(AuthError.tokenIsNotExist)
                        }
                    })
                }.done { (currectUserId) in
                    // 完成流程
                    resolver.fulfill(currectUserId)
                }.catch(policy: .allErrors) { (error) in
                    // 錯誤處理
                    resolver.resolve(nil, error)
            }
        })
    }
    
    func signup(email: String, password: String, name: String, emailContent: String) -> Promise<String> {
        // 返回 Promise
        return Promise<String>.init(resolver: { (resolver) in
            
            // 組合參數
            var parameters = [String: AnyObject]()
            
            parameters.updateValue(email as AnyObject, forKey: "email")
            parameters.updateValue(password as AnyObject, forKey: "password")
            parameters.updateValue(name as AnyObject, forKey: "name")
            parameters.updateValue(emailContent as AnyObject, forKey: "emailContent")
            
            // 生成 Request
            let req = self.requestGenerator(route: AuthAPIURL.signup, parameters: parameters, method: .post, encoding: JSONEncoding.default)
            
            firstly {
                // 發送請求，並且給予型別
                self.setupResponse(req, type: LoginResult.self)
                }.then { (tokenRes) -> Promise<String> in
                    // setup record token
                    return Promise<String>.init(resolver: { (resolver) in
                        print(tokenRes)
                        // Token 處理，解碼與儲存
                        if let token = tokenRes.token {
                            AuthToken.shared.token = token
                            resolver.fulfill(token)
                        } else {
                            resolver.reject(AuthError.tokenIsNotExist)
                        }
                    })
                }.done { (currectUserId) in
                    // 完成流程
                    resolver.fulfill(currectUserId)
                }.catch(policy: .allErrors) { (error) in
                    // 錯誤處理
                    resolver.resolve(nil, error)
            }
        })
    }
}

enum AuthError: Error {
    case tokenIsNotExist
    
    var localizedDescription: String {
        return getLocalizedDescription()
    }
    
    private func getLocalizedDescription() -> String {
        
        switch self {
            
        case .tokenIsNotExist:
            return "token is not find."
        }
        
    }
}

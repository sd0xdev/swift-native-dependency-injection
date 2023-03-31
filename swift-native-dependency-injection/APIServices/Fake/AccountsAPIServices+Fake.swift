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

class AccountsAPIServicesFake: AccountsAPIServices {
    
    override func login(email: String, password: String) -> Promise<String> {
        // 返回 Promise
        return Promise<String>.init(resolver: { (resolver) in
            print("---------- success use fake token ----------")
            resolver.fulfill("----- fake token -----")
        })
    }
}

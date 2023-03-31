//
//  ProductsAPIServices.swift
//  ActualCombatSwiftNetwork
//
//  Created by 陳囿豪 on 2019/8/10.
//  Copyright © 2019 yasuoyuhao. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

class ProductsAPIServices: BaseAPIServices {
    
    static let shared = ProductsAPIServices()
    
    func fetchProducts() -> Promise<[Products]> {
        // 返回 Promise
        return Promise<[Products]>.init(resolver: { (resolver) in
            
            // 生成 Request
            let req = self.requestGenerator(route: ProductAPIURL.fetch, method: .get)
            
            firstly {
                // 發送請求，並且給予型別
                self.setupResponse(req, type: ProductRes.self)
                }.then { (productRes) -> Promise<[Products]> in
                    // 處理回應
                    return Promise<[Products]>.init(resolver: { (resolver) in
                        print(productRes.success ?? false)
                        // 確認產品是否有資料
                        if let products = productRes.products {
                            resolver.fulfill(products)
                        } else {
                            resolver.reject(ProductError.productIsNotFind)
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

enum ProductError: Error {
    case productIsNotFind
    
    var localizedDescription: String {
        return getLocalizedDescription()
    }
    
    private func getLocalizedDescription() -> String {
        
        switch self {
            
        case .productIsNotFind:
            return "product is not find."
        }
        
    }
}

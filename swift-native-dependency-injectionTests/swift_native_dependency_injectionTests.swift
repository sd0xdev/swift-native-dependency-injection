//
//  swift_native_dependency_injectionTests.swift
//  swift-native-dependency-injectionTests
//
//  Created by 陳囿豪 on 2020/6/27.
//  Copyright © 2020 陳囿豪. All rights reserved.
//

import Quick
import Nimble
@testable import swift_native_dependency_injection

class swift_native_dependency_injectionTests: QuickSpec {
    
    override func spec() {
        
        // Set up DI
        Dependencies.Container.default.register(AccountsAPIServicesFake())
        
        describe("Authorization API Servies") {
            context("User Sign in") {
                it("App Post Sign Data Use API") {
                    waitUntil(timeout: 10, action: { (done) in
                        let page = ContentView()
                        _  = page.fetchByDI().done({ _ in
                            done()
                        }).catch({ _ in
                            expect { () -> Void in fatalError() }.to(throwAssertion())
                        })
                    })
                }
            }
        }
    }
    
}

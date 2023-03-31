//
//  ContentView.swift
//  swift-native-dependency-injection
//
//  Created by 陳囿豪 on 2020/6/27.
//  Copyright © 2020 陳囿豪. All rights reserved.
//

import SwiftUI
import PromiseKit

struct ContentView: View {
    
    @Dependencies.InjectObject() private var accountsAPIServices: AccountsAPIServices
    
    var body: some View {
        Button(action: {
            // self.fetchBySingleton()
            _ = self.fetchByDI()
        }) {
            Text("login")
        }
    }
    
    func fetchBySingleton() -> Promise<Void> {
        return Promise<Void>.init { (resolver) in
            _ = AccountsAPIServices.shared.login(email: "yasuoyuhao@gmail.com", password: "14581234").done({ token in
                print("----- success login -----")
                resolver.fulfill(())
            }).catch({ error in
                print("----- \(error) -----")
                resolver.reject(error)
            })
        }
    }
    
    func fetchByDI() -> Promise<Void> {
        return Promise<Void>.init { (resolver) in
            _ = accountsAPIServices.login(email: "yasuoyuhao@gmail.com", password: "14581234").done({ token in
                print("----- success login -----")
                resolver.fulfill(())
            }).catch({ error in
                print("----- \(error) -----")
                resolver.reject(error)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

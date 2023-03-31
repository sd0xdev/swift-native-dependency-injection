# ActualCombatSwiftNetwork

<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" /> <a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift5-compatible-4BC51D.svg?style=flat" alt="Swift 5 compatible" /></a>

實戰: 結構化 API 模組與功能

## How to Get Start

1. cd to dir
2. run `pod install`

## 源碼說明

工作中，常常需要與後端串接 API，API 網址常常很難管理與統一路口，依照我在公司的經驗，我們規範出一整套 API 串接的體系與模組，想要與大家分享。
要點內容：

1. 統一 API 底層入口，利用泛型來解決所有 json data to Model 轉換
2. 規範 API Function 結構，不再讓 URL 散落一地
3. 統一的錯誤獲取，讓 debug 不再頭大
4. 結合 PromiseKit 與 Alamofire，製作屬於你的非同步 API 網路應用
5. 使用 mock server 解耦你與後端的關係

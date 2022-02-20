//
//  KeyChain.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/03.
//


//source reference https://dvlpr-chan.tistory.com/27
// UserDefaults vs KeyChain -> 이부분에 대해서 고민이 필요할듯. 오늘 해보니 UserDefaults 가 쓰기 편했다..

import Foundation
import RxSwift
import RxCocoa

enum KeyChainError:Error {
    case notFound
    case Exist
}

class KeyChain {
    static let shared = KeyChain()
    static let token = "Token"
    static let refresh = "refreshToken"
    static let nickName = "nickName"
    
    func addItem(key: String, value: Any) -> Bool {
        let addQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                   kSecAttrAccount: key,// Key 지정
                                     kSecValueData: (value as AnyObject).data(using: String.Encoding.utf8.rawValue) as Any]//Value지정
        print("QUERY ",addQuery)
        let result: Bool = {
            let status = SecItemAdd(addQuery as CFDictionary, nil)
            if status == errSecSuccess {
                return true
            } else if status == errSecDuplicateItem {
                return updateItem(value: value, key: key)
            }
            print("addItem Error : \(status.description))")
            return false
        }()
        
        return result
    }
    
    func getInfo(key: String) -> Observable<String?> {
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                kSecAttrAccount: key,
                           kSecReturnAttributes: true,
                                 kSecReturnData: true]
        
        var item: CFTypeRef?
        let result = SecItemCopyMatching(query as CFDictionary, &item)
        
        if result == errSecSuccess {
            if let existingItem = item as? [String: Any],
               let data = existingItem[kSecValueData as String] as? Data,
               let password = String(data: data, encoding: .utf8) {
                return Observable.create { observe in
                    observe.onNext(password)
                    observe.onCompleted()
                    return Disposables.create()
                }
            }
        }
        return Observable.create{ observe in observe.onError(KeyChainError.notFound); return Disposables.create()}
    }
    
    func getItem(key: Any) -> Any? {
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                kSecAttrAccount: key,
                           kSecReturnAttributes: true,
                                 kSecReturnData: true]
        var item: CFTypeRef?
        let result = SecItemCopyMatching(query as CFDictionary, &item)
        
        if result == errSecSuccess {
            if let existingItem = item as? [String: Any],
               let data = existingItem[kSecValueData as String] as? Data,
               let password = String(data: data, encoding: .utf8) {
                return password
            }
        }
        
        print("getItem Error : \(result.description)")
        return nil
    }
    
    func updateItem(value: Any, key: Any) -> Bool {
        let prevQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                    kSecAttrAccount: key]
        let updateQuery: [CFString: Any] = [kSecValueData: (value as AnyObject).data(using: String.Encoding.utf8.rawValue) as Any]
        
        let result: Bool = {
            let status = SecItemUpdate(prevQuery as CFDictionary, updateQuery as CFDictionary)
            if status == errSecSuccess { return true }
            
            print("updateItem Error : \(status.description)")
            return false
        }()
        
        return result
    }
    
    func deleteItem(key: String) -> Bool {
        let deleteQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                      kSecAttrAccount: key]
        let status = SecItemDelete(deleteQuery as CFDictionary)
        if status == errSecSuccess { return true }
        
        print("deleteItem Error : \(status.description)")
        return false
    }
}

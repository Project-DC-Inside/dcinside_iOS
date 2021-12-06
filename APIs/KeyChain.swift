//
//  KeyChain.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/03.
//


//source reference https://dvlpr-chan.tistory.com/27
import Foundation

class KeyChain {
        static let shared = KeyChain()
        
        func addItem(key: Any, value: Any) -> Bool {
            let addQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                             kSecAttrAccount: key,// Key 지정
                                             kSecValueData: (value as AnyObject).data(using: String.Encoding.utf8.rawValue) as Any]//Value지정
            
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
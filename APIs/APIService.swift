//
//  APIService.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/03.
//

import Foundation
import Alamofire

class APIService {
    //최초 생성시, 전역으로 사용가능하게한다.
    
    static let shared = APIService()
    private let baseURL = "https://api.itbook.store/1.0/"
    func loginAPI() {
        AF.request(baseURL + "/search/mongodb").responseJSON { response in
            print(response.response?.statusCode)
            print(response.debugDescription)
        }
    }
    
    func singUpAPI() {
        
    }
    
    func openPage() {
        
    }
    
    func openCategory() {
        
    }
    
    
}


// enum 으로 상태도 표현해주자


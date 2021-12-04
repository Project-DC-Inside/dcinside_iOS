//
//  APIService.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/03.
//

import Foundation
import Alamofire

enum NetworkResult<T> {
    // status Code에 따라서..
    case success(T) // 200 성공!
    case requestErr(T) // 300 request Error
    case pathErr // 400 요청오류
    case serverErr // 500 서버문제
    case networkFail // 네트워크 문제.. 600번대는 없어!
}


class APIService {
    //최초 생성시, 전역으로 사용가능하게한다.
    
    static let shared = APIService()
    
    private let HTTPHeaders = ["Content-Type": "application/json"]
    private let baseURL = "https://api.itbook.store/1.0/"
    
    private func completionConvertor(by statusCode: Int, _ data: Login) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return .success(data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    func loginAPI(compleition: (NetworkResult<Any>)->Void) {
        AF.request(baseURL + "/search/mongodb").responseJSON { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                
                guard let value = response.value else { return }
                
                let decoder = JSONDecoder()
                guard let decodeData = try? decoder.decode(Login.self, from: value as! Data) else { compleition(.pathErr)}
                
                compleition(self.completionConvertor(by: statusCode, decodeData))
            case .failure:
                compleition(.pathErr)
            }
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


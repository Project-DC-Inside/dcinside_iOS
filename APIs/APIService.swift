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
    private let baseURL = "http://3.36.205.23:8080"
    
    private func completionConvertor(by statusCode: Int, _ data: Any) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return .success(data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    func loginAPI(SingIn: Login, compleition: @escaping (NetworkResult<Any>) -> Void) {
        AF.request(baseURL + "/api/v1/auth/signin", method: .post, parameters: SingIn, encoder: JSONParameterEncoder.default).responseJSON { response in
            print(response.result)
            switch response.result {
            case .success(let data):
                guard let statusCode = response.response?.statusCode else { return }                
                //print(jsonData)
                //let decoder = JSONDecoder()
                //guard let decodeData = try? decoder.decode(Login.self, from: value as! Data) else { return }
                
                compleition(self.completionConvertor(by: statusCode, data))
            case .failure:
                compleition(.pathErr)
            }
        }
    }
    
    func singUpAPI(SingUpID: User, completion: @escaping (NetworkResult<Any>) -> Void) {
        AF.request(baseURL + "/api/v1/auth/signup", method: .post, parameters: SingUpID, encoder: JSONParameterEncoder.default).responseString(completionHandler: { response in
            guard let statusCode = response.response?.statusCode else { return }
            switch response.result{
            case .success:
                guard let value = response.value else { return }
                completion(self.completionConvertor(by: statusCode, value))
            case .failure:
                completion(.pathErr)
                
            }
            
        })
    }
    
    func refreshAPI(token: tokenInfo,completion: @escaping (NetworkResult<Any>)-> Void) {
        let token = refreshToken(accessToken: token.accessToken, refreshToken: token.refreshToken)
        AF.request(baseURL + "/api/v1/auth/reissue", method: .post, parameters: token, encoder: JSONParameterEncoder.default).responseJSON { response in
            guard let statusCode = response.response?.statusCode else { return }
            switch response.result {
            case .success(let data):
                guard let data = response.value else { return }
                completion(self.completionConvertor(by: statusCode, data))
                        
                break
            case .failure:
                completion(.pathErr)
                break
            }
        }
        
    }
    func openPage() {
        
    }
    
    func openCategory() {
        
    }
}

struct refreshToken : Codable {
    var accessToken: String
    var refreshToken: String
}


// enum 으로 상태도 표현해주자


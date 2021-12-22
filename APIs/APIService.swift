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
    case failure(T)
    case networkErr
}


class APIService {
    //최초 생성시, 전역으로 사용가능하게한다.
    static let shared = APIService()
    
    private let HTTPHeaders = ["Content-Type": "application/json"]
    private let baseURL = "http://3.36.205.23:8080"
    
    func SingInAPI(singin: Login, compleition: @escaping (NetworkResult<Any>) -> Void) {
        AF.request(baseURL + "/api/v1/auth/signin", method: .post, parameters: singin, encoder: JSONParameterEncoder.default).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(LoginResponse.self, from: data)
                    guard let isSuccess = json.success else { return }
                    if isSuccess {
                        compleition(.success(json.result))
                    }else {
                        compleition(.failure(json.error))
                    }
                }catch{
                    print("Decode Error Occured")
                }
            case .failure:
                compleition(.networkErr)
            }
        }
    }

    func SignUpAPI(signUp: User, completion: @escaping (NetworkResult<Any>)-> Void) {
        AF.request(baseURL + "/api/v1/auth/signup", method: .post, parameters: signUp, encoder: JSONParameterEncoder.default).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(SignUpResponse.self, from: data)
                    guard let isSuccess = json.success else { return }
                    if isSuccess {
                        completion(.success(true))
                    }else {
                        guard let error = json.error else { return }
                        completion(.success(error))
                    }
                }catch {
                    print("Decode Error Occured")
                }
            case .failure:
                completion(.networkErr)
            }
        }
    }
    
    func refreshAPI(token: TokenInfo,completion: @escaping (NetworkResult<Any>)-> Void) {
        let reissueToken = refreshToken(accessToken: token.accessToken, refreshToken: token.refreshToken)
        AF.request(baseURL + "/api/v1/auth/reissue", method: .post, parameters: reissueToken, encoder: JSONParameterEncoder.default).responseJSON { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let decoder = JSONDecoder()
                    let json = try decoder.decode(LoginResponse.self, from: data)
                    guard let isSuccess = json.success else { return }
                    if isSuccess {
                        guard let result = json.result else { return }
                        completion(.success(result))
                    }else {
                        guard let error = json.error else { return }
                        completion(.failure(error))
                    }
                }catch{
                    print("Decode Error Occured")
                }
            case .failure:
                completion(.networkErr)
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


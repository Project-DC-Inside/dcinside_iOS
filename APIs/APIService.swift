//
//  APIService.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/03.
//

import Foundation
import Alamofire
// API Service Enumerate 수정 필요함
enum NetworkError:Error {
    case badURL
    case serverError
    case decodeError
    case inputError
}

class APIService {
    //최초 생성시, 전역으로 사용가능하게한다.
    static let shared = APIService()
    
    private let HTTPHeaders = ["Content-Type": "application/json"]
    private let baseURL = "http://3.36.205.23:8080"
        
    private func URLGenerate(path : String, queryItems: [String: String]?) -> URLComponents {
        var components = URLComponents()
        
        let scheme = "http"
        let host = "52.78.99.238"
        let port = 8080
        
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        guard let queries = queryItems else { return components }
        
        components.queryItems = []
        for item in queries {
            components.queryItems?.append(URLQueryItem(name: item.key, value: item.value))
        }
        
        return components
    }
    
    func fetchGalleryList(galleryType: String, completion: @escaping (Result<[Gallery],NetworkError>) -> Void) {
        AF.request(URLGenerate(path: "/api/v1/galleries", queryItems: ["type": galleryType.uppercased()]).url!, method: .get, parameters: nil).validate(statusCode: 200..<300).responseJSON { response in
            guard let data = response.data else { return }
            switch response.result {
            case .success:
                do {
                    let galleryList = try JSONDecoder().decode(GalleryList.self, from: data)
                    if let res = galleryList.result {
                        completion(.success(res))
                    } else {
                        completion(.success([]))
                    }
                }catch {
                    completion(.failure(.decodeError))
                }
            case .failure:
                completion(.failure(.badURL))
            }
        }.resume()
    }
    
    func signInAction(signInInfo: SignInInfo, completion: @escaping (Result<SignInResult, NetworkError>) -> Void) {
        AF.request(URLGenerate(path: "/api/v1/auth/signin", queryItems: nil).url!, method: .post, parameters: signInInfo, encoder: JSONParameterEncoder.default).validate(statusCode: 200..<300).responseJSON { response in
            guard let data = response.data else { return }
            switch response.result {
            case .success:
                do {
                    let signInResponse = try JSONDecoder().decode(SignInResponse.self, from: data)
                    if signInResponse.success {
                        completion(.success(signInResponse.result!))
                    } else {
                        completion(.failure(NetworkError.inputError))
                    }
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure:
                completion(.failure(NetworkError.badURL))
            }
            
        }.resume()
    }
    
    func signUpAction(signUpInfo: SignUpInfo, completion: @escaping (Result<SignUpResponse, NetworkError>)-> Void) {
        AF.request(URLGenerate(path: "/api/v1/auth/signup", queryItems: nil).url!, method: .post, parameters: signUpInfo, encoder: JSONParameterEncoder.default).validate(statusCode: 200..<300).responseJSON { response in
            guard let data = response.data else { return }
            switch response.result {
            case .success:
                do {
                    let signUpResponse = try JSONDecoder().decode(SignUpResponse.self, from: data)
                    completion(.success(signUpResponse))
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure:
                completion(.failure(NetworkError.badURL))
            }
            
        }.resume()
    }
}

struct refreshToken : Codable {
    var accessToken: String
    var refreshToken: String
}


// enum 으로 상태도 표현해주자


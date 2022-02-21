//
//  APIService.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/03.
//

import Foundation
import Alamofire
import RxSwift
import RxAlamofire

// API Service Enumerate 수정 필요함
enum NetworkError:Error {
    case badURL
    case decodeError
}


class APIService {
    //최초 생성시, 전역으로 사용가능하게한다.
    static let shared = APIService()

    private let disposeBag = DisposeBag()
    
    private let HTTPHeaders = ["Content-Type": "application/json"]
    private let baseURL = "http://52.78.99.238:8080"
    
    private init() {} // 다른곳에서 초기화하지 못하게 해야해서..
    
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
    
    func SignInAPI(signIn: SignInInfo) -> Observable<Result<SignInResult, NetworkError>> {
        return Observable<Result<SignInResult, NetworkError>>.create { observer in
            AF.request(self.URLGenerate(path: "/api/v1/auth/signin", queryItems: nil).url!, method: .post, parameters: signIn, encoder: JSONParameterEncoder.default)
                .validate(statusCode: 200..<300).responseJSON { response in
                guard let data = response.data else { return }
                switch response.result {
                case .success:
                    do {
                        let signInResult = try JSONDecoder().decode(SignInResult.self, from: data)
                        //print(signInResult)
                        observer.onNext(.success(signInResult))
                        observer.onCompleted()
                    }catch {
                        observer.onNext(.failure(.decodeError))
                        observer.onCompleted()
                    }
                    
                case .failure:
                    observer.onNext(.failure(.badURL))
                    observer.onError(NetworkError.badURL)
                }
            }
            return Disposables.create()
        }
    }
    
    func SignUpAPI(signUp: SignUpInfo) -> Observable<Result<SignUpResult, NetworkError>> {
        return Observable<Result<SignUpResult, NetworkError>>.create { observer in
            AF.request(self.URLGenerate(path: "/api/v1/auth/signup", queryItems: nil).url!, method: .post, parameters: signUp, encoder: JSONParameterEncoder.default)
                .validate(statusCode: 200..<300).responseJSON { response in
                    guard let data = response.data else { return }
                    switch response.result {
                    case .success:
                        do {
                            let signUpResult = try JSONDecoder().decode(SignUpResult.self, from: data)
                            print(signUpResult)
                            observer.onNext(.success(signUpResult))
                            observer.onCompleted()
                        }catch {
                            print("Decode Err")
                            observer.onNext(.failure(.decodeError))
                            observer.onCompleted()
                        }
                    case .failure:
                        print("fail")
                        observer.onNext(.failure(.badURL))
                        observer.onCompleted()
                    }
            }
            return Disposables.create()
        }
    }
    
    func fetchGalleryList(type: String) -> Observable<Result<[Gallery], NetworkError>> {
        return Observable<Result<[Gallery], NetworkError>>.create { observer in
            AF.request(self.URLGenerate(path: "/api/v1/galleries", queryItems: ["type": type]).url!, method: .get, parameters: nil).validate(statusCode: 200..<300).responseJSON { response in
                guard let data = response.data else { return }
                print(response)
                switch response.result {
                case .success:
                    do {
                        let galleryList = try JSONDecoder().decode(GalleryList.self, from: data)
                        print(galleryList)
                        if let res = galleryList.result {
                            observer.onNext(.success(res))
                        }
                        observer.onCompleted()
                    }catch {
                        print("decode Err")
                        observer.onNext(.failure(.decodeError))
                        observer.onCompleted()
                    }
                case .failure:
                    observer.onNext(.failure(.badURL))
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
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


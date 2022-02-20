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
    
    func SignInAPI(signIn: SignInInfo) -> Observable<Result<SignInResult, NetworkError>> {
        return Observable<Result<SignInResult, NetworkError>>.create { observer in
            AF.request(self.baseURL + "/api/v1/auth/signin", method: .post, parameters: signIn, encoder: JSONParameterEncoder.default)
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
            AF.request(self.baseURL + "/api/v1/auth/signup", method: .post, parameters: signUp, encoder: JSONParameterEncoder.default)
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
    
    func fetchGalleryList() -> Observable<Result<[Gallery], NetworkError>> {
        return Observable<Result<[Gallery], NetworkError>>.create { observer in
            AF.request(self.baseURL + "/api/v1/galleries", method: .get, parameters: nil).validate(statusCode: 200..<300).responseJSON { response in
                guard let data = response.data else { return }
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
        
//
//    func SingInAPI(singin: Login, compleition: @escaping (Result<LoginResponse, NetworkError>) -> Void) {
//        AF.request(baseURL + "/api/v1/auth/signin", method: .post, parameters: singin, encoder: JSONParameterEncoder.default).responseJSON { response in
//            switch response.result {
//            case .success:
//                guard let data = response.data else { return }
//                do {
//                    let decoder = JSONDecoder()
//                    let json = try decoder.decode(LoginResponse.self, from: data)
//                    compleition(.success(json))
//                }catch{
//                    print("Decode Error Occured")
//                }
//            case .failure:
//                compleition(.failure(.badURL))
//            }
//        }
//    }
//
//    func SignUpAPI(signUp: User, completion: @escaping (Result<Bool, NetworkError>)-> Void) {
//        AF.request(baseURL + "/api/v1/auth/signup", method: .post, parameters: signUp, encoder: JSONParameterEncoder.default).responseJSON { response in
//            switch response.result {
//            case .success:
//                guard let data = response.data else { return }
//                do {
//                    let decoder = JSONDecoder()
//                    let json = try decoder.decode(SignUpResponse.self, from: data)
//                    guard let isSuccess = json.success else { return }
//                    completion(.success(isSuccess))
//                }catch {
//                    print("Decode Error Occured")
//                }
//            case .failure:
//                completion(.failure(.badURL))
//            }
//        }
//    }
//
//    func DecodeToken()-> TokenInfo? {
//        let decoder = PropertyListDecoder()
//        guard let encodedToken = UserDefaults.standard.object(forKey: "token") as? Data else { return nil }
//        do {
//            let token = try? decoder.decode(TokenInfo.self, from: encodedToken)
//            return token
//        }catch {
//            return nil
//        }
//    }
//
//    func RefreshAPI(completion: @escaping (Result<LoginResponse, NetworkError>)-> Void) {
//        print("REFRESH!!")
//        guard let token = DecodeToken() else { return }
//        print("TK",token)
//        let reissueToken = refreshToken(accessToken: token.accessToken, refreshToken: token.refreshToken)
//        AF.request(baseURL + "/api/v1/auth/reissue", method: .post, parameters: reissueToken, encoder: JSONParameterEncoder.default).responseJSON { response in
//            switch response.result {
//            case .success:
//                guard let data = response.data else { return }
//                do {
//                    let decoder = JSONDecoder()
//                    let json = try decoder.decode(LoginResponse.self, from: data)
//                    guard let isSuccess = json.success else { return }
//                    completion(.success(json))
//                }catch{
//                    print("Decode Error Occured")
//                }
//            case .failure:
//                completion(.failure(.badURL))
//                break
//            }
//        }
//
//    }
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


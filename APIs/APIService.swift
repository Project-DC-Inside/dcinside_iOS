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

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "잘못된 주소입니다."
        case .decodeError:
            return "Decode 실패"
        case .inputError:
            return "입력 값에 대해 확인해 주세요"
        case .serverError:
            return "서버에서 데이터를 가져오지 못했어요"
        }
    }
}

class APIService {
    //최초 생성시, 전역으로 사용가능하게한다.
    static let shared = APIService()
    
    private init() {}
    
    private let HTTPHeaders = ["Content-Type": "application/json"]
    private let baseURL = "http://3.36.205.23:8080"
    
    private func makeHeader() -> HTTPHeaders {
        let token = KeyChain.shared.getItem(key: KeyChain.token) as! String
        print(token)
        return ["Authorization": "Bearer " + token]
    }
        
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
    
    func checkNonMemberPassword(unsignedPostPasswordChecker: UnsignedPostPasswordChecker,
                                completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        AF.request(URLGenerate(path: "/api/v1/posts/non-member/access", queryItems: nil).url!, method: .put, parameters: unsignedPostPasswordChecker, encoder: JSONParameterEncoder.default, headers: makeHeader()).validate(statusCode: 200..<300).responseJSON { response in
            
            guard let data = response.data else { return }
            switch response.result {
            case .success:
                do {
                    let checker = try JSONDecoder().decode(UnsignedPostPasswordResponse.self, from: data)
                    if checker.success {
                        completion(.success(true))
                    } else {
                        completion(.failure(NetworkError.inputError))
                    }
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure:
                completion(.failure(NetworkError.badURL))
            }
        }
    }
    
    func submitModifyPostLogOff(postNumber: Int, post: ModifyingUnSignedEntity, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        AF.request(URLGenerate(path: "/api/v1/posts/non-member/\(postNumber)", queryItems: nil).url!, method: .put, parameters: post, encoder: JSONParameterEncoder.default, headers: nil).validate(statusCode: 200..<300).responseJSON { response in
            
            guard let data = response.data else { return }
            switch response.result {
            case .success:
                do {
                    let modifyingUnSignedEntityResponse = try JSONDecoder().decode(ModifyingUnSignedEntityResponse.self, from: data)
                    if modifyingUnSignedEntityResponse.success {
                        completion(.success(true))
                    } else {
                        completion(.failure(NetworkError.inputError))
                    }
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure:
                completion(.failure(NetworkError.badURL))
            }
        }
    }
    
    func submitModifyPostLogIn(postNumber: Int, post: ModifyingSignedEntity, completion: @escaping (Result<Bool, NetworkError>) -> Void) {
        print(post)
        AF.request(URLGenerate(path: "/api/v1/posts/\(postNumber)", queryItems: nil).url!, method: .put, parameters: post, encoder: JSONParameterEncoder.default, headers: makeHeader()).validate(statusCode: 200..<300).responseJSON { response in
            
            guard let data = response.data else { return }
            switch response.result {
            case .success:
                do {
                    let modifyingSignedEntityResponse = try JSONDecoder().decode(ModifyingSignedEntityResponse.self, from: data)
                    if modifyingSignedEntityResponse.success {
                        completion(.success(true))
                    } else {
                        completion(.failure(NetworkError.inputError))
                    }
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure:
                completion(.failure(NetworkError.badURL))
            }
        }
    }
    
    
    func submitPostLogOff(post: PostSubmitLogOff, completion: @escaping (Result<Int, NetworkError>) -> Void) {
        AF.request(URLGenerate(path: "/api/v1/posts/non-member", queryItems: nil).url!, method: .post, parameters: post, encoder: JSONParameterEncoder.default).responseJSON { response in
            
            guard let data = response.data else { return }
            guard let statusCode = response.response?.statusCode else { return }
            
            switch response.result {
            case .success:
                do {
                    let postSubmitResult = try JSONDecoder().decode(PostSubmitResult.self, from: data)
                    if postSubmitResult.success {
                        completion(.success(postSubmitResult.result!))
                    } else {
                        completion(.failure(NetworkError.inputError))
                    }
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure:
                print("FAIL")
                completion(.failure(NetworkError.badURL))
            }
        }.resume()
        
        
    }
    
    func submitPostLogIn(post: PostSubmitLogIn, completion: @escaping (Result<Int, NetworkError>) -> Void) {
        print(post)
        AF.request(URLGenerate(path: "/api/v1/posts", queryItems: nil).url!, method: .post, parameters: post, encoder: JSONParameterEncoder.default, headers: makeHeader()).validate(statusCode: 200..<300).responseJSON { response in
            
            guard let data = response.data else { return }
            switch response.result {
            case .success:
                do {
                    let postSubmitResult = try JSONDecoder().decode(PostSubmitResult.self, from: data)
                    if postSubmitResult.success {
                        completion(.success(postSubmitResult.result!))
                    } else {
                        completion(.failure(NetworkError.inputError))
                    }
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure:
                completion(.failure(NetworkError.badURL))
            }
        }
    }
    
    func fetchPostInfo(postId: Int, completion: @escaping (Result<PostInfo, NetworkError>) -> Void) {
        // Todo: 에러 처리 해야함, 리트라이랑
        AF.request(URLGenerate(path: "/api/v1/posts/\(postId)", queryItems: nil).url!, method: .get, parameters: nil).responseJSON { response in
            guard let data = response.data else { return }
            switch response.result {
            case .success:
                do {
                    let postInfo = try JSONDecoder().decode(PostResponse.self, from: data)
                    print(postInfo)
                    if postInfo.success {
                        completion(.success(postInfo.result!))
                    } else {
                        completion(.failure(.inputError))
                    }
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure:
                completion(.failure(.badURL))
            }
        }.resume()
    }
    
    func fetchPostList(postListRequest: PostListRequest, completion: @escaping (Result<[PostInfo], NetworkError>) -> Void) {
        let reqData = postListRequest.lastPostId != nil ? "\(postListRequest.lastPostId!)" : ""
        print(reqData)
        AF.request(URLGenerate(path: "/api/v1/posts", queryItems: ["galleryId": "\(postListRequest.galleryId)", "lastPostId": reqData]).url!, method: .get, parameters: nil).responseJSON { response in
            guard let data = response.data else { return }
            switch response.result {
            case .success:
                do {
                    let PostInfos = try JSONDecoder().decode(PostListTotalResponse.self, from: data)
                    
                    print(PostInfos)
                    if PostInfos.success {
                        completion(.success(PostInfos.result ?? []))
                    } else {
                        completion(.failure(NetworkError.inputError))
                    }
                }catch {
                    completion(.failure(.decodeError))
                }
            case .failure:
                print("EE")
                completion(.failure(.badURL))
            }
        }.resume()
        
    }
    
    func refreshToken(completion: @escaping (Result<SignInResponse, NetworkError>)-> Void) {
        guard let token = KeyChain.shared.getItem(key: KeyChain.token) as? String else { return }
        guard let refresh = KeyChain.shared.getItem(key: KeyChain.refresh) as? String else { return }
        
        let param = RefreshTokenStructure(accessToken: token, refreshToken: refresh)
        AF.request(URLGenerate(path: "/api/v1/auth/reissue", queryItems: nil).url!, method: .post, parameters: param, encoder: JSONParameterEncoder.default).responseJSON { response in
            guard let data = response.data else { return }
            switch response.result {
            case .success:
                do {
                    let res = try JSONDecoder().decode(SignInResponse.self, from: data)
                    if res.success {
                        completion(.success(res))
                    } else {
                        completion(.failure(.inputError))
                    }
                } catch {
                    completion(.failure(.decodeError))
                }
            case .failure:
                completion(.failure(.badURL))
            }
        }.resume()
    }
    
    func fetchGalleryList(galleryType: String, completion: @escaping (Result<[GalleryResponse],NetworkError>) -> Void) {
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
    
    func submitNewGallery(gallery: GalleryRequest, completion: @escaping (Result<GalleryMakeResponse, NetworkError>)-> Void) {
        AF.request(URLGenerate(path: "/api/v1/galleries", queryItems: nil).url!, method: .post, parameters: gallery, encoder: JSONParameterEncoder.default, headers: makeHeader(), interceptor: APIReuqestInterceptor()).responseJSON { response in
            guard let data = response.data else { return }
            switch response.result {
            case .success:
                do {
                    let galleryResult = try JSONDecoder().decode(GalleryMakeResponse.self, from: data)
                    print(galleryResult)
                    completion(.success(galleryResult))
                }catch {
                    print("Decode Err")
                    completion(.failure(.decodeError))
                }
            case .failure:
                print("fail")
                completion(.failure(.badURL))
            }
        }
        .resume()
    }
}

struct RefreshTokenStructure : Codable {
    let accessToken: String
    let refreshToken: String
}


// enum 으로 상태도 표현해주자

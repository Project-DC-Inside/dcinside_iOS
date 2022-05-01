//
//  APIRequestInterceptor.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/04/20.
//

import Foundation
import Alamofire

class APIReuqestInterceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        let token = KeyChain.shared.getItem(key: KeyChain.token) as! String
        var urlRequest = urlRequest
        urlRequest.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        completion(.success(urlRequest))
    }
    
    // Todo:
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("RETRY!!")
        APIService.shared.refreshToken { result in
            switch result {
            case .success(let response):
                KeyChain.shared.updateItem(value: response.result?.accessToken, key: KeyChain.token)
                KeyChain.shared.updateItem(value: response.result?.refreshToken, key: KeyChain.refresh)
                completion(.retry)
            case .failure(let error):
                completion(.doNotRetryWithError(error))
            }
        }
    }
}

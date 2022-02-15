//
//  SignInViewModel.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2022/02/14.
//

import Foundation
import RxCocoa
import RxSwift

enum SignInAction {
    case success
    case nonExist
    case networkErr
}

struct SignInViewModel {
    let disposeBag = DisposeBag()
    
    // viewModel -> view
    //let requestData: Driver<SignInAction>
    let errorCheck: Signal<Alert>
    let nextCheck: Driver<Void>
    
    // view -> viewModel
    let submitButtonTapped = PublishRelay<Void>()
    let idInfo = BehaviorRelay<String?>(value: "")
    let pwInfo = BehaviorRelay<String?>(value: "")
    
    let logInfo: Observable<LoginInfo>
    let idDriver: Signal<String?>
    
    init(model: SignInModel = SignInModel()) {
        let tapped = self.submitButtonTapped
            .asObservable()
      
        self.logInfo = Observable.combineLatest(idInfo, pwInfo)
            .compactMap { info -> LoginInfo? in
                guard let id = info.0, let pw = info.1 else { return nil }
                print(LoginInfo(id: id, pw: pw))
                return LoginInfo(id: id, pw: pw)
            }.asObservable()
        
        let requestResult = tapped.withLatestFrom(self.logInfo) { _, LoginInfo in
            return LoginInfo
        }.flatMapLatest { info in
            return APIService.shared.SignInAPI(signIn: info)
        }
        
        let requestData = requestResult
            .compactMap { data -> SignInAction in
                switch data {
                case let .success(result):
                    guard let token = result.token else { return .nonExist }
                    KeyChain.shared.addItem(key: "token", value: token.token)
                    KeyChain.shared.addItem(key: "token", value: token.refreshToken)
                    print("SUCCESSTOKEN")
                    return .success
                case let .failure(e) :
                    print(e.localizedDescription)
                    return .networkErr
                default:
                    return .networkErr
                }
            }
            .asObservable()
            //.asDriver(onErrorDriveWith: .empty())
        let t = requestData.subscribe{
            print($0)
        }.disposed(by: disposeBag)
        
        self.errorCheck = requestData
            .filter { $0 != .success }
            .map { action in
                return model.setAlert(action: action)
            }
            .asSignal(onErrorSignalWith: .empty())
        
        self.nextCheck = requestData
            .filter { $0 == .success }
            .map { action -> Void in
                return Void()
            }
            .asDriver(onErrorDriveWith: .empty())
        
        idDriver = idInfo.asSignal(onErrorSignalWith: .empty())

    }
}

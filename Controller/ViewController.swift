//
//  ViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/11/27.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBAction func loginButton(_ sender: Any) {
        print("LOG IN!")
        //self.navigationController?.popViewController(animated: true)
        guard let username = idField.text else { return }
        guard let password = passwordField.text else { return }
        let log = Login(username: username, password: password)
        APIService.shared.SingInAPI(singin: log) { response in
            switch response {
            case .success(let message):
                guard let token = message as? TokenInfo else {
                    return
                }
                do {
                    let useToken = try? PropertyListEncoder().encode(token)
                    UserDefaults.standard.set(useToken, forKey: "token")
                    NotificationCenter.default.post(name: Notification.Name("token"), object: useToken, userInfo: nil)
                }catch{
                    return
                }
                UserDefaults.standard.set(log.username, forKey: "userInfo")
                self.navigationController?.popViewController(animated: true)
            case .failure(let err):
                print(err)
                guard let e = err as? ErrInfo else { return }
                self.ErrMessage(error: e)
            default:
                print("FAIL")
            }
            
        }
    }
    
    private func ErrMessage(error: ErrInfo) {
        let alert = UIAlertController(title: "로그인 실패!", message: error.message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    @IBAction func signUpButton(_ sender: Any) {
        
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") else {return}
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HELLO")
        // Do any additional setup after loading the view.
    }

}


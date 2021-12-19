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
        APIService.shared.loginAPI(SingIn: log) { response in
            print("RPONS ", response)
            switch response {
            case .success(let message):
                print(message)
                var ParsedData : tokenInfo? = nil
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: message, options: .prettyPrinted)
                    let json = try JSONDecoder().decode(tokenInfo.self, from: jsonData)
                    ParsedData = json
                }catch (let err) {
                    print("FUCK ", err.localizedDescription)
                }
                guard let data = ParsedData else { return }
                print(type(of: data))
                UserDefaults.standard.set(message, forKey: "token")

                NotificationCenter.default.post(name: Notification.Name("token"), object: data, userInfo: nil)
                
                self.navigationController?.popViewController(animated: true)
            default:
                print("FAIL")
            }
            
        }
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


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

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButton(_ sender: Any) {
        print("LOG IN!")
        self.dismiss(animated: true, completion: nil)
        /*
         APIService.shared.loginAPI(compleition: { response in
            switch(response) {
            case .success(let data):
                print(data)
            case .pathErr://(let data):
                print(response)
            case .networkFail:
                print("FAIL")
            case .serverErr:
                print("FUCK")
            default:
                print("DEF")
            }
        })
         */
        
        
    }
    @IBAction func signUpButton(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") else {return}
        nextVC.modalTransitionStyle = .coverVertical
        nextVC.modalPresentationStyle = .fullScreen
        self.present(nextVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}


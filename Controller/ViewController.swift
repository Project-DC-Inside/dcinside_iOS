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
        APIService.shared.loginAPI { (response, error) in
        case .error:
        case .response
            print(error)
            
        }
        
    }
    @IBAction func signUpButton(_ sender: Any) {
        guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") else {return}
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


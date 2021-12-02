//
//  SignUpViewController.swift
//  dcinside_iOS
//
//  Created by 황지웅 on 2021/12/02.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var idChecker: UILabel!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var nicknameChecker: UILabel!
    
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordCheckField: UITextField!
    @IBOutlet weak var passwordChecker: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var emailCert: UIButton!
    @IBOutlet weak var certiField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.emailCert.isEnabled = false
        // Do any additional setup after loading the view.
    }
}

extension SignUpViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @objc func tap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func isValidEmail(email: String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailValid = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            
            return emailValid.evaluate(with: email)
        }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.idField {
            self.nicknameField.becomeFirstResponder()
        }else if textField == self.nicknameField {
            self.passwordField.becomeFirstResponder()
        }else if textField == self.passwordField {
            self.passwordCheckField.becomeFirstResponder()
        }else if textField == self.passwordCheckField {
            self.emailField.becomeFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let count = range.location
        if textField == self.idField {
            if count < 5 || count >= 20 {
                self.idChecker.text = "글자가 부족하거나 넘칩니다."
            }else {
                self.idChecker.text = "Check"
            }
        }
        if textField == self.nicknameField {
            if count > 20 {
                self.nicknameChecker.text = "20자가 넘네요.."
            }
            else { self.nicknameChecker.text = "Check" }
        }
        
        if textField == self.passwordField {
            
        }
        if textField == self.emailField {
            if textField.text != nil {
                if isValidEmail(email: textField.text!) {
                    self.emailCert.isEnabled = true
                    self.emailCert.setTitleColor(.white, for: .normal)
                }else {
                    self.emailCert.isEnabled = false
                    self.emailCert.setTitleColor(.gray, for: .normal)
                }
            }
        }
        return true
    }
}

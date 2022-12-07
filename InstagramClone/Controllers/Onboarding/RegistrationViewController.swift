//
//  RegistrationViewController.swift
//  InstagramClone
//
//  Created by 정주호 on 06/12/2022.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let userNameField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "User name"
        tf.returnKeyType = .next
        tf.leftViewMode = .always
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = Constants.cornerRadius
        tf.backgroundColor = .secondarySystemBackground
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.secondaryLabel.cgColor
        return tf
    }()
    
    private let emailField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email Address"
        tf.returnKeyType = .next
        tf.leftViewMode = .always
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = Constants.cornerRadius
        tf.backgroundColor = .secondarySystemBackground
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.secondaryLabel.cgColor
        return tf
    }()
    
    private let userPasswordField: UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true
        tf.placeholder = "Password.."
        tf.returnKeyType = .continue
        tf.leftViewMode = .always
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.layer.masksToBounds = true
        tf.layer.cornerRadius = Constants.cornerRadius
        tf.backgroundColor = .secondarySystemBackground
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.secondaryLabel.cgColor
        return tf
    }()
    
    private let registerButon: UIButton = {
        let btn = UIButton()
        btn.setTitle("Sign up", for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = Constants.cornerRadius
        btn.backgroundColor = .systemGreen
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerButon.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        
        userNameField.delegate = self
        emailField.delegate = self
        userPasswordField.delegate = self
        
        view.addSubview(userNameField)
        view.addSubview(emailField)
        view.addSubview(userPasswordField)
        view.addSubview(registerButon)
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        userNameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top+100, width: view.width-40, height: 52)
        emailField.frame = CGRect(x: 20, y: userNameField.bottom+10, width: view.width-40, height: 52)
        userPasswordField.frame = CGRect(x: 20, y: emailField.bottom+10, width: view.width-40, height: 52)
        registerButon.frame = CGRect(x: 20, y: userPasswordField.bottom+10, width: view.width-40, height: 52)
    }
    
    @objc private func registerButtonTapped() {
        userNameField.resignFirstResponder()
        emailField.resignFirstResponder()
        userPasswordField.resignFirstResponder()
        
        guard let email = emailField.text, !email.isEmpty,
              let userName = userNameField.text, !userName.isEmpty,
              let password = userPasswordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        AuthManager.shared.registerNewUser(userName: userName, email: email, password: password) { registered in
            DispatchQueue.main.async {
                if registered {
                    
                }
                else {
                    
                }
            }
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            userPasswordField.becomeFirstResponder()
        }
        else {
            registerButtonTapped()
        }
        return true
    }
}

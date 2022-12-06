//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by 정주호 on 06/12/2022.
//

import SafariServices
import UIKit

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let userNameField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "User name or Email.."
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
    
    private let loginButon: UIButton = {
        let btn = UIButton()
        btn.setTitle("Login", for: .normal)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = Constants.cornerRadius
        btn.backgroundColor = .systemBlue
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    private let termsButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Terms of Serviced", for: .normal)
        btn.setTitleColor(.secondaryLabel, for: .normal)
        return btn
    }()
    
    private let privacyButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Privacy Policy", for: .normal)
        btn.setTitleColor(.secondaryLabel, for: .normal)
        return btn
    }()
    
    private let createAccountButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(.label, for: .normal)
        btn.setTitle("New User? Create an Account", for: .normal)
        return btn
    }()
    
    private let headerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        view.addSubview(backgroundImageView)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButon.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
        
        userNameField.delegate = self
        userPasswordField.delegate = self
        addSubViews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(x: 0,
                                  y: 0.0,
                                  width: view.width,
                                  height: view.height/3.0)
        
        userNameField.frame = CGRect(x: 25,
                                     y: headerView.bottom + 40,
                                     width: view.width-50,
                                     height: 52.0)
        
        userPasswordField.frame = CGRect(x: 25,
                                         y: userNameField.bottom + 10,
                                         width: view.width-50,
                                         height: 52.0)
        
        loginButon.frame = CGRect(x: 25,
                                  y: userPasswordField.bottom + 10,
                                  width: view.width-50,
                                  height: 52.0)
        
        createAccountButton.frame = CGRect(x: 25,
                                           y: loginButon.bottom + 10,
                                           width: view.width-50,
                                           height: 52.0)
        
        termsButton.frame = CGRect(x: 10,
                                   y: view.height-view.safeAreaInsets.bottom-100,
                                   width: view.width-20,
                                   height: 50)
        
        privacyButton.frame = CGRect(x: 10,
                                     y: view.height-view.safeAreaInsets.bottom-50,
                                     width: view.width-20,
                                     height: 50)
        configureHeaderView()
        
    }
    
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        
        guard let backgroundView = headerView.subviews.first else { return }
        
        backgroundView.frame = headerView.bounds
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: headerView.width/4.0,
                                 y: view.safeAreaInsets.top,
                                 width: headerView.width/2.0,
                                 height: headerView.height - view.safeAreaInsets.top)
    }
    
    private func addSubViews() {
        view.addSubview(userNameField)
        view.addSubview(userPasswordField)
        view.addSubview(loginButon)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
        
    }
    
    @objc private func didTapLoginButton() {
        userNameField.resignFirstResponder()
        userPasswordField.resignFirstResponder()
        
        guard let userNameEmail = userNameField.text, !userNameEmail.isEmpty,
        let userPassword = userPasswordField.text, !userPassword.isEmpty, userPassword.count >= 8 else {
            return
        }
        
    }
    
    @objc private func didTapTermButton() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
            
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapPrivacyButton() {
        guard let url = URL(string: "https://help.instagram.com/155833707900388") else {
            return
            
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        present(vc, animated: true)
    }
    
    
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            userPasswordField.becomeFirstResponder()
        } else if textField == userPasswordField {
            didTapLoginButton()
        }
        return true
    }
}

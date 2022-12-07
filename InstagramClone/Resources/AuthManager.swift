//
//  AuthManager.swift
//  InstagramClone
//
//  Created by 정주호 on 06/12/2022.
//

import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    // MARK: - Public
    
    public func registerNewUser(userName: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        DatabaseManager.shared.canCreateNewUser(with: email, username: userName) { canCreate in
            if canCreate {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        completion(false)
                        return
                    }
                    DatabaseManager.shared.insertNewUser(with: email, username: userName) { inserted in
                        if inserted {
                            completion(true)
                            return
                        }
                        else {
                            completion(false)
                            return
                        }
                    }
                }
            }
            else {
                completion(false)
            }
        }
    }
    
    public func loginUser(userName: String?, email: String?, password: String, completion: @escaping ((Bool) -> Void)) {
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        } else if let userName = userName {
            print(userName)
        }
        
        
    }

}

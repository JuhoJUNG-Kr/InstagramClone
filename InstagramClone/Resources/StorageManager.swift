//
//  StorageManager.swift
//  InstagramClone
//
//  Created by 정주호 on 06/12/2022.
//

import FirebaseStorage

public class StorageManager {
    
    static let shared = StorageManager()
    
    public enum IGStoregeManagerError: Error {
        case failedToDownload
    }
    
    // MARK: - Private
    private let bucket = Storage.storage().reference()

    
    // MARK: - Public
    
    public func uploadUserPost(model: UserPost, completion: @escaping(Result<URL, Error>) -> Void) {
        
    }
    
    public func downloadImage(with reference: String, completion: @escaping(Result<URL, IGStoregeManagerError>) -> Void) {
        bucket.child(reference).downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        }
    }

}

public enum UserPostType {
    case photo, video
}

public struct UserPost {
    let postType: UserPostType
}

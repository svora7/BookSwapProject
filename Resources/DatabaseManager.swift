//
//  DatabaseManager.swift
//  BookSwapProject
//
//  Created by Shivani Vora on 1/7/22.
//

import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    //MARK: - Public
    
    /// Check if email is available
    ///  - Parameters
    ///      - email: String representing email
    public func canCreateNewUser(with email: String, completion: (Bool) -> Void){
        completion(true)
        
    }
    
    /// Inserts new user into database
    ///  - Parameters
    ///      - email: String representing email
    ///      - completion: Async callback for result if database entry succeeded
    public func insertNewUser(with email: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["email": email]) { error, _ in
            if error == nil {
                //succeeded
                completion(true)
                return
            }
            else {
                //failed
                completion(false)
                return
            }
        }
        
    }
    
}

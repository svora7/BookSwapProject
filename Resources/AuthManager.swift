//
//  AuthManager.swift
//  BookSwapProject
//
//  Created by Shivani Vora on 1/8/22.
//

import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    // MARK -Public
    
    public func registerNewUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        //Check if email is available
         
        DatabaseManager.shared.canCreateNewUser(with: email) { canCreate in
            if canCreate {
                /*
                 - Create Account
                 - Insert Account to Database
                */
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        //Firebase auth could not create account
                        completion(false)
                        return
                    }
                    
                    // Insert into database
                    DatabaseManager.shared.insertNewUser(with: email) { inserted in
                        if inserted {
                            completion(true)
                            return
                        }
                        else {
                            //failed to insert into database
                            completion(false)
                            return
                        }
                        
                    }
                }
            }
            
            else {
                //either username or email does not exist
                completion(false)
            }
            
        }
        
        
        
    }
    
    public func loginUser(email: String, password: String, completion: @escaping (Bool) -> Void) {
        let email  = email
        //email log in
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            guard authResult != nil, error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }
}

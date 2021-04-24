//
//  Service.swift
//  LogUserInApp
//
//  Created by Sebastian Sciuba on 23/04/2021.
//

import UIKit
import Firebase
import CodableFirebase

struct AuthCredentials {
    
    let fullName : String
    let email : String
    let password : String
}

struct Service {
    
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func resetPassword(withEmail email: String, completion: SendPasswordResetCallback? ) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
    
    static func registerUser(withCredentials credentials:AuthCredentials, completion: @escaping( (Error?, DatabaseReference) -> Void)) {
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
            if let error = error {
                completion(error, Database.database().reference().child("users"))
                return
            }
            guard let uid = result?.user.uid else {return}
            
            let values = ["fullName" : credentials.fullName, "email" : credentials.email , "password" : credentials.password]
            Database.database().reference().child("users").child(uid).updateChildValues( values, withCompletionBlock: completion)
        }
    }
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value else {return}
            do {
                let user = try FirebaseDecoder().decode(User.self, from: value)
                completion(user)
            } catch {
                print("DEBUG: Error masage fetch user: \(error.localizedDescription)")
            }
        }
    }
}


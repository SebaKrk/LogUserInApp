//
//  Service.swift
//  LogUserInApp
//
//  Created by Sebastian Sciuba on 23/04/2021.
//

import UIKit
import Firebase
import CodableFirebase
import GoogleSignIn
import FBSDKLoginKit

struct AuthCredentials {
    
    let fullName : String
    let email : String
    let password : String
}

struct Service {
    
    //    MARK: - Login&Register by mail
    
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
    //    MARK: - Fetch User
    
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
    
    //    MARK: - sign In With Google
    
    static func signInWithGoogle(didSignInFor user: GIDGoogleUser, completion: @escaping( (Error?, DatabaseReference) -> Void)) {
        guard let authentication = user.authentication else { return }
        let credencial = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credencial) { (result, error) in
            if let error = error {
                print("DEBUG: Error GoogleSigIn - \(error.localizedDescription)")
                return
            }
            guard let uid = result?.user.uid else { return }
            
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
                if !snapshot.exists() {
                    print("DEBUG: User not exist, create a user")
                    
                    guard let email = result?.user.email else {return}
                    guard  let fullName = result?.user.displayName else {return}
                    
                    let values = ["email" : email, "fullName" : fullName] as [String : Any]
                    Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: completion)
                } else {
                    print("DEBUG: User allredy exitst")
                    completion(error,Database.database().reference().child("users").child(uid))
                }
            }
        }
    }
    //    MARK: - sign In With Facebook
    
    static func signInWithFacebook(on vc: UIViewController,completion1: @escaping ((AuthDataResult?, Error?)-> Void) ,completion: @escaping( (Error?, DatabaseReference) -> Void)) {
        
        let logiManager = LoginManager()
        logiManager.logIn(permissions:  ["public_profile", "email"], from: vc) { (result, error) in
            if let error = error {
                print("DEBUG: Error LogIn FB - \(error.localizedDescription)")
                return
            }
            let accessToken = AccessToken.current
            guard let accessTokenString = accessToken?.tokenString else { return }
            let credencial = FacebookAuthProvider.credential(withAccessToken: accessTokenString)
            
            Auth.auth().signIn(with: credencial) { (result, error) in
                if let error = error {
                    print("DEBUG: Error FireBase signIn FB - \(error.localizedDescription)")
                    completion1(result, error)
                    return
                }
                guard let uid = result?.user.uid else { return }
                Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
                    if !snapshot.exists() {
                        print("DEBUG: User not exist , create user...")
                        guard let email = result?.user.email else { return }
                        guard let fullname = result?.user.displayName else { return }
                        
                        let values = ["email": email, "fullName": fullname]
                        Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: completion)
                    } else {
                        print("DEBUG: User allredy exitst")
                        completion(error,Database.database().reference().child("users").child(uid))
                    }
                }
            }
        }
    }
    
}


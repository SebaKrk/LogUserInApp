//
//  AuthenticationViewModel.swift
//  LogUserInApp
//
//  Created by Sebastian Sciuba on 22/04/2021.
//

import Foundation

protocol AuthenticationViewModel {
    var formIsValid : Bool {get}
}

struct LoginViewModel : AuthenticationViewModel {
    
    var email : String?
    var password : String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}

struct ResetPasswordViewModel: AuthenticationViewModel {
    var email: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
    }
}
struct RegistrationViewModel : AuthenticationViewModel {
    var email : String?
    var fullName: String?
    var password : String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false
            && fullName?.isEmpty == false
            && password?.isEmpty == false
        
    }
}

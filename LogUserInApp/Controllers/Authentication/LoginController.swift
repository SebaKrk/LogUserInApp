//
//  LoginController.swift
//  LogUserInApp
//
//  Created by Sebastian Sciuba on 20/04/2021.
//

import UIKit
import GoogleSignIn

protocol AuthenticationDelegate : class {
    func authorezationComplete()
}

class LoginController : UIViewController {
    
    var delegate : AuthenticationDelegate?
    
    private var viewModel = LoginViewModel()
    
    private let backgroundView = UIImageView(image: #imageLiteral(resourceName: "loginPage"))
    
    private let titleLabel = CostumLabel(title: "Login", size: 42, color: .white)
    private let emailTextField = CostumTextField(placeHolder: "Email", colorText: .white, isSecureText: false)
    private let passwordTextField = CostumTextField(placeHolder: "Password", colorText: .white, isSecureText: true)
    
    private let loginButton : CostumButton = {
        let button = CostumButton(text: "Login", textColor: .white, type: .system)
        button.addTarget(self, action: #selector(handleLogUserIn), for: .touchUpInside)
        button.backgroundColor = UIColor(white: 1, alpha: 0)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        return button
    }()
    
    private let forgetPasswordButton : CostumTextButton = {
        let button = CostumTextButton(text: "Forgot Password?", textColor: .white, type: .system)
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
        return button
    }()
    
    private let registerButton : CostumTextButton2 = {
        let button = CostumTextButton2(text1: "New Here?", text2: "Register", textColor: .white, widht: 80, type: .system)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    private let appleButton : CostumIcon = {
        let button = CostumIcon(color: .white, name: "apple")
        button.addTarget(self, action: #selector(handleApple), for: .touchUpInside)
        return button
    }()
    
    private let facebookButton : CostumIcon = {
        let button = CostumIcon(color: .white, name: "facebook")
        button.addTarget(self, action: #selector(handleFacebook), for: .touchUpInside)
        return button
    }()
    
    private let gmailButton : CostumIcon = {
        let button = CostumIcon(color: .white, name: "google")
        button.addTarget(self, action: #selector(handleGmail), for: .touchUpInside)
        return button
    }()
    
    //    MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
        setupStackView()
        configureTextFieldObservers()
        configureGoogleSignIn()
        self.dismissKeyboard()
        
    }
    
    //    MARK: - Action
    
    @objc func handleForgotPassword() {
        let nav = ResetPasswordController()
        nav.email = emailTextField.text
        nav.delegate = self
        navigationController?.pushViewController(nav, animated: true)
    }
    @objc func handleLogUserIn() {
        
        guard let emial = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        showActivitiIndicator(true)
        
        Service.logUserIn(withEmail: emial, password: password) { (result, error) in
            self.showActivitiIndicator(false)
            if let error = error {
                self.showMasage(withTitle: "Error", message: error.localizedDescription)
                return
            } else {
                self.delegate?.authorezationComplete()
            }
        }
    }
    @objc func handleRegister() {
        let nav = RegisterController()
        nav.delegate = delegate
        navigationController?.pushViewController(nav, animated: true)
    }
    @objc func handleApple(){
        print("DEBUG: Apple button pressed")
    }
    @objc func handleFacebook(){
        print("DEBUG: Facebook button pressed")
    }
    @objc func handleGmail(){
        print("DEBUG: Gmail button pressed")
        GIDSignIn.sharedInstance()?.signIn()
    }
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        checkFormStatus()
    }
    
    //    MARK: - setup View
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(backgroundView)
        backgroundView.frame = view.bounds
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [appleButton,facebookButton,gmailButton])
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.widthAnchor.constraint(equalToConstant: 168).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 40).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -40).isActive = true
    }
    
    //    MARK: - setup Constraints
    
    func setupConstraints() {
        view.addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 40).isActive = true
        
        view.addSubview(emailTextField)
        emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 20).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 40).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -40).isActive = true
        
        view.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,constant: 20).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 40).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -40).isActive = true
        
        view.addSubview(loginButton)
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant: 20).isActive = true
        loginButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -40).isActive = true
        
        view.addSubview(forgetPasswordButton)
        forgetPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant: 20).isActive = true
        forgetPasswordButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 40).isActive = true
        
        view.addSubview(registerButton)
        registerButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -40).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -40).isActive = true
    }
    // MARK: - Helpers
    
    func checkFormStatus() {
        if viewModel.formIsValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = UIColor(white: 1, alpha: 0.3)
            
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .white
            loginButton.backgroundColor = UIColor(white: 1, alpha: 0)
        }
    }
    
    func configureTextFieldObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    func configureGoogleSignIn() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
}
// MARK: - Extensions

extension LoginController : ResetPasswordDelegate {
    func didSendResetPassword() {
        
        self.navigationController?.popViewController(animated: true)
        showMasage(withTitle: "Sucess", message: "Reset email send")
    }
}

extension LoginController : GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        Service.signInWithGoogle(didSignInFor: user) { (error, reference) in
            if let error = error {
                print("DEBUG: Google - \(error.localizedDescription)")
                return
            } else  {
                print("DEBUG: Successfully sign in with google ...")
                self.delegate?.authorezationComplete()
            }
        }
    }
}

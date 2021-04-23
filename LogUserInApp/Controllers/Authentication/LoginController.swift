//
//  LoginController.swift
//  LogUserInApp
//
//  Created by Sebastian Sciuba on 20/04/2021.
//

import UIKit

class LoginController : UIViewController {
    
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
        self.dismissKeyboard()
    }
    
    //    MARK: - Action
    
    @objc func handleForgotPassword() {
        print("DEBUG: Forgot Password button pressed")
        let nav = ResetPasswordController()
        nav.email = emailTextField.text
        navigationController?.pushViewController(nav, animated: true)
    }
    @objc func handleLogUserIn() {
        print("DEBUG: LogUserIn button pressed")
        let nav = HomeViewController()
        nav.user = emailTextField.text
        navigationController?.pushViewController(nav, animated: true)
    }
    @objc func handleRegister() {
        print("DEBUG: Register button pressed")
        let nav = RegisterController()
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
}

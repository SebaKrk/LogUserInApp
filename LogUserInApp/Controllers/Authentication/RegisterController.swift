//
//  RegisterController.swift
//  LogUserInApp
//
//  Created by Sebastian Sciuba on 21/04/2021.
//

import UIKit

class RegisterController : UIViewController {
    
    private var viewModel = RegistrationViewModel()
    
    private let backgroundView = UIImageView(image: #imageLiteral(resourceName: "registerPage"))

    private let titleLabel = CostumLabel(title: "Register", size: 42, color: .white)
    private let fullNameTextField = CostumTextField(placeHolder: "Full Name", colorText: .white, isSecureText: false)
    private let emailTextField = CostumTextField(placeHolder: "Email", colorText: .white, isSecureText: false)
    private let passwordTextField = CostumTextField(placeHolder: "Password", colorText: .white, isSecureText: true)
    
    private let registerButton : CostumButton = {
        let button = CostumButton(text: "Register", textColor: .white, type: .system)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        button.backgroundColor = UIColor(white: 1, alpha: 0)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        return button
    }()
    
    private let loginButton : CostumTextButton2 = {
        let button = CostumTextButton2(text1: "Alredy a\nMember?", text2: " Login", textColor: .white, widht: 130, type: .system)
        button.addTarget(self, action: #selector(handleLogUserIn), for: .touchUpInside)
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
        setupStackView()
        setupConstraints()
        configureTextFieldObservers()
    }
    
//    MARK: - Action
    @objc func handleLogUserIn() {
        print("DEBUG: LogUserIn button pressed")
        navigationController?.popViewController(animated: true)
    }
    @objc func handleRegister() {
        print("DEBUG: Register button pressed")
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
        } else if sender == fullNameTextField {
            viewModel.fullName = sender.text
        } else if sender == passwordTextField {
            viewModel.password = sender.text
        }
        checkFormStatus()
    }

    
//    MARK: - SetupView
    
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
    
//    MARK: - SetupConstraints
    
    func setupConstraints() {
        view.addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 40).isActive = true
        
        view.addSubview(fullNameTextField)
        fullNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 20).isActive = true
        fullNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fullNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 40).isActive = true
        fullNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -40).isActive = true
        
        view.addSubview(emailTextField)
        emailTextField.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor,constant: 20).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 40).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -40).isActive = true
        
        view.addSubview(passwordTextField)
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,constant: 20).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 40).isActive = true
        passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -40).isActive = true
        
        view.addSubview(registerButton)
        registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,constant: 20).isActive = true
        registerButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -40).isActive = true
        
        view.addSubview(loginButton)
        loginButton.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -40).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -40).isActive = true
    }
//    MARK: - Helpers
    
    func checkFormStatus() {
        if viewModel.formIsValid {
            registerButton.isEnabled = true
            registerButton.backgroundColor = UIColor(white: 1, alpha: 0.3)
            
        } else {
            registerButton.isEnabled = false
            registerButton.backgroundColor = UIColor(white: 1, alpha: 0)
        }
    }
    
    func configureTextFieldObservers() {
        fullNameTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
}

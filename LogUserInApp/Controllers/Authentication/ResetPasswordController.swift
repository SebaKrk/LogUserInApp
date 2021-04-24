//
//  ResetPasswordController.swift
//  LogUserInApp
//
//  Created by Sebastian Sciuba on 22/04/2021.
//

import UIKit

class ResetPasswordController : UIViewController {
    
    var email : String?
    
    private var viewModel = ResetPasswordViewModel()
    
    private let backgroundView = UIImageView(image: #imageLiteral(resourceName: "registerPage"))
    
    private let backButton : CostumIcon = {
        let button = CostumIcon(color: .white, name: "back")
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel = CostumLabel(title: "Reset\nPassword", size: 42, color: .white)
    private let emailTextField = CostumTextField(placeHolder: "Email", colorText: .white, isSecureText: false)
    private let resetLabel = CostumLabel(title: "Send reset link", size: 16, color: .white)
    
    private let resetButton : CostumButton = {
        let button = CostumButton(text: "Rest", textColor: .white, type: .system)
        button.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
        button.backgroundColor = UIColor(white: 1, alpha: 0)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        configureTextFieldObservers()
        self.dismissKeyboard()
        loadEmail()

    }
    
//    MARK: - Action
    
    @objc func handleReset() {
        print("DEBUG: Reset button pressed")
        guard let email = viewModel.email else {return}
        
        Service.resetPassword(withEmail: email) { (error) in
            if let error = error {
                print("DEBUG: ResetPassword error - \(error.localizedDescription)")
                return
            } else {
                print("DEBUG: Password send")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @objc func handleDismissal() {
        print("DEBUG: handle dissmis")
        navigationController?.popViewController(animated: true)
    }
    @objc func textDidChange(sender: UITextField) {
        if sender == emailTextField {
            viewModel.email = sender.text
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
// MARK: - Setup Constraints
    
    func setupConstraints() {
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 40).isActive = true
        
        view.addSubview(emailTextField)
        emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 20).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 40).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -40).isActive = true
        
        view.addSubview(resetLabel)
        resetLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        resetLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        
        view.addSubview(resetButton)
        resetButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        resetButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
    }
    
//    MARK: Helpers
    
    func loadEmail() {
        guard let email = email else {return}
        viewModel.email = email
        emailTextField.text = email
        checkFormStatus()
    }
    func checkFormStatus() {
        if viewModel.formIsValid {
            resetButton.isEnabled = true
            resetButton.backgroundColor = .white
            resetButton.backgroundColor = UIColor(white: 1, alpha: 0.3)
        } else {
            resetButton.isEnabled = false
            resetButton.backgroundColor = .white
            resetButton.backgroundColor = UIColor(white: 1, alpha: 0)
        }
    }
    
    func configureTextFieldObservers() {
        emailTextField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
}

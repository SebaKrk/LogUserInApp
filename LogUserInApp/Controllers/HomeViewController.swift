//
//  HomeViewController.swift
//  LogUserInApp
//
//  Created by Sebastian Sciuba on 21/04/2021.
//

import UIKit

class HomeViewController : UIViewController {
    
    var user : String?
    
    private let backgroundView = UIImageView(image: #imageLiteral(resourceName: "homePage"))
    
    private let logOutButton : CostumIcon = {
        let button = CostumIcon(color: .lightGray, name: "close")
        button.addTarget(self, action: #selector(logUserOut), for: .touchUpInside)
        return button
    }()
    
    private let welcomeLabel : CostumLabel = {
        let label = CostumLabel(title: "Welcome", size: 29, color: .lightGray)
        label.alpha = 0
        label.numberOfLines = 0
        return label
    }()
    
    
//    MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        showWelcomeLabel()
    }
    
//    MARK: - Action
    
    @objc func logUserOut() {
        print("DEBUG: log user out")
    }
    
    
//    MARK: - SetupView
    
    func setupView() {
        view.backgroundColor = .white
        view.addSubview(backgroundView)
        backgroundView.frame = view.bounds
        
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    func showWelcomeLabel() {
        guard let user = user else {
            print("DEBUG: No User")
            return
        }
        welcomeLabel.text = "Welcome \(user)"
        
        UIView.animate(withDuration: 1) {
            self.welcomeLabel.alpha = 1
        }
    }
    
//    MARK: - SetupConstraints
    
    func setupConstraints() {
        view.addSubview(logOutButton)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20).isActive = true
        logOutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        
        view.addSubview(welcomeLabel)
        welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        welcomeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        welcomeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
    }
}

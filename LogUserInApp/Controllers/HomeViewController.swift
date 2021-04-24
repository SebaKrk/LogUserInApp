//
//  HomeViewController.swift
//  LogUserInApp
//
//  Created by Sebastian Sciuba on 21/04/2021.
//

import UIKit
import SideMenu
import Firebase
import CodableFirebase

class HomeViewController : UIViewController {
    
    private var user : User? {
        didSet {
            print("DEBUG: Did set user")
            showWelcomeLabel()
        }
    }
    var menu : SideMenuNavigationController?
    
    private let backgroundView = UIImageView(image: #imageLiteral(resourceName: "homePage"))
    
    private let logOutButton : CostumIcon = {
        let button = CostumIcon(color: .lightGray, name: "close")
        button.addTarget(self, action: #selector(logUserOut), for: .touchUpInside)
        return button
    }()
    private let menuButton : CostumIcon = {
        let button = CostumIcon(color: .lightGray, name: "hamburger")
        button.addTarget(self, action: #selector(handleMenuToggle), for: .touchUpInside)
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
        authenticateUser()
        setupView()
        setupConstraints()
//        showWelcomeLabel()
        setupSlideMenu()
    }
    
    //    MARK: - Action
    
    @objc func logUserOut() {
        print("DEBUG: log user out")
        logOut()
    }
    @objc func handleMenuToggle() {
        print("DEBUG: present SideMenu")
        present(menu!, animated: true, completion: nil)
    }
    //    MARK: - API
    
    func fetchUser() {
        print("DEBUG: FetchUser")
        Service.fetchUser { user in
            self.user = user
        }
    }
    
    func authenticateUser() {
        if Auth.auth().currentUser?.uid == nil {
            DispatchQueue.main.async {
                print("DEBUG: User is not login")
                self.presentLoginController()
            }
        } else {
            print("DEBUG: User is logged in")
            fetchUser()
        }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            print("DEBUG: SignOut User")
            presentLoginController()
        } catch {
            print("DEBUG: Error signed out")
        }
    }
    
    //    MARK: SideMenu
    
    func setupSlideMenu() {
        menu = SideMenuNavigationController(rootViewController: SideMenuViewController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
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
        welcomeLabel.text = "Welcome\n\(user.fullName)"
        
        UIView.animate(withDuration: 1) {
            self.welcomeLabel.alpha = 1
        }
    }
    
    //    MARK: - SetupConstraints
    
    func setupConstraints() {
        
        view.addSubview(menuButton)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20).isActive = true
        menuButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        
        view.addSubview(logOutButton)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20).isActive = true
        logOutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        
        view.addSubview(welcomeLabel)
        welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        welcomeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        welcomeLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
    }
    //    MARK: - Helpers
    
    func presentLoginController() {
        let controller = LoginController()
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
}
extension HomeViewController : AuthenticationDelegate {
    func authorezationComplete() {
        print("home controller - logindelegate")
        dismiss(animated: true, completion: nil)
        fetchUser()
    }
}


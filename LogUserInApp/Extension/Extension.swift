//
//  Extension.swift
//  LogUserInApp
//
//  Created by Sebastian Sciuba on 21/04/2021.
//

import UIKit

extension UINavigationController {
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    open override var shouldAutorotate: Bool {
        return false
    }
}

extension UIViewController {
    
//    MARK: - DismissKybord
    
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
    
    //    MARK: - Alerts Masage
    
    func showMasage(withTitle title: String, message: String) {
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    func showAlertSheet(withTitle title: String,  message: String, alertAction: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: alertAction, style: .destructive, handler: handler) )
        alert.addAction(UIAlertAction(title: "cancle", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    //    MARK: - Activity Indicator
    
    static let activityIndicator = UIActivityIndicatorView(style: .large)
    
    func showActivitiIndicator(_ show: Bool) {
        
        view.addSubview(UIViewController.activityIndicator)
        
        UIViewController.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        UIViewController.activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        UIViewController.activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        if show {
            UIViewController.activityIndicator.startAnimating()
        } else {
            UIViewController.activityIndicator.stopAnimating()
        }
    }
}

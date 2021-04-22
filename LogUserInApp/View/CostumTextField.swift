//
//  CostumTextField.swift
//  LogUserInApp
//
//  Created by Sebastian Sciuba on 21/04/2021.
//

import UIKit

class CostumTextField : UITextField {
    init(placeHolder: String, colorText: UIColor, isSecureText: Bool) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        let spacer = UIView()
        spacer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        spacer.widthAnchor.constraint(equalToConstant: 12).isActive = true
        leftView = spacer
        leftViewMode = .always

        textColor = colorText
        attributedPlaceholder = NSAttributedString(string: placeHolder,
                                                   attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        font = UIFont(name: "Nunito-ExtraBold", size: 16)
        keyboardType = .emailAddress
        isSecureTextEntry = isSecureText
        autocapitalizationType = .none
        
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let backgroundImage = UIImageView(image: #imageLiteral(resourceName: "Rectangle 2"))
        addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

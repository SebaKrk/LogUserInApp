//
//  CostumButton.swift
//  LogUserInApp
//
//  Created by Sebastian Sciuba on 21/04/2021.
//


import UIKit

class CostumButton : UIButton {
    
    init(text: String, textColor: UIColor,  type: ButtonType) {
        super.init(frame: .zero)
        setTitle(text, for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.font =  UIFont(name: "Nunito-ExtraBold", size: 16)
        translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundImage = UIImageView(image: #imageLiteral(resourceName: "Rectangle 2"))
        addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundImage.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor).isActive = true
        backgroundImage.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backgroundImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        backgroundImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

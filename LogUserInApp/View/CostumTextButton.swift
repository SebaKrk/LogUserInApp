//
//  CostumTextButton.swift
//  LogUserInApp
//
//  Created by Sebastian Sciuba on 21/04/2021.
//

import UIKit

class CostumTextButton : UIButton {
    
    init(text: String, textColor: UIColor,  type: ButtonType) {
        super.init(frame: .zero)
        setTitle(text, for: .normal)
        setTitleColor(textColor, for: .normal)
        titleLabel?.font =  UIFont(name: "Nunito-ExtraBold", size: 16)
        translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

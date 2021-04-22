//
//  CostumBackButton.swift
//  LogUserInApp
//
//  Created by Sebastian Sciuba on 22/04/2021.
//

import UIKit

class CostumIcon : UIButton {
    init(color: UIColor, name: String) {
        super.init(frame: .zero)
        
        let image = UIImage(named: name)
        setImage(image!.withRenderingMode(.alwaysTemplate), for: .normal)
        tintColor = color
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}







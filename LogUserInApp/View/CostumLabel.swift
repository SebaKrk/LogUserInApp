//
//  CostumLabel.swift
//  LogUserInApp
//
//  Created by Sebastian Sciuba on 20/04/2021.
//

import UIKit

class CostumLabel : UILabel {
    init(title: String, size: CGFloat, color: UIColor) {
        super.init(frame: .zero)
        text = title
        font = UIFont(name: "Nunito-ExtraBold", size: size)
        textColor = color
        numberOfLines = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

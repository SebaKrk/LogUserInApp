//
//  CostumTextButton2.swift
//  LogUserInApp
//
//  Created by Sebastian Sciuba on 22/04/2021.
//

import UIKit

class CostumTextButton2 : UIButton {
    
    init(text1: String, text2: String, textColor: UIColor,widht: CGFloat,type: ButtonType) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        let atts: [NSAttributedString.Key : Any] = [.foregroundColor: textColor,
                                                    .font: UIFont(name: "Nunito-Light", size: 16)!]
        let attributedTtitle = NSMutableAttributedString(string: text1, attributes: atts)
        let boldAtts: [NSAttributedString.Key : Any] = [.foregroundColor: textColor,
                                                        .font: UIFont(name: "Nunito-ExtraBold", size: 16)!]
        attributedTtitle.append(NSAttributedString(string: text2, attributes: boldAtts))
        setAttributedTitle(attributedTtitle, for: .normal)
        
        titleLabel?.numberOfLines = 0
        
        heightAnchor.constraint(equalToConstant: 40).isActive = true
        widthAnchor.constraint(equalToConstant: widht).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

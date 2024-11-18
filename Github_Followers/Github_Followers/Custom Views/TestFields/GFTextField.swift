//
//  GFTextField.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 30/09/24.
//

import UIKit

class GFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius          = 10
        layer.borderWidth           = 2
        layer.borderColor           = UIColor.systemGray4.cgColor
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .center
        font                        = UIFont.preferredFont(forTextStyle: .headline)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        backgroundColor             = .tertiarySystemBackground
        autocorrectionType          = .no
        placeholder                 = "Enter a username"
        keyboardType                = .default
        returnKeyType               = .go
        clearButtonMode             = .whileEditing // This will add a one x button on the right side of the textfield to clear the text inserted into textfield
    }
}

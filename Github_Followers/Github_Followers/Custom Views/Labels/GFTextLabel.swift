//
//  GFTextLabel.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 30/09/24.
//

import UIKit

class GFTextLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // To avoid calling the same function on multiple places we can use the keyword convenience, so that it will call the designated initializer
    convenience init(textAlignment : NSTextAlignment, fontSize : CGFloat){
        self.init(frame: .zero)
        self.textAlignment  = textAlignment
        self.font           = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }

    private func configure(){
        textColor                   = .label
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}

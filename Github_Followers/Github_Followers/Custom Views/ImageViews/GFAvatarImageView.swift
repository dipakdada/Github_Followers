//
//  GFAvatarImageView.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 14/10/24.
//

import UIKit

class GFAvatarImageView: UIImageView {

    let cache            = NetworkManager.shared.cache // object of cache memory
    let placeholderImage = Images.ghAvatarImg

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func configure(){
        layer.cornerRadius  = 10
        clipsToBounds       = true
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }   
}

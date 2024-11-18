//
//  FollowerCell.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 14/10/24.
//

import UIKit

class FollowerCell: UICollectionViewCell {

    // reuseID is use to indentify the cell uniquely
    static let reuseUD = "FollowersCell"

    let avatarImageView =  GFAvatarImageView(frame: .zero)
    let usernameLbl = GFTextLabel(textAlignment: .center, fontSize: 16)

    let padding : CGFloat = 8

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // Set followers: function is use to set the data of user
    func set(follower : Follower){
        usernameLbl.text        = follower.login
        NetworkManager.shared.downloadImage(from: follower.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }

    // set the configuration of the cell by adding the imageView and label 
    private func configure(){
        addSubview(avatarImageView)
        addSubview(usernameLbl)

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor ,constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

            usernameLbl.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLbl.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding),
            usernameLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLbl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}

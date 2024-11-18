//
//  FavouriteCell.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 22/10/24.
//

import UIKit

class FavouriteCell: UITableViewCell {

    static let reuseUD = "FavouriteCell"

    let avatarImageView =  GFAvatarImageView(frame: .zero)
    let usernameLbl = GFTextLabel(textAlignment: .left, fontSize: 26)
    let padding : CGFloat = 12

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    // Set followers
    func set(favourite : Follower){
        usernameLbl.text        = favourite.login
        NetworkManager.shared.downloadImage(from: favourite.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async { self.avatarImageView.image = image }
        }
    }

    private func configure(){
        addSubview(avatarImageView)
        addSubview(usernameLbl)

        accessoryType = .disclosureIndicator

        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),

            usernameLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLbl.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: 24),
            usernameLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLbl.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

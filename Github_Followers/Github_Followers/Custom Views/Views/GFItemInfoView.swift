//
//  GFItemInfoView.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 18/10/24.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {

    let symbolImageView = UIImageView()
    let titleLabel      = GFTextLabel(textAlignment: .left, fontSize: 14)
    let countLabel      = GFTextLabel(textAlignment: .left, fontSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)

        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor   = .label

        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),

            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor,constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),

            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor,constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    func set(itemInfoType: ItemInfoType, withCount count: Int){
        switch itemInfoType {
            case .repos: 
                symbolImageView.image   = Images.ghPublicRepo
                titleLabel.text         = "Public Repos"
            case .gists:
                symbolImageView.image   = Images.ghPublicGists
                titleLabel.text         = "Public Gists"
            case .followers:
                symbolImageView.image   = Images.ghFollowers
                titleLabel.text         = "Followers"
            case .following:
                symbolImageView.image   = Images.ghFollowing
                titleLabel.text         = "Following"
        }
        countLabel.text = "\(count)"
    }
}

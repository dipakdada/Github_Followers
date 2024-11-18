//
//  GFEmptyStateView.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 16/10/24.
//

import UIKit

class GFEmptyStateView: UIImageView {

    let messageLbl      = GFTextLabel(textAlignment: .center, fontSize: 28)
    let logoImageView   = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(message:String) {
        self.init(frame: .zero)
        messageLbl.text = message
    }

    private func configure(){
        configureMessgeLabel()
        configureLogoImageView()
    }

    private func configureMessgeLabel(){
        addSubview(messageLbl)

        messageLbl.numberOfLines    = 3
        messageLbl.textColor        = .secondaryLabel

        let logoCenterYConstant : CGFloat       = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? -80 : -150
        let messageLabelCenterYConstraint       = messageLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: logoCenterYConstant)
        messageLabelCenterYConstraint.isActive    = true

        NSLayoutConstraint.activate([
            messageLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLbl.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

    private func configureLogoImageView(){
        addSubview(logoImageView)

        logoImageView.image = Images.ghEmptyState
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        let logoBottomYConstant : CGFloat   = DeviceType.isiPhoneSE || DeviceType.isiPhone8Zoomed ? 80 : 40
        let logoBottomConstraint            = logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomYConstant)
        logoBottomConstraint.isActive       = true

        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 190)
        ])
    }
}

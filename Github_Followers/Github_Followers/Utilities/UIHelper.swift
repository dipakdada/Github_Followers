//
//  UIHelper.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 14/10/24.
//

import UIKit


enum UIHelper {
    // created a flow layout for collection view
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                           = view.bounds.width
        let padding : CGFloat               = 12
        let minimumItemSpacing : CGFloat    = 10
        let availableWidth                  = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                       = availableWidth / 3

        let flowLayout                      = UICollectionViewFlowLayout()
        flowLayout.sectionInset             = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize                 = CGSize(width: itemWidth, height: itemWidth + 40)

        return flowLayout
    }
}

//
//  Constants.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 17/10/24.
//

import UIKit


enum SFSymbols {
    static let location  = "mappin.and.ellipse"
    static let repos     = "folder"
    static let gists     = "text.alignleft"
    static let followers = "heart"
    static let following = "person.2"
}

enum Images {
    static let ghLogo           = UIImage(named: "gh-logo-dark")!
    static let ghLocation       = UIImage(systemName: SFSymbols.location)
    static let ghAvatarImg      = UIImage(named: "avatar-placeholder-dark")
    static let ghEmptyState     = UIImage(named: "empty-state-logo")
    static let ghPublicRepo     = UIImage(systemName: SFSymbols.repos)
    static let ghPublicGists    = UIImage(systemName: SFSymbols.gists)
    static let ghFollowers      = UIImage(systemName: SFSymbols.followers)
    static let ghFollowing      = UIImage(systemName: SFSymbols.following)
}


enum ScreenSize {
    static let width        = UIScreen.main.bounds.width
    static let height       = UIScreen.main.bounds.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = max(ScreenSize.width, ScreenSize.height)
}

enum DeviceType {

    static let idiom        = UIDevice.current.userInterfaceIdiom
    static let nativeScale  = UIScreen.main.nativeScale
    static let scale        = UIScreen.main.scale

    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .phone && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRation() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }

}

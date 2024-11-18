//
//  errorMessage.swift
//  Github_Followers
//
//  Created by AressMacMiniA1993 on 08/10/24.
//

import Foundation


enum GFError : String, Error {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server is invalid. Please try again."
    case invalidUser        = "The entered username is invalid. Please try again."
    case unableToFavorite   = "There was a error favoriting this user. Please try again."
    case alreadyToFavourite = "You've already added this user to favourite.You must Really Like them!"
}

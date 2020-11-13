//
//  Hero.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 07.11.2020.
//

import Foundation

enum Hero: CaseIterable  {
    
    case yellow
    case violet
    case green
    case blue
    case red
    case white
    
    var value: String {
        return String(describing: self)
    }
}

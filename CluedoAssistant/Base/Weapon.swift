//
//  Weapon.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 07.11.2020.
//

import Foundation

enum Weapon: CaseIterable  {
    
    case knife
    case chandelier
    case pistol
    case poison
    case trophy
    case rope
    case bit
    case ax
    case dumbbell
    
    var value: String {
        return String(describing: self)
    }
}

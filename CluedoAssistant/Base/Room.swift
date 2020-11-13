//
//  Room.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 07.11.2020.
//

import Foundation

enum Room: CaseIterable {
    
    case hallway
    case kitchen
    case diningRoom
    case terrace
    case observatory
    case livingRoom
    case showRoom
    case bathRoom
    case guestHouse
    
    var value: String {
        return String(describing: self)
    }
}

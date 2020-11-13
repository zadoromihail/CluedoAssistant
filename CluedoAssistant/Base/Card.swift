//
//  Card.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 09.11.2020.
//

import Foundation

struct Card: Equatable {
    
    static func == (lhs: Card, rhs: Card) -> Bool {
      
        lhs.isSelected == rhs.isSelected && lhs.cardType.value == rhs.cardType.value
    }
    
    let cardType: CardType
    
    var isSelected = false
    
    var markIsShown = false
    
    var owner: Person?
    
//    init(cardType: CardType) {
//        self.cardType = cardType
//    }
}

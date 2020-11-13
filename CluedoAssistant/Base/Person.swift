//
//  Person.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 07.11.2020.
//

import Foundation

class Person {
    
    var name: String
    
    var selfCards: [CardType] = []
    
    var selfHearings: [Hearing] = []
    
    var notContainCardsArray: [CardType] = []
    
    var canContainCardsArray: [CardType] = []
    
    var hearings: [[CardType]] = []
    
    func createHearing(hearing: Hearing) {
        
        selfHearings.append(hearing)
    }
    
    func addHearings(cards: [Card]) {
        
        var hearingArray: [CardType] = []
        
        cards.forEach {  hearing in
            hearingArray.append(hearing.cardType)
        }
        
        hearings.append(hearingArray)
    }
    
    init(name: String, cards: [CardType]) {
        
        self.name = name
        selfCards = cards
    }
}

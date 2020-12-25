//
//  LogicManager.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 01.12.2020.
//

import UIKit

class LogicManager {
    
    static func checkForDuplicateInSelfCards(player: Person?, card: CardType, completion: () -> ()) {
        
        guard let contain = player?.selfCards.contains(card) else {
            
            return
        }
        
        if !contain {
            
            completion()
        }
    }
    
    static func checkIfOnlyOneCardInCanContainArray(myCards: [[Card]], person: Person?, completion: (String) -> ()) {
        
        var myCards = myCards
        
        guard var cards = person?.canContainCardsArray else { return }
        
        if  cards.count == 1 {
            
            checkForDuplicateInSelfCards(player: person, card: cards[0]) {
                person?.selfCards.append(cards[0])
            }
            
            
            myCards.enumerated().forEach {  section in
                section.element.enumerated().forEach { myCard in
                    
                    if myCard.element.cardType == cards[0] {
                        myCards[section.offset][myCard.offset].owner = person
                        myCards[section.offset][myCard.offset].isSelected = true
                        
                        let valueToShow = myCard.element.cardType.value
                        completion(valueToShow)
                    }
                }
            }
            cards = []
        }
    }
    
    static  func filterCanContainCardsArray(players: [Person?], completion: (Person?) -> ()) {
        
        players.forEach { person in
            
            person?.notContainCardsArray.enumerated().forEach { card in
                
                let contain = person?.canContainCardsArray.contains(card.element)
                
                if contain == true, contain != nil {
                    
                    if let filtred = person?.canContainCardsArray.filter({ $0 != card.element}) {
                        
                        person?.canContainCardsArray = filtred
                    }
                }
            }
            completion(person)
        }
    }
    
    static func checkHearingContainAllCardsOrLess(player: Person?, completion: (Card) -> ()) {
        
        var increment = 0
        var filterArray = [CardType]()
        
        player?.hearings.enumerated().forEach { section in
            
            section.element.forEach { card in
                
                guard let contains = player?.canContainCardsArray.contains(card) else { return }
                
                if !contains {
                    
                    increment = increment + 1
                    
                    filterArray.append(card)
                }
            }
            
            if increment == 2 {
                
                let filtered = player?.hearings[section.offset].filter {
                    
                    !filterArray.contains($0)
                }
                
                guard let newCardType = filtered?[0] else { return }
                
                let card = Card(cardType: newCardType, isSelected: true, markIsShown: false, owner: player)
                
                LogicManager.checkForDuplicateInSelfCards(player: player, card: newCardType) {
                    
                    player?.selfCards.append(newCardType)
                    completion(card)
                }
                
                guard let safeValues =  player?.canContainCardsArray else { return}
                
                player?.canContainCardsArray = safeValues.filter { $0 != newCardType }
                return
            }
            
            increment = 0
        }
    }
    
    static func addHearingToPlayer(player: Person?, cards: [Card]) {
        
        player?.addHearings(cards: cards)
        
        cards.forEach { card in
            
            let cardIsExist = player?.canContainCardsArray.contains(card.cardType)
            
            if cardIsExist != nil && cardIsExist == false && card.owner == nil {
                
                player?.canContainCardsArray.append(card.cardType)
            }
        }
    }
    
    static func checkForDuplicateInNotContainArray(player: Person?, cards: [Card], completion: () -> () ) {
        
        cards.forEach { card in
            
            let cardIsExist = player?.notContainCardsArray.contains(card.cardType)
            
            if cardIsExist != nil && cardIsExist == false {
                
                player?.notContainCardsArray.append(card.cardType)
            }
        }
        
        completion()
    }
    
    static func checkForEqualCardInSelectedArray(equalCard: Card, selectedArray: [[Card]], completion: (Int,Int) -> () ) {
        
        selectedArray.enumerated().forEach { section in
            
            section.element.enumerated().forEach { card in
                
                if card.element.cardType.value == equalCard.cardType.value {
                    
                    completion(section.offset,card.offset)
                }
            }
        }
    }
}

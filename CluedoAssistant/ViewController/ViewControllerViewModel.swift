//
//  ViewControllerViewModel.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 18.11.2020.
//

import UIKit

class ViewControllerViewModel {
    
    var suggestion: [Card] = []
    
    var players: [Person?] = []
    
    var myCards: [[Card]] = []
    
    let playersListViewController = PlayersListViewController()
    
    let myCardsVC = MyCardsViewController()
    
    let suggestionVC = SuggestionViewController()
    
    let otherSuggestionVC = OtherSuggestionViewController()
    
    private func unMarkSection(section index: Int) {
        
        var uncheckedCards: [Card] = []
        var cards: [[Card]] = []
        
        myCards.enumerated().forEach { section in
            
            uncheckedCards = []
            
            section.element.forEach { card in
                
                var card = card
                
                card.markIsShown = false
                
                uncheckedCards.append(card)
            }
            
            cards.append(uncheckedCards)
        }
        
        myCards[index] = cards[index]
    }
    
    func tableViewHeightForRowAtIndexPath() -> CGFloat {
        
        return 60
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        
        return myCards[section].count
    }
    
    func numberOfSections() -> Int {
        
        return myCards.count
    }
    
    func cardForRowAt(indexPath: IndexPath) -> Card {
        
        return myCards[indexPath.section][indexPath.row]
    }
    
    func titleForHeaderInSection(section: Int) -> String? {
        
        if section == 0 {
            
            return "Hero"
        }
        
        if section == 1 {
            
            return "Room"
        }
        
        else {
            
            return "Weapon"
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        suggestion.enumerated().forEach { card in
            
            if card.element.cardType.onlyType == myCards[indexPath.section][indexPath.row].cardType.onlyType {
                suggestion.remove(at: card.offset)
            }
        }
        
        if myCards[indexPath.section][indexPath.row].markIsShown {
            
            myCards[indexPath.section][indexPath.row].markIsShown = false
            
            suggestion = suggestion.filter { $0 != myCards[indexPath.section][indexPath.row] }
        }
        
        else {
            unMarkSection(section: indexPath.section)
            
            myCards[indexPath.section][indexPath.row].markIsShown = true
            
            suggestion.append(myCards[indexPath.section][indexPath.row])
        }
        
        tableView.reloadData()
    }
    
    func updateMyCards() {
        
        guard myCards.count > 0 else { return }
        
        players[0]?.selfCards = []
        
        myCards.forEach { section in
            section.forEach { card in
                if card.owner?.name == players[0]?.name {
                    players[0]?.selfCards.append(card.cardType)
                }
            }
        }
    }
    
    func presentOtherSuggestion(controller: UIViewController, completion: (UIAlertController) -> () ) {
        
        let alert = UIAlertController(title: "Other Suggestion", message: "Select player, making suggestion", preferredStyle: .actionSheet)
        
        let actionSheet = players.filter { $0?.name != players[0]?.name }
        
        actionSheet.forEach { person in
            
            let alertAction = UIAlertAction(title: person?.name, style: .default) { action in
                
                self.otherSuggestionVC.user = self.players[0]
                self.otherSuggestionVC.cards = self.suggestion
                self.otherSuggestionVC.currentPlayer = person
                self.otherSuggestionVC.players = self.players
                
                controller.navigationController?.present(self.otherSuggestionVC, animated: true, completion: nil)
            }
            
            alert.addAction(alertAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(cancelAction)
        
        completion(alert)
    }
    
    func replaceCard(newCard: Card,completion: (String) -> () ) {
        
        var newCard = newCard
        newCard.isSelected = true
        
        myCards.enumerated().forEach { section in
            
            section.element.enumerated().forEach { card in
                
                if card.element.cardType.value == newCard.cardType.value {
                    myCards[section.offset][card.offset] = newCard
                }
            }
            
        }
        
        let valueToShow = newCard.cardType.value
        
        completion(valueToShow)
    }
    
    func addHearingToPlayer(player: Person?, cards: [Card]) {
        
        player?.addHearings(cards: cards)
        
        cards.forEach { card in
            
            let cardIsExist = player?.canContainCardsArray.contains(card.cardType)
            
            if cardIsExist != nil && cardIsExist == false && card.owner == nil {
                
                player?.canContainCardsArray.append(card.cardType)
            }
        }
    }
    
    func checkIfSomeCardsNotContainCard(completion: (Person?) -> ()) {
        
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
    
    func checkHearingContainAllCardsOrLess(player: Person?, completion: (Card) -> ()) {
        
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
                
                player?.selfCards.append(newCardType)
                
                completion(card)
                
                guard let safeValues =  player?.canContainCardsArray else { return}
                
                player?.canContainCardsArray = safeValues.filter { $0 != newCardType }
                return
            }
            
            increment = 0
        }
    }
    
    func checkIfOneCardInContainArray(person: Person?, completion: (String) -> ()) {
        
        guard var cards = person?.canContainCardsArray else { return }
        
        if  cards.count == 1 {
            person?.selfCards.append(cards[0])
            
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
    
    func returnPlayer(player: Person?, cards: [Card], completion: () -> ()) {
        
        cards.forEach { card in
            
            let cardIsExist = player?.notContainCardsArray.contains(card.cardType)
            
            if cardIsExist != nil && cardIsExist == false {
                
                player?.notContainCardsArray.append(card.cardType)
            }
        }
        
        completion()
    }
}

extension ViewControllerViewModel: MyCardsViewControllerDelegate {
    
    func myCardsViewController(cards: [[Card]]) {
        
        myCards = cards
    }
}

extension ViewControllerViewModel: PlayersListViewControllerDelegate {
    
    func removePlayer(player: Person?) {
       players = players.filter { $0?.name != player?.name }
    }
    
    
    func addPlayer(player: Person?) {
        
        players.append(player)
        
        playersListViewController.players = players
    }
}

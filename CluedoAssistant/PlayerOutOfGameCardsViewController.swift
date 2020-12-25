//
//  PlayerOutOfGameCardsViewController.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 02.12.2020.
//

import UIKit

protocol PlayerOutOfGameCardsViewControllerDelegate: class {
    func replaceCardArray(cardArray: [[Card]])
}

class PlayerOutOfGameCardsViewController: UIViewController {
    
    weak var delegate: PlayerOutOfGameCardsViewControllerDelegate?
    
    var players: [Person?] = []
    
    var player: Person!
    
    var cardArray: [[Card]] = []
    
    var selectedCards: [Card] = []
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.replaceCardArray(cardArray: cardArray)
    }
    
    func unMarkCards() {
        cardArray.enumerated().forEach { section in
            section.element.enumerated().forEach { card in
                
                var myCard = card.element
                myCard.markIsShown = false
                cardArray[section.offset][card.offset] = myCard
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        unMarkCards()
        
        tableView.reloadData()
    }
}

extension PlayerOutOfGameCardsViewController {
    func setupUI() {
        
        title = "Укажите карты"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CardCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension PlayerOutOfGameCardsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardArray[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        cardArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CardCell else {
            
            return UITableViewCell()
        }
        
        let card = cardArray[indexPath.section][indexPath.row]
        
        cell.setupUI(card: card)

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
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
}

extension PlayerOutOfGameCardsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
       var card = cardArray[indexPath.section][indexPath.row]
        
        if card.owner == nil || card.owner?.name == player.name {
            
            if card.isSelected {
                
                card.isSelected = false
                card.owner = nil
                
                selectedCards = selectedCards.filter { $0 != card }
            }
            
            else  {
                card.isSelected = true
                card.owner = player
                
                selectedCards.append(card)
            }
            
            cardArray[indexPath.section][indexPath.row] = card
            
            tableView.reloadData()

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

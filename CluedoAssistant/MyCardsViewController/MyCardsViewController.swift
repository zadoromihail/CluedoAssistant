//
//  MyCardsViewController.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 07.11.2020.
//

import UIKit
import SnapKit

protocol MyCardsViewControllerDelegate: class {
    
    func myCardsViewController(cards: [[Card]])
}

class MyCardsViewController: UIViewController {
    
    weak var delegate: MyCardsViewControllerDelegate?
    
    var players: [Person?] = []
    
    var cardArray: [[Card]] = []
    
    var selectedCards: [Card] = []
    
    let tableView = UITableView()
    
    let maxNumberOfCards = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension MyCardsViewController {
    
    func createArray() {

        var heroCardArray = [Card]()
        var roomCardArray = [Card]()
        var weaponCardArray = [Card]()
        
        CardType.allCases.forEach { cardType in
            
            let card = Card(cardType: cardType)
            
            switch cardType {
            case .hero:
                heroCardArray.append(card)
            case .room:
                roomCardArray.append(card)
            case .weapon:
                weaponCardArray.append(card)
            case .unknownCard:
                return
            }
        }
        
        cardArray.append(heroCardArray)
        cardArray.append(roomCardArray)
        cardArray.append(weaponCardArray)
    }

    func setupUI() {
    
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.backgroundColor = .lightGray
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CardCell.self, forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 180
        
        setupConstraints()
        createArray()
    }
    
    private func setupConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
        }
        
    }
    
    private func numberOfMyCardsIsLessThanMaximum() -> Bool {
        
        var numberOfSelectedCards = 0
        
        cardArray.forEach { section in
            
            section.forEach { card in
                
                if card.isSelected {
                    numberOfSelectedCards = numberOfSelectedCards + 1
                }
            }
        }
        
        if numberOfSelectedCards < maxNumberOfCards {
            
            return true
        }
        
        return false
    }
}
    
extension MyCardsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        cardArray[section].count
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

extension MyCardsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cartCanBeAdded = numberOfMyCardsIsLessThanMaximum()
        
       var card = cardArray[indexPath.section][indexPath.row]
        
        if card.isSelected {
            
            card.isSelected = false
            card.owner = nil
            
            selectedCards = selectedCards.filter { $0 != card }
        }
        
        else if cartCanBeAdded {
            card.isSelected = true
            card.owner = players[0]
            
            selectedCards.append(card)
        }
        
        cardArray[indexPath.section][indexPath.row] = card
        
        tableView.reloadData()
        delegate?.myCardsViewController(cards: cardArray )
       // delegate?.myCardsViewController(cards: selectedCards )
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}



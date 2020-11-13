//
//  OtherSuggestionViewController.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 11.11.2020.
//

import UIKit
import SnapKit

protocol PlayerCanContainCardsDelegate: class {
    
    func returnPlayerWithCard(player: Person?, cards: [Card])
}

class OtherSuggestionViewController: BaseSuggestionViewController {
    
    weak var playerNotContainCardsDelegate: PlayerNotContainCardsDelegate?
    
    weak var playerCanContainCardsDelegate: PlayerCanContainCardsDelegate?
    
    var askingPlayerIndex = 0
    
    var user: Person?
    
    var players: [Person?] = []
    
    var currentPlayer: Person?
    
  //  var cards: [Card] = []
    
    var currentPlayerIndex: Int?
    
    let stackView = UIStackView()
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = .yellow
        return view
    }()
    
    let customView = UIView()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Record the other players responses"
        label.textAlignment = .center
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Their Suggestion"
        return label
    }()
    
    let suggestionPlayerLabel: UILabel = {
        let label = UILabel()
        label.text = "Some player"
        label.textAlignment = .center
        return label
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "is asking if"
        label.textAlignment = .center
        return label
    }()
    
    let playerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Lesha"
        label.textAlignment = .center
        return label
    }()
    
    let isHoldingLabel: UILabel = {
        let label = UILabel()
        label.text = "Have"
        label.textAlignment = .center
        return label
    }()
    
    let cardsField: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        return label
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        
        return button
    }()
    
    let cadrShown: UIButton = {
        let button = UIButton()
        button.setTitle("Some card ", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.tag = 0
        
        return button
    } ()
    
    
    let noCardHelp: UIButton = {
        let button = UIButton()
        button.setTitle("No Card Help", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.tag = 1
        return button
    } ()
    
    let refusedToShow: UIButton = {
        let button = UIButton()
        button.setTitle("Refused To Show", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.tag = 2
        return button
    } ()
    
}

extension OtherSuggestionViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        
        suggestionPlayerLabel.text = currentPlayer?.name
        setCardField()
        setPerson()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}

extension OtherSuggestionViewController {
    
    private func setupUI() {
        
        view.backgroundColor = .orange
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(cancelButton)
        
        view.addSubview(customView)
        
        customView.backgroundColor = .gray
        
        customView.addSubview(suggestionPlayerLabel)
        
        customView.addSubview(questionLabel)
        
        customView.addSubview(playerNameLabel)
        
        customView.addSubview(isHoldingLabel)
        
        customView.addSubview(cardsField)
        
        customView.addSubview(cadrShown)
        
        customView.addSubview(separator)
        
        customView.addSubview(noCardHelp)
        
        customView.addSubview(refusedToShow)
        
        makeConstraints()
        
        cadrShown.addTarget(self, action: #selector(cardShown), for: .touchUpInside)
        noCardHelp.addTarget(self, action: #selector(cardShown), for: .touchUpInside)
        refusedToShow.addTarget(self, action: #selector(cardShown), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
    }
    
    private func makeConstraints() {
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom)
            make.left.equalTo(cancelButton.snp.right)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalTo(titleLabel.snp.left)
            make.height.equalTo(titleLabel.snp.height)
        }
        
        customView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        suggestionPlayerLabel.snp.makeConstraints { make in
            
            make.top.equalTo(customView.snp.top).offset(20)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        
        questionLabel.snp.makeConstraints { make in
            
            make.top.equalTo(suggestionPlayerLabel.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        playerNameLabel.snp.makeConstraints { make in
            
            make.top.equalTo(questionLabel.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        
        isHoldingLabel.snp.makeConstraints { make in
            
            make.top.equalTo(playerNameLabel.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        cardsField.snp.makeConstraints { make in
            
            make.top.equalTo(isHoldingLabel.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        cadrShown.snp.makeConstraints { make in
            
            make.top.equalTo(cardsField.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(cadrShown.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(3)
        }
        
        noCardHelp.snp.makeConstraints { make in
            make.top.equalTo(separator.snp.bottom).offset(5)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        
        
        refusedToShow.snp.makeConstraints { make in
            make.top.equalTo(noCardHelp.snp.bottom).offset(5)
            make.bottom.lessThanOrEqualToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        
    }
    
    private func setCardField() {
        
        cardsField.text = ""
        
        cards.forEach { card in
            
            guard let text = cardsField.text else { return }
            
            switch text {
            
            case "" : cardsField.text = card.cardType.value
                
            default : cardsField.text = text + ", " +  card.cardType.value
            }
        }
    }
    
    private func setPerson() {
        
        players.enumerated().forEach { player in
            
            if player.element?.name == currentPlayer?.name {
                currentPlayerIndex = player.offset
                
                askingPlayerIndex = player.offset + 1
            }
        }
        
        if askingPlayerIndex >= players.count {
            askingPlayerIndex = players.startIndex
        }
        
        var playerName = players[askingPlayerIndex]?.name
        
        if players[askingPlayerIndex]?.name == user?.name {
            
            playerName = "You"
        }
        
        playerNameLabel.text = playerName
    }
    
    
    
    private func changePerson() {
        
        
        askingPlayerIndex = askingPlayerIndex + 1
        
        if askingPlayerIndex == currentPlayerIndex {
            
            let message = "Карты у игроков не выявлены"
            showAlertMessage(message: message)
        }
        
        if players.endIndex == askingPlayerIndex {
            
            playerNotContainCardsDelegate?.returnPlayer(player: players[askingPlayerIndex - 1], cards: cards)
            
            askingPlayerIndex = players.startIndex
        }
        
        else {
            
            playerNotContainCardsDelegate?.returnPlayer(player: players[askingPlayerIndex - 1], cards: cards)
            
        }
        
        var playerName = players[askingPlayerIndex]?.name
        
        if players[askingPlayerIndex]?.name == user?.name {
            
            playerName = "You"
            
            user?.selfCards.forEach { userCard in
                
                cards.forEach { card in
                    
                    if userCard.value == card.cardType.value {
                        
                        let message = "Вы показываете карту: \(userCard.value)"
                        
                        showAlertMessage(message: message)
                        
                    }
                }
            }
            
        }
        
        playerNameLabel.text = playerName
        
    }
    
//    private func showAlertMessage(message: String) {
//
//        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
//
//        let confirm = UIAlertAction(title: "Понятно", style: .default) { action in
//            self.dismissController()
//        }
//
//        alert.addAction(confirm)
//
//        present(alert, animated: true, completion: nil)
//
//    }
    
//    func createHearing (cards: [Card]) -> Hearing {
//
//        var room: CardType?
//        var hero: CardType?
//        var weapon: CardType?
//
//        cards.forEach { card in
//
//            switch card.cardType {
//
//            case .hero : hero = card.cardType
//
//            case .weapon : weapon = card.cardType
//
//            case .room : room = card.cardType
//
//            case .unknownCard:
//                return
//            }
//        }
//        let hearing = Hearing(room: room, weapon: weapon, hero: hero)
//
//        return hearing
//    }
    
    
    
    @objc func cardShown(sender: UIButton) {
        
        switch sender.tag {
        
        case 0 : playerCanContainCardsDelegate?.returnPlayerWithCard(player: players[askingPlayerIndex], cards: cards)
            
        case 1 : changePerson()
            return
            
        case 2 : dismissController()
            return
            
        default: return
            
        }
        
        dismissController()
    }
    
//    @objc func dismissController() {
//
//        cards = []
//        dismiss(animated: true, completion: nil)
//    }
}

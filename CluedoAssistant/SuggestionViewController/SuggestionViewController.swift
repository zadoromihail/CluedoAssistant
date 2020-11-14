//
//  SuggestionViewController.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 10.11.2020.
//

import UIKit
import SnapKit

protocol SuggestionViewControllerDelegate: class {
    
    func suggestionViewController(card: Card)
}

protocol PlayerNotContainCardsDelegate: class {
    
    func returnPlayer(player: Person?, cards: [Card])
}

class SuggestionViewController: BaseSuggestionViewController {
    
    weak var delegate: SuggestionViewControllerDelegate?
    
    weak var playerNotContainCardsDelegate: PlayerNotContainCardsDelegate?
    
    var players: [Person?] = []
    
    var currentPlayer: Person?
    
    //var cards: [Card] = []
    
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
        label.text = "Your Suggestion"
        return label
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "You are asking if"
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
        label.text = "is Holding"
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
    
    let firstCardButton: UIButton = {
        let button = UIButton()
        button.setTitle("Some card 1", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.tag = 0
      
        return button
    } ()
    
    let secondCardButton: UIButton = {
        let button = UIButton()
        button.setTitle("Some card 2", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.tag = 1
      
        return button
    } ()
    
    let thirdCardButton: UIButton = {
        let button = UIButton()
        button.setTitle("Some card 3", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.tag = 2
        return button
    } ()
    
    let noCardHelp: UIButton = {
        let button = UIButton()
        button.setTitle("No Card Help", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.tag = 3
        return button
    } ()
    
    let refusedToShow: UIButton = {
        let button = UIButton()
        button.setTitle("Refused To Show", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.tag = 4
        return button
    } ()
}

extension SuggestionViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        
        setCardField()
        setCardButtons()
        setPerson()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
}

extension SuggestionViewController {
    
    
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
    private func setPerson() {
        players.remove(at: 0)
        currentPlayer = players[0]
        playerNameLabel.text = currentPlayer?.name
    }

    private func changePerson() {
        
        guard players.count > 1 else {
            
            playerNotContainCardsDelegate?.returnPlayer(player: players[0], cards: cards)
            
            let message = "Карты у игроков не выявлены"
            
            showAlertMessage(message: message)
            
            return
        }
        
        playerNotContainCardsDelegate?.returnPlayer(player: players[0], cards: cards)
        players.remove(at: 0)
        currentPlayer = players[0]
        playerNameLabel.text = currentPlayer?.name
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
    
    private func setCardButtons() {
        let firstTitle = cards[0].cardType.value + " shown"
        firstCardButton.setTitle(firstTitle, for: .normal)
        
        let secondTitle = cards[1].cardType.value + " shown"
        secondCardButton.setTitle(secondTitle, for: .normal)
        
        let thirdTitle = cards[2].cardType.value + " shown"
        thirdCardButton.setTitle(thirdTitle, for: .normal)
    }

    private func setupUI() {
        
        view.backgroundColor = .orange
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(cancelButton)
        
        view.addSubview(customView)

        customView.backgroundColor = .gray
       
        customView.addSubview(questionLabel)
 
        customView.addSubview(playerNameLabel)
        
        customView.addSubview(isHoldingLabel)
 
        customView.addSubview(cardsField)
        
        customView.addSubview(firstCardButton)
 
        customView.addSubview(secondCardButton)
 
        customView.addSubview(thirdCardButton)

        customView.addSubview(separator)

        customView.addSubview(noCardHelp)
        
        customView.addSubview(refusedToShow)
    
        makeConstraints()
        
        cancelButton.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        
        firstCardButton.addTarget(self, action: #selector(cardShown), for: .touchUpInside)
        secondCardButton.addTarget(self, action: #selector(cardShown), for: .touchUpInside)
        thirdCardButton.addTarget(self, action: #selector(cardShown), for: .touchUpInside)
        
        noCardHelp.addTarget(self, action: #selector(cardShown), for: .touchUpInside)
        refusedToShow.addTarget(self, action: #selector(cardShown), for: .touchUpInside)
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
        
        questionLabel.snp.makeConstraints { make in
            
            make.top.equalTo(customView.snp.top).offset(20)
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
        
        firstCardButton.snp.makeConstraints { make in
            
            make.top.equalTo(cardsField.snp.bottom).offset(10)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        
        secondCardButton.snp.makeConstraints { make in
            
            make.top.equalTo(firstCardButton.snp.bottom).offset(5)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        
        thirdCardButton.snp.makeConstraints { make in
            
            make.top.equalTo(secondCardButton.snp.bottom).offset(5)
            make.width.equalToSuperview()
            make.height.equalTo(40)
        }
        
        separator.snp.makeConstraints { make in
            make.top.equalTo(thirdCardButton.snp.bottom).offset(5)
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
    
    @objc func cardShown(sender: UIButton) {
        
        switch sender.tag {
        
        case 0 :
            cards[0].owner = currentPlayer
            delegate?.suggestionViewController(card: cards[0])
            
        case 1 :
            cards[1].owner = currentPlayer
            delegate?.suggestionViewController(card: cards[1])
            
        case 2 :
            cards[2].owner = currentPlayer
            delegate?.suggestionViewController(card: cards[2])
            
        case 3 : changePerson()
            return
            
        case 4 : dismissController()
            return
            
        default: return
        }
        
        dismissController()
    }
    

}


class BaseSuggestionViewController: UIViewController {
    
    var cards: [Card] = []
    
    func showAlertMessage(message: String) {
        
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Понятно", style: .default) { action in
            self.dismissController()
        }
        
        alert.addAction(confirm)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @objc func dismissController() {
        
        cards = []
        dismiss(animated: true, completion: nil)
        
    }
}

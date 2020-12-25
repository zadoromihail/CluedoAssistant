//
//  CardCell.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 07.11.2020.
//

import UIKit
import SnapKit

class CardCell: UITableViewCell {
    
    var card: CardType?
    
    let cardTextLabel = UILabel()
    
    let cardOwnerLabel = UILabel()
    
    let cardImageView = UIImageView()
    
    func setupUI(card: Card) {
        
        self.card = card.cardType
        
        addSubview(cardTextLabel)
        
        addSubview(cardImageView)
        
        addSubview(cardOwnerLabel)
        
        selectionStyle = .none
        
        setupConstrints()
        
        cardImageView.image = .checkmark
        
        card.markIsShown ? (cardImageView.isHidden = false) : (cardImageView.isHidden = true)
        
        cardTextLabel.text = card.cardType.value
        
        cardTextLabel.textColor = .black
        
        cardOwnerLabel.textColor = .black
        
        var ownerName: String = ""
        
        if card.owner != nil {
            ownerName = card.owner!.name
        }
        
        cardOwnerLabel.text = "Card owner: \(ownerName) "

        guard card.isSelected == false else {
            
            backgroundColor = .green
            
            return
        }
        
        backgroundColor = .white
    }
    
    private func setupConstrints() {
        
        cardTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalTo(cardImageView.snp.left)
        }
        
        cardImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(cardTextLabel.snp.right)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(contentView.snp.height)
        }
        
        cardOwnerLabel.snp.makeConstraints { make in
            make.top.equalTo(cardTextLabel.snp.bottom)
            
            make.left.equalToSuperview()
            make.right.equalTo(cardImageView.snp.left)
        }
    }
}

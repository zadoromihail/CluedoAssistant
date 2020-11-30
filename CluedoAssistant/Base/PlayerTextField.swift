//
//  PlayerTextField.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 14.11.2020.
//

import Foundation
import UIKit

class PlayerTextField: UITextField {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = .blue
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

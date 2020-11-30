//
//  PlayerStackView.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 14.11.2020.
//

import Foundation
import UIKit

class PlayerStackView: UIStackView {
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.axis = .horizontal
        self.spacing = 5
        self.distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

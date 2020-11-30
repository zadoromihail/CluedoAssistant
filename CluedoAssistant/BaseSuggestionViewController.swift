//
//  BaseSuggestionViewController.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 14.11.2020.
//

import Foundation
import UIKit

class BaseSuggestionViewController: BaseViewController {
    
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

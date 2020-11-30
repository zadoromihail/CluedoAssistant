//
//  BaseViewController.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 14.11.2020.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    func showInfoAlertMessage(message: String) {
        
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Понятно", style: .default, handler: nil)
        
        alert.addAction(confirm)
        
        present(alert, animated: true, completion: nil)
        
    }
}

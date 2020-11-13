//
//  StartViewController.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 07.11.2020.
//

import UIKit

class StartViewController: UIViewController {
    
    let detailVC = ViewController()
    
    @IBOutlet weak var startGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        startGameButton.addTarget(self, action: #selector(startGame), for: .touchUpInside)
    }
    
    
    
    @objc func startGame() {
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}


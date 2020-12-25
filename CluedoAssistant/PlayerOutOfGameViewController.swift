//
//  PlayerOutOfGameViewController.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 02.12.2020.
//

import UIKit
import SnapKit

protocol PlayerOutOfGameViewControllerDelegate: class {
    
    func replaceCardArray(cardArray: [[Card]])
}

class PlayerOutOfGameViewController: UIViewController {
    
    weak var delegate: PlayerOutOfGameViewControllerDelegate?
    
    let playerOutOfGameCardsViewController = PlayerOutOfGameCardsViewController()
    
    var players: [Person?] = []
    
    var cardArray: [[Card]] = []
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerOutOfGameCardsViewController.delegate = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate?.replaceCardArray(cardArray: cardArray)
        tableView.reloadData()
    }
}

extension PlayerOutOfGameViewController {
    
    func setupUI() {
        
        title = "Укажите выбывшего игрока"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension PlayerOutOfGameViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = players[indexPath.row]?.name
        
        return cell
    }
}

extension PlayerOutOfGameViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        playerOutOfGameCardsViewController.cardArray = cardArray
        playerOutOfGameCardsViewController.player = players[indexPath.row]
        playerOutOfGameCardsViewController.players = players
        navigationController?.pushViewController(playerOutOfGameCardsViewController, animated: true)
    }
}

extension PlayerOutOfGameViewController: PlayerOutOfGameCardsViewControllerDelegate {
    
    func replaceCardArray(cardArray: [[Card]]) {
        self.cardArray = cardArray
        tableView.reloadData()
    }
}


//
//  PlayersListViewController.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 13.11.2020.
//

import Foundation
import UIKit
import SnapKit

protocol  PlayersListViewControllerDelegate: class {
    func addPlayer(player: Person?)
    func removePlayer(player: Person?)
}

class PlayersListViewController: UIViewController {
    
    weak var delegate: PlayersListViewControllerDelegate?
    weak var deletePlayerDelegate: PlayersListViewControllerDelegate?
    
    let playersDetailVC = PlayersDetailViewController()
    
    var players: [Person?] = []
    
    let shVC = SpreadshitViewController()
    
    let tableView = UITableView()
    
    let pushExelTable: UIButton = {
        let button = UIButton()
        button.setTitle("Показать таблицу", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(pushExel), for: .touchUpInside)
        return button
    }()
    
    @objc func pushExel() {
        shVC.players = players
        navigationController?.pushViewController(shVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(pushExelTable)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}
 
extension PlayersListViewController {
    
    func setupUI() {
        
        addButtons()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            
            make.top.equalToSuperview()
            make.width.equalToSuperview()
        }
        pushExelTable.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom)
            make.width.equalToSuperview()
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
    }
    
    func addButtons() {
        let addPlayer = UIBarButtonItem(
            title: "Добавить игрока",
            style: .plain,
            target: self,
            action: #selector(buttonPressed)
        )
        
        let removePlayer = UIBarButtonItem(
            title: "Удалить игрока",
            style: .plain,
            target: self,
            action: #selector(buttonPressed)
        )
        addPlayer.tag = 0
        removePlayer.tag = 1
        addPlayer.tintColor = .systemBlue
        removePlayer.tintColor = .red
        
        navigationItem.rightBarButtonItems =  [addPlayer, removePlayer]
    }
    
    @objc func buttonPressed(sender: UIBarButtonItem) {
        sender.tag == 0 ? (addPlayerAlert()) : (removePlayerAlert())
    }
    
    func removePlayerAlert() {
        
        let alert = UIAlertController(title: "Укажите игрока", message: nil , preferredStyle: .actionSheet)
        
        let actionSheet = players.filter { $0?.name != players[0]?.name }
        
        actionSheet.enumerated().forEach { person in
            
            let alertAction = UIAlertAction(title: person.element?.name, style: .default) { action in
                
                self.players.remove(at: person.offset + 1)
                self.tableView.reloadData()
                self.deletePlayerDelegate?.removePlayer(player: person.element)
            }
            
            alert.addAction(alertAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func addPlayerAlert() {
         
         let alert = UIAlertController(title: "Укажите имена игроков", message: nil, preferredStyle: .alert)
         
         alert.addTextField(configurationHandler: nil)
         
         let action = UIAlertAction(title: "Добавить игрока", style: .default) { [self] (action) in
             
             guard let textField = alert.textFields?[0],
                   let text = textField.text else {
                 
                 return
             }
             let player = Person(name: text, cards: [])
             
            delegate?.addPlayer(player: player)
            
            tableView.reloadData()
         }
         
         let cancel = UIAlertAction(title: "Отменить", style: .destructive, handler: nil)
         
         alert.addAction(action)
         alert.addAction(cancel)
         
         present(alert, animated: true, completion: nil)
     }
}

extension PlayersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = players[indexPath.row]?.name
        
        return cell
    }
}

extension PlayersListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playersDetailVC.player = players[indexPath.row]
        
        navigationController?.pushViewController(playersDetailVC, animated: true)
    }
}

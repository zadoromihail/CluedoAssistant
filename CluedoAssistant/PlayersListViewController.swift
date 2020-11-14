//
//  PlayersListViewController.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 13.11.2020.
//

import Foundation
import UIKit
import SnapKit

class PlayersListViewController: UIViewController {
    
    let playersDetailVC = PlayersDetailViewController()
    
    var players: [Person?] = []
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
}
 
extension PlayersListViewController {
    
    func setupUI() {
        
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

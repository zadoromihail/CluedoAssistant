//
//  PlayersDetailViewController.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 13.11.2020.
//

import Foundation
import UIKit
import SnapKit

class PlayersDetailViewController: UIViewController {
    
    var player: Person!
    
    let tableView = UITableView()
    
    var tableViewArray: [[CardType]] = []
    
    var selfCards: [CardType] = []
    
    var notContainCardsArray: [CardType] = []
    
    var canContainCardsArray: [CardType] = []
    
    var hearings: [[CardType]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        setData()
    }
}

extension PlayersDetailViewController {
    
    private  func setupUI() {
        
        setupTableView()
        setupConstraints()
    }
    
    private  func setData() {
        
        selfCards = player.selfCards
        canContainCardsArray = player.canContainCardsArray
        notContainCardsArray = player.notContainCardsArray
        
        hearings = [selfCards,canContainCardsArray,notContainCardsArray]
        
        tableView.reloadData()
    }
    
    private func setupConstraints() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension PlayersDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return hearings[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        hearings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = hearings[indexPath.section][indexPath.row].value
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        
        case 0: return "Known cards"
            
        case 1: return "Can hold cards"
            
        case 2: return "Not hold cards"
            
        default: return "Hero"
        }
    }
}

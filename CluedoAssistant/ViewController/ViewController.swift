//
//  ViewController.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 07.11.2020.
//

import UIKit
import SnapKit

class ViewController: BaseViewController {
    
    let viewModel = ViewControllerViewModel()
    
    let tableView = UITableView()
    
    let stackView = UIStackView()
    
    let buttonStackView = UIStackView()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Выберите карты, составьте догадку"
        return label
    }()
    
    let mySuggestion: UIButton = {
        let button = UIButton()
        button.setTitle("Моя догадка", for: .normal)
        button.backgroundColor = .blue
        
        button.tag = 0
        return button
    }()
    
    let otherSuggestion: UIButton = {
        let button = UIButton()
        button.setTitle("Догадка других", for: .normal)
        button.backgroundColor = .blue
        button.tag = 1
        return button
    }()
}
    
extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        viewModel.updateMyCards()
    }
}

extension ViewController {
    
    private func setupUI() {
        
        view.addSubview(tableView)
        view.addSubview(stackView)
        view.backgroundColor = .red
        
        addButtonSetup()
        
        setupDelegate()
        
        setupTableView()
        
        setupStackView()
    
        choseGameCards()
    }
    
   private func setupDelegate() {
    
        viewModel.suggestionVC.delegate = self
        viewModel.suggestionVC.playerNotContainCardsDelegate = self
        viewModel.otherSuggestionVC.playerNotContainCardsDelegate = self
        viewModel.otherSuggestionVC.playerCanContainCardsDelegate = self
        viewModel.playersListViewController.delegate = viewModel
        viewModel.playersListViewController.deletePlayerDelegate = viewModel
        viewModel.myCardsVC.delegate = viewModel
    }
    
    private func makeStackViewConstraints() {
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.bottom.equalToSuperview().offset(-10)
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    private func makeTableViewConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(10)
            make.bottom.equalTo(stackView.snp.top)
            make.trailing.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(10)
        }
    }
    
    private func setupStackView() {
        
        makeStackViewConstraints()
        
        stackView.backgroundColor = .magenta
        stackView.axis = .vertical
        
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(buttonStackView)
        
        buttonStackView.backgroundColor = .orange
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .center
        buttonStackView.spacing = 5
        buttonStackView.addArrangedSubview(mySuggestion)
        buttonStackView.addArrangedSubview(otherSuggestion)
        
        mySuggestion.addTarget(self, action: #selector(mySuggestionPressed), for: .touchUpInside)
        otherSuggestion.addTarget(self, action: #selector(mySuggestionPressed), for: .touchUpInside)
    }
    
    private func setupTableView() {
        
        makeTableViewConstraints()

        tableView.dataSource = self
        
        tableView.delegate = self
       
        tableView.register(CardCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func presentOtherSuggestion() {
        
        viewModel.presentOtherSuggestion(controller: self) { alert in
            
           present(alert, animated: true, completion: nil)
        }
    }
    
    private func addButtonSetup() {
        
        let setMyCards = UIBarButtonItem(
            title: "Мои карты",
            style: .plain,
            target: self,
            action: #selector(pushMyCardsVC)
        )
        
        let viewPlayers = UIBarButtonItem(
            title: "Игроки",
            style: .plain,
            target: self,
            action: #selector(pushPlayersListVC)
        )
        
        setMyCards.tintColor = .systemGreen
        viewPlayers.tintColor = .orange
        
        navigationItem.rightBarButtonItems = [ setMyCards,viewPlayers]
        
        navigationItem.setHidesBackButton(true, animated: false)
        
    }
    
    private  func replaceCard(newCard: Card) {
        
        viewModel.replaceCard(newCard: newCard) { value in
            
            tableView.reloadData()
            
            let message = "Вам показали новую карту: \(value)"
            
            DispatchQueue.main.async {
                
                self.showInfoAlertMessage(message: message)
            }
        }
    }

    private func choseCardsAlert() {
        
        let alert = UIAlertController(title: "Укажите свои карты ", message: nil, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Ок", style: .default) { (action) in
            self.pushMyCardsVC()
        }
        
        alert.addAction(confirm)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    private func presentSuggestionVC() {
        
        viewModel.suggestionVC.players = viewModel.players
        viewModel.suggestionVC.cards = viewModel.suggestion
        navigationController?.present(viewModel.suggestionVC, animated: true, completion: nil)
    }
    
    private func checkMySuggestion() {
        
        viewModel.suggestion.count == 3 ?  presentSuggestionVC() : showInfoAlertMessage(message: "Выберите комнату, личность и оружие")
    }
    
    private func checkOtherSuggestion() {
        
        viewModel.suggestion.count == 3 ?  presentOtherSuggestion() : showInfoAlertMessage(message: "Выберите комнату, личность и оружие")
    }
    
    private func choseGameCards() {
        
        guard viewModel.myCards.count != 0 else {
            
            choseCardsAlert()
            
            return
        }
    }
    
    @objc func pushMyCardsVC() {
        
        viewModel.myCardsVC.players = viewModel.players
        navigationController?.pushViewController(viewModel.myCardsVC, animated: true)
    }
    
    @objc func pushPlayersListVC() {
      
        viewModel.playersListViewController.players = viewModel.players
        navigationController?.pushViewController(viewModel.playersListViewController, animated: true)
    }
    
    @objc func mySuggestionPressed(sender: UIButton) {
        
        switch sender.tag {
        
        case 0: checkMySuggestion()
            
        case 1: checkOtherSuggestion()
           
        default: return
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        viewModel.numberOfRowsInSection(section: section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        viewModel.titleForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CardCell else {
            
            return UITableViewCell()
        }
        
        let card = viewModel.cardForRowAt(indexPath: indexPath)
        
        cell.setupUI(card: card)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel.tableView(tableView, didSelectRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        viewModel.tableViewHeightForRowAtIndexPath()
    }
}

extension ViewController: SuggestionViewControllerDelegate {
    
    func suggestionViewController(card: Card) {
        
        let cardOwner = card.owner
        
        cardOwner?.selfCards.append(card.cardType)
       
        replaceCard(newCard: card)
    }
}

extension ViewController: PlayerCanContainCardsDelegate {
    
    func returnPlayerWithCard(player: Person?, cards: [Card]) {
        
        viewModel.addHearingToPlayer(player:player, cards: cards)
        
        checkIfSomeCardsNotContain()
 
        viewModel.players.forEach { player in
            
            checkHearingContainAllCardsOrLess(player: player)
        }
    }
    
    func checkHearingContainAllCardsOrLess(player: Person?) {
        
        viewModel.checkHearingContainAllCardsOrLess(player: player) { card in
            
            replaceCard(newCard: card)
        }
    }
    
    func checkIfSomeCardsNotContain() {
        
        viewModel.checkIfSomeCardsNotContainCard { person in
            
            checkIfOneCardInContainArray(person: person)
        }
    }
    
    func checkIfOneCardInContainArray(person: Person?) {
        
        viewModel.checkIfOneCardInContainArray(person: person) { value in
            
            tableView.reloadData()

            DispatchQueue.main.async {
                self.showInfoAlertMessage(message: "Выявлена новая карта: \(value)")
            }
        }
    }
}

extension ViewController: PlayerNotContainCardsDelegate {
    
    func returnPlayer(player: Person?, cards: [Card]) {
        
        viewModel.returnPlayer(player: player,cards: cards) {
        
            checkIfSomeCardsNotContain()
        }
    }
}


//
//  ViewController.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 07.11.2020.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    var playersListViewController = PlayersListViewController()
    
    let myCardsVC = MyCardsViewController()
    
    let suggestionVC = SuggestionViewController()
    
    let otherSuggestionVC = OtherSuggestionViewController()
    
    var suggestion: [Card] = []
    
    let tableView = UITableView()
    
    let stackView = UIStackView()
    
    let buttonStackView = UIStackView()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap cards to add them to suggestion"
        return label
    }()
    
    let mySuggestion: UIButton = {
        let button = UIButton()
        button.setTitle("My Suggestion", for: .normal)
        button.backgroundColor = .blue
        button.tag = 0
        return button
    }()
    
    let otherSuggestion: UIButton = {
        let button = UIButton()
        button.setTitle("Other Suggestion", for: .normal)
        button.backgroundColor = .blue
        button.tag = 1
        return button
    }()
    
    var players = [Person?]()
    var myCards = [[Card]]()
//    var myPerson: Person?
//
//    public  var person2: Person?
//    public var person3: Person?
//    public var person4: Person?
//    public  var person5: Person?
//    public  var person6: Person?
//
//    let card1 = CardType.hero(.blue)
//    let card2 = CardType.room(.diningRoom)
//    let card3 = CardType.weapon(.bit)
//
//    let unknownCard1 = CardType.unknownCard
//    let unknownCard2 = CardType.unknownCard
//    let unknownCard3 = CardType.unknownCard
}
    
extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
     //   startGame()
        
        suggestionVC.delegate = self
        suggestionVC.playerNotContainCardsDelegate = self
        otherSuggestionVC.playerNotContainCardsDelegate = self
        otherSuggestionVC.playerCanContainCardsDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
        updateMyCards()
    }
}

extension ViewController {
    
    
  private func updateMyCards() {
        
        guard myCards.count > 0 else { return }
        
        players[0]?.selfCards = []
        
        myCards.forEach { section in
            section.forEach { card in
                if card.isSelected {
                    players[0]?.selfCards.append(card.cardType)
                }
            }
        }
    }
    
    private func setupUI() {
        
        view.addSubview(tableView)
        view.addSubview(stackView)
        view.backgroundColor = .red
        
        addButtonSetup()
        
        setupTableView()
        setupStackView()
        
        myCardsVC.delegate = self
        
        choseGameCards()
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
    
        let alert = UIAlertController(title: "Other Suggestion", message: "Select player, making suggestion", preferredStyle: .actionSheet)
        
        let actionSheet = players.filter { $0?.name !=  players[0]?.name }
      
        actionSheet.forEach { person in
            
            let alertAction = UIAlertAction(title: person?.name, style: .default) { action in
                self.otherSuggestionVC.user = self.players[0]
                self.otherSuggestionVC.cards = self.suggestion
                self.otherSuggestionVC.currentPlayer = person
                self.otherSuggestionVC.players = self.players
                self.navigationController?.present(self.otherSuggestionVC, animated: true, completion: nil)
            }
            alert.addAction(alertAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
   private func addButtonSetup() {
        
        let addPlayer = UIBarButtonItem(
            title: "Добавить игрока",
            style: .plain,
            target: self,
            action: #selector(buttonPressed)
        )
        
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
        
        addPlayer.tintColor = .systemBlue
        setMyCards.tintColor = .systemGreen
        viewPlayers.tintColor = .orange
        
        navigationItem.rightBarButtonItems = [ addPlayer, setMyCards,viewPlayers]
    }
    
   private func showAlert() {
        
        let alert = UIAlertController(title: "Укажите имена игроков", message: nil, preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: nil)
        
        let action = UIAlertAction(title: "Добавить игрока", style: .default) { [self] (action) in
            
            guard let textField = alert.textFields?[0],
                  let text = textField.text else {
                
                return
            }
            let player = Person(name: text, cards: [])
            
            self.players.append(player)
        }
        
        let cancel = UIAlertAction(title: "Отменить", style: .destructive, handler: nil)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
   private func unMarkSection(section index: Int) {
        
        var uncheckedCards: [Card] = []
        var cards: [[Card]] = []

        myCards.enumerated().forEach { section in
 
            uncheckedCards = []
            
            section.element.forEach { card in
                
                var card = card
                
                card.markIsShown = false
                
                uncheckedCards.append(card)
            }
            
            cards.append(uncheckedCards)
        }
        
        myCards[index] = cards[index]
    }
    
    private  func replaceCard(newCard: Card) {
        
        var newCard = newCard
        newCard.isSelected = true
        
        myCards.enumerated().forEach { section in
            
            section.element.enumerated().forEach { card in
                
                if card.element.cardType.value == newCard.cardType.value {
                    myCards[section.offset][card.offset] = newCard
                }
            }
            
        }
        tableView.reloadData()
        
        let message = "Вам показали новую карту '\(newCard.cardType.value)'  "
        
        DispatchQueue.main.async {
            self.showAlertMessage(message: message)
        }
        
    }
//
//   private func startGame() {
//
//        myPerson = Person(name: "Misha", cards: [card1,card2,card3])
//        person2 = Person(name: "Alex", cards: [])
//        person3 = Person(name: "Sasha", cards: [])
//        person4 = Person(name: "Ann", cards: [])
//        person5 = Person(name: "Nasty", cards: [])
//        person6 = Person(name: "Vlad", cards: [])
//        players = [myPerson,person2,person3,person4,person5,person6]
//
//    }
    

    private func showAlertMessage(message: String) {
        
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Понятно", style: .destructive, handler: nil)
        
        alert.addAction(confirm)
        
        present(alert, animated: true, completion: nil)
        
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
        
        suggestionVC.players = players
        suggestionVC.cards = suggestion
        navigationController?.present(suggestionVC, animated: true, completion: nil)
    }
    
    private func checkMySuggestion() {
        suggestion.count == 3 ?  presentSuggestionVC() : showAlertMessage(message: "Выберите комнату, личность и оружие")
    }
    
    private func checkOtherSuggestion() {
        suggestion.count == 3 ?  presentOtherSuggestion() : showAlertMessage(message: "Выберите комнату, личность и оружие")
    }
    
    private func choseGameCards() {
        guard myCards.count != 0 else {
            choseCardsAlert()
            return
        }
    }
    
    @objc func buttonPressed() {
        showAlert()
    }
    
    @objc func pushMyCardsVC() {
        myCardsVC.players = players
        navigationController?.pushViewController(myCardsVC, animated: true)
    }
    
    @objc func pushPlayersListVC() {
        playersListViewController.players = players
        navigationController?.pushViewController(playersListViewController, animated: true)
    }
    
    @objc func mySuggestionPressed(sender: UIButton) {
        switch sender.tag {
        case 0:
            checkMySuggestion()
            print("My suggestion")
        case 1:
            checkOtherSuggestion()
            print("Other suggestion")
        default:
            return
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        myCards[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        myCards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CardCell else {
            
            return UITableViewCell()
        }
        
        let card = myCards[indexPath.section][indexPath.row]
        
        cell.setupUI(card: card)

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Hero"
        }
        if section == 1 {
            return "Room"
        }
        else {
            return "Weapon"
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        suggestion.enumerated().forEach { card in
            
            if card.element.cardType.onlyType == myCards[indexPath.section][indexPath.row].cardType.onlyType {
                suggestion.remove(at: card.offset)
            }
        }
        
        if myCards[indexPath.section][indexPath.row].markIsShown {
            
            myCards[indexPath.section][indexPath.row].markIsShown = false
            
          suggestion =  suggestion.filter { $0 != myCards[indexPath.section][indexPath.row] }
        }
        
        else {
            unMarkSection(section: indexPath.section)
            
            myCards[indexPath.section][indexPath.row].markIsShown = true
            
            suggestion.append(myCards[indexPath.section][indexPath.row])
        }

        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
}

extension ViewController: MyCardsViewControllerDelegate {
    
    func myCardsViewController(cards: [[Card]]) {
     
        myCards = cards
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
        
        player?.addHearings(cards: cards)
     
        cards.forEach { card in
            
            let cardIsExist = player?.canContainCardsArray.contains(card.cardType)
            
            if cardIsExist != nil && cardIsExist == false && card.owner == nil {
               
                player?.canContainCardsArray.append(card.cardType)
            }
        }
        
        checkIfSomeCardsNotContain()
 
        players.forEach { player in
            checkHearingContainAllCardsOrLess(player: player)
        }
    }
    
    func checkHearingContainAllCardsOrLess(player: Person?) {
        
        var increment = 0
        var filterArray = [CardType]()
        
        player?.hearings.enumerated().forEach { section in
            
            section.element.forEach { card in
                
                guard let contains = player?.canContainCardsArray.contains(card) else { return }
                
                if !contains {
                    
                    increment = increment + 1
                    
                    filterArray.append(card)
                }
            }
            
            if increment == 2 {
                
                let filtered = player?.hearings[section.offset].filter {
                    
                    !filterArray.contains($0)
                }
                
                guard let newCardType = filtered?[0] else { return }
                
                let card = Card(cardType: newCardType, isSelected: true, markIsShown: false, owner: player)
                
                print("NEW CARD")
                
                player?.selfCards.append(newCardType)
         
                replaceCard(newCard: card)
                
                guard let safeValues =  player?.canContainCardsArray else { return}
                
                player?.canContainCardsArray = safeValues.filter { $0 != newCardType }
                return
            }
            
            increment = 0
        }
        
    }
    
    func checkIfSomeCardsNotContain() {
        
        players.forEach { person in
            
            person?.notContainCardsArray.enumerated().forEach { card in
                
                let contain = person?.canContainCardsArray.contains(card.element)
                
                if contain == true, contain != nil {
                    
                    if let filtred = person?.canContainCardsArray.filter({ $0 != card.element}) {
                        
                        person?.canContainCardsArray = filtred
                        
                    }
                }
            }
            
         //   checkIfOneCardInContainArray(person: person)
        }
    }
    
//    func checkIfOneCardInContainArray(person: Person?) {
//
//        guard var cards = person?.canContainCardsArray else { return }
//
//        if  cards.count == 1 {
//            person?.selfCards.append(cards[0])
//
//            myCards.enumerated().forEach {  section in
//                section.element.enumerated().forEach { myCard in
//
//                    if myCard.element.cardType == cards[0] {
//                        myCards[section.offset][myCard.offset].owner = person
//                        myCards[section.offset][myCard.offset].isSelected = true
//
//                        tableView.reloadData()
//
//                        DispatchQueue.main.async {
//                            self.showAlertMessage(message: "Выявлена новая карта: \(myCard.element.cardType.value)")
//                        }
//                    }
//                }
//            }
//
//            //Очищаем массив предположения
//             cards = []
//        }
//    }
}

extension ViewController: PlayerNotContainCardsDelegate {
    
    func returnPlayer(player: Person?, cards: [Card]) {
        
        cards.forEach { card in
            
            let cardIsExist = player?.notContainCardsArray.contains(card.cardType)
            
            if cardIsExist != nil && cardIsExist == false {
               
                player?.notContainCardsArray.append(card.cardType)
            }
        }
        checkIfSomeCardsNotContain()
    }
}


//
//  StartViewController.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 07.11.2020.
//

import UIKit
import SnapKit

class StartViewController: BaseViewController {
    
    let detailVC = ViewController()
    
    var fields: [PlayerTextField] = []
    
    var players: [Person] = []
    
    let scrollView = UIScrollView()
    
    let mainView = UIView()
    
    let contentView = UIView()
    
    let stackView = UIStackView()
    
    let TextFieldStackViewOne = PlayerStackView()
    let TextFieldStackViewTwo = PlayerStackView()
    let TextFieldStackViewThree = PlayerStackView()
    let TextFieldStackViewFour = PlayerStackView()
    let TextFieldStackViewFive = PlayerStackView()
    
    let yourPlayerTextField = PlayerTextField()
    let player2TextField = PlayerTextField()
    let player3TextField = PlayerTextField()
    let player4TextField = PlayerTextField()
    let player5TextField = PlayerTextField()
    let player6TextField = PlayerTextField()
    let player7TextField = PlayerTextField()
    let player8TextField = PlayerTextField()
    let player9TextField = PlayerTextField()
    let player10TextField = PlayerTextField()
    
//    let startGameButton: UIButton = {
//
//        let button = UIButton()
//        button.addTarget(self, action: #selector( pushVC), for: .touchUpInside)
//        button.setTitle("Create Game", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.backgroundColor = .lightGray
//
//        return button
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        
        title = "Настройка игры"
        
        view.addSubview(mainView)
     //   view.addSubview(startGameButton)
        
        mainView.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(TextFieldStackViewOne)
        stackView.addArrangedSubview(TextFieldStackViewTwo)
        stackView.addArrangedSubview(TextFieldStackViewThree)
        stackView.addArrangedSubview(TextFieldStackViewFour)
        stackView.addArrangedSubview(TextFieldStackViewFive)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        setupConstraints()
        
        setupTextFields()
        
        addGestures()
        
        setupBarItems()
        
        addTextFieldsToArray()
    }
}

extension StartViewController {
    
    func setupConstraints() {
        
        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
//        startGameButton.snp.makeConstraints { make in
//
//            make.bottom.equalToSuperview()
//            make.left.right.equalToSuperview()
//            make.height.equalTo(50)
//            make.top.equalTo(mainView.snp.bottom)
//        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(mainView)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(view)
            make.width.equalTo(scrollView)
            make.height.equalTo(scrollView)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(30)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().inset(10)

        }
    }
    
    func addTextFieldsToArray() {
        
        fields.append(yourPlayerTextField)
        fields.append(player2TextField)
        fields.append(player3TextField)
        fields.append(player4TextField)
        fields.append(player5TextField)
        fields.append(player6TextField)
        fields.append(player7TextField)
        fields.append(player8TextField)
        fields.append(player9TextField)
        fields.append(player10TextField)
    }
    
    func createPlayers() {
        fields.forEach { field in
            
            let notEmpty = field.text?.isEmpty
            
            if notEmpty == false {
                
                if let text = field.text {
                    
                    let person = Person(name: text, cards: [])
                    players.append(person)
                }
                
            }
        }
    }
    
    func checkPlayerNameIsEntered() -> Bool {
        
        guard let isEmpty = fields.first?.text?.isEmpty else { return false }
        
        let returnValue: Bool
        
        isEmpty ? (returnValue = false) : (returnValue = true)
        
        return returnValue
    }
    
    func setupBarItems() {
        
        let createGame = UIBarButtonItem(
            title: "Начать",
            style: .plain,
            target: self,
            action: #selector(pushVC)
        )
        
        createGame.tintColor = .systemBlue
        
        navigationItem.rightBarButtonItem = createGame
    }
    
    func addPlayersTextFields() {
        
        TextFieldStackViewOne.addArrangedSubview(yourPlayerTextField)
        TextFieldStackViewOne.addArrangedSubview(player2TextField)
        
        TextFieldStackViewTwo.addArrangedSubview(player3TextField)
        TextFieldStackViewTwo.addArrangedSubview(player4TextField)
        
        TextFieldStackViewThree.addArrangedSubview(player5TextField)
        TextFieldStackViewThree.addArrangedSubview(player6TextField)
        
        TextFieldStackViewFour.addArrangedSubview(player7TextField)
        TextFieldStackViewFour.addArrangedSubview(player8TextField)
        
        TextFieldStackViewFive.addArrangedSubview(player9TextField)
        TextFieldStackViewFive.addArrangedSubview(player10TextField)
        
    }
    
    func setupTextFields() {
        
        addPlayersTextFields()
        
        yourPlayerTextField.placeholder = "Ваше имя"
        
        player3TextField.placeholder = "Имя игрока № 3"
        
        player5TextField.placeholder = "Имя игрока № 5"
        
        player7TextField.placeholder = "Имя игрока № 7"
        
        player9TextField.placeholder = "Имя игрока № 9"
        
        
        player2TextField.placeholder = "Имя игрока № 2"
        
        player4TextField.placeholder = "Имя игрока № 4"
        
        player6TextField.placeholder = "Имя игрока № 6"
        
        player8TextField.placeholder = "Имя игрока № 8"
        
        player10TextField.placeholder = "Имя игрока № 10"
        
    }
    
    func addGestures() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(performGesture))
        
        tapGesture.numberOfTouchesRequired = 1
        
        mainView.addGestureRecognizer(tapGesture)
        
        mainView.backgroundColor = .red
    }
    
    @objc func performGesture(_ sender: UITapGestureRecognizer? = nil) {
        
        yourPlayerTextField.resignFirstResponder()
        player2TextField.resignFirstResponder()
        player3TextField.resignFirstResponder()
        player4TextField.resignFirstResponder()
        player5TextField.resignFirstResponder()
        player6TextField.resignFirstResponder()
        player7TextField.resignFirstResponder()
        player8TextField.resignFirstResponder()
        player9TextField.resignFirstResponder()
        player10TextField.resignFirstResponder()
    }
    
    @objc func pushVC() {
        
        if checkPlayerNameIsEntered() {
            players = []
            createPlayers()
            detailVC.viewModel.players = players
            
            navigationController?.pushViewController(detailVC, animated: true)
        }
        
        else {
            showInfoAlertMessage(message: "Укажите свое имя")
        }
    }
}



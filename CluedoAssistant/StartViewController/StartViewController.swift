//
//  StartViewController.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 07.11.2020.
//

import UIKit
import SnapKit

class StartViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let detailVC = ViewController()
    
    let startGameButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        button.setTitle("Create Game", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        return button
    }()
    
    
    
    let textField = UITextField()

    let scrollView = UIScrollView()
    
    let contentView = UIView()
    let mainView = UIView()
    
    let stackView = UIStackView()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupUI()
    }
    
    func setupConstraints() {

        mainView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        startGameButton.snp.makeConstraints { make in

            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
            make.top.equalTo(mainView.snp.bottom)
        }
        
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
           // make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
   
    let TextFieldStackViewOne = PlayerStackView()
    let TextFieldStackViewTwo = PlayerStackView()
    let TextFieldStackViewThree = PlayerStackView()
    let TextFieldStackViewFour = PlayerStackView()
    let TextFieldStackViewFive = PlayerStackView()

  
    
    
    
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
    
    var fields: [PlayerTextField] = []
    var players: [Person] = []
    
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
    
    func setupBarItems() {
        let createGame = UIBarButtonItem(
            title: "Начать игру",
            style: .plain,
            target: self,
            action: #selector(pushVC)
        )
            
        createGame.tintColor = .systemBlue
 
            navigationItem.rightBarButtonItem = createGame
    }
    @objc func pushVC() {
        createPlayers()
        detailVC.players = players
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func setupUI() {
        addGestures()
        setupBarItems()
        addTextFieldsToArray()
        
        title = "Game Setup"
  
        view.addSubview(mainView)
        view.addSubview(startGameButton)
        
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
        
//        leftTextFieldStackView.backgroundColor = .orange
//        rightTextFieldStackView.backgroundColor = .green
 
        
//        leftTextFieldStackView.spacing = 10
//        leftTextFieldStackView.distribution = .fillEqually
        
  //      rightTextFieldStackView.spacing = 10
    //    rightTextFieldStackView.distribution = .fillEqually
        
//        contentView.backgroundColor = .purple
//        mainView.backgroundColor = .red
        
        
        setupConstraints()
        
        setupTextFields()
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
        
        yourPlayerTextField.placeholder = "Your Name"
   
        player3TextField.placeholder = "Player 3's Name"
        
        player5TextField.placeholder = "Player 5's Name"
        
        player7TextField.placeholder = "Player 7's Name"
        
        player9TextField.placeholder = "Player 9's Name"
        

        player2TextField.placeholder = "Player 2's Name"
        
        player4TextField.placeholder = "Player 4's Name"
        
        player6TextField.placeholder = "Player 6's Name"
        
        player8TextField.placeholder = "Player 8's Name"
        
        player10TextField.placeholder = "Player 10's Name"
        
    }
    
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
    
    
    
    
    @objc func startGame() {
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}


class PlayerTextField: UITextField {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.backgroundColor = .blue
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PlayerStackView: UIStackView {
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.axis = .horizontal
        self.spacing = 5
        self.distribution = .fillEqually
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

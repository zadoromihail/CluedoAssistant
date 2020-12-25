//
//  SpreadshitViewController.swift
//  MySpreadsheetViewTest
//
//  Created by Михаил Задорожный on 17.11.2020.
//

import UIKit
import SnapKit
import SpreadsheetView

class SpreadshitViewController: UIViewController {
    
    var spreadsheetView: SpreadsheetView = {
        let spread = SpreadsheetView()
        return spread
    }()
    
    func setupConstraints() {
        spreadsheetView.snp.makeConstraints { make in
            make.edges.equalTo(view).offset(10).inset(10)
        }
    }
    
    var players : [Person?] = []
    var greenRows: [IndexPath] = []
    
    let cards = CardType.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(spreadsheetView)
        view.backgroundColor = .white
        
        setupConstraints()
        spreadsheetView.dataSource = self
        spreadsheetView.delegate = self

        let hairline = 1 / UIScreen.main.scale
        spreadsheetView.intercellSpacing = CGSize(width: hairline, height: hairline)
        spreadsheetView.gridStyle = .solid(width: hairline, color: .lightGray)

        spreadsheetView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
        spreadsheetView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))
        spreadsheetView.register(TaskCell.self, forCellWithReuseIdentifier: String(describing: TaskCell.self))
        spreadsheetView.register(ChartBarCell.self, forCellWithReuseIdentifier: String(describing: ChartBarCell.self))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        spreadsheetView.flashScrollIndicators()
        spreadsheetView.reloadData()
    }
}

// MARK: DataSource

extension SpreadshitViewController: SpreadsheetViewDataSource {

    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1  + players.count
    }

    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 1 + cards.count
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        
        if case 0 = column {
            return 90

        } else {
            return 50
        }
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        
        if case 0 = row {
            
            return 28
            
        } else {
            
            return 50
        }
    }

    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        
        switch (indexPath.column, indexPath.row) {
        
        case (0, 0):
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            
            cell.label.text = "Card / Player"
            cell.gridlines.left = .default
            cell.gridlines.right = .default
            return cell


        case (1..<(1 + players.count), 0):
            
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            
            cell.label.text = players[indexPath.column - 1]?.name
            cell.gridlines.left = .default
            cell.gridlines.right = .default
            
            return cell

        case (0, 1..<(1 + cards.count)):
            
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TaskCell.self), for: indexPath) as! TaskCell
            
            cell.label.text = cards[indexPath.row - 1].value
            cell.gridlines.left = .default
            cell.gridlines.right = .default
            
            return cell

        case (1..<(1 +  players.count), 1..<(1 + cards.count)):
            
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: ChartBarCell.self), for: indexPath) as! ChartBarCell
            
            let contain = cards[indexPath.row - 1]
            
            let player = players[indexPath.column - 1]
            
            let selfCards = player?.selfCards.contains(contain)
            
            let canContainCardsArray = player?.canContainCardsArray.contains(contain)
            
            let notContain =  player?.notContainCardsArray.contains(contain)
            
            if greenRows.contains(indexPath) {
                cell.backgroundColor = .green
            }
            
            if  selfCards != nil && selfCards == true {
                
                cell.imageView.image = UIImage(named: "tick")

                var iPath = indexPath
                
                for i in 1 ... (1 + cards.count) {
                    
                    iPath.section = i
                    greenRows.contains(iPath) ? () : ( greenRows.append(iPath) )
                    spreadsheetView.cellForItem(at: iPath)?.backgroundColor = .green
                }
                cell.backgroundColor = .green
            }
            
            if  canContainCardsArray != nil && canContainCardsArray == true {
                if selfCards == false {
                    cell.imageView.image = UIImage(named: "question")
                }
                else {
                    cell.imageView.image = UIImage(named: "tick")
                }
               
            }
            
            if  notContain != nil && notContain == true {
                cell.imageView.image = UIImage(named: "close")
            }
            
            return cell
            
        default:
            return nil
        }
    }
}

extension SpreadshitViewController: SpreadsheetViewDelegate {
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: (row: \(indexPath.row), column: \(indexPath.column))")
    }
}

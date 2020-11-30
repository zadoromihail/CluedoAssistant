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
                cell.imageView.image = UIImage(named: "question")
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









//     let start = Int(tasks[indexPath.row - 1][1])!

// if start == indexPath.column - 2 {

   // cell.label.text = tasks[indexPath.row - 1][0]

  //  let colorIndex = Int(tasks[indexPath.row - 1][2])!
   // cell.color = colors[colorIndex]
//            } else {
//                cell.label.text = ""
//                cell.color = .clear
//            }



//    let colors = [UIColor(red: 0.314, green: 0.698, blue: 0.337, alpha: 1),
//                  UIColor(red: 1.000, green: 0.718, blue: 0.298, alpha: 1),
//                  UIColor(red: 0.180, green: 0.671, blue: 0.796, alpha: 1)]

//
//        case (1, 0):
//            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
//            cell.label.text = "Start"
//            cell.gridlines.left = .solid(width: 1 / UIScreen.main.scale, color: cell.backgroundColor!)
//            cell.gridlines.right = cell.gridlines.left
//            return cell

//        case (2, 0):
//            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
//            cell.label.text = "Duration"
//            cell.label.textColor = .gray
//            cell.gridlines.left = .none
//            cell.gridlines.right = .default
//            return cell


//        case (1, 2..<(2 + tasks.count)):
//            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TextCell.self), for: indexPath) as! TextCell
//            cell.label.text = String(format: "April %02d", Int(tasks[indexPath.row - 2][1])!)
//            cell.gridlines.left = .none
//            cell.gridlines.right = .none
//            return cell
//        case (2, 2..<(2 + tasks.count)):
//            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TextCell.self), for: indexPath) as! TextCell
//            cell.label.text = tasks[indexPath.row - 2][2]
//            cell.gridlines.left = .none
//            cell.gridlines.right = .none
//            return cell


//    func mergedCells(in spreadsheetView: SpreadsheetView) -> [CellRange] {
//
//        let titleHeader = [CellRange(from: (0, 0), to: (1, 0)),
//                           CellRange(from: (0, 1), to: (1, 1)),
//                           CellRange(from: (0, 2), to: (1, 2))]
//
//        let weakHeader = weeks.enumerated().map { (index, _) -> CellRange in
//            return CellRange(from: (0, index * 7 + 3), to: (0, index * 7 + 9))
//        }
//
//        let charts = tasks.enumerated().map { (index, task) -> CellRange in
//            let start = Int(task[1])!
//            let end = Int(task[2])!
//            return CellRange(from: (index + 2, start + 2), to: (index + 2, start + end + 2))
//        }
//
//        return titleHeader + weakHeader + charts
//    }

//
//    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
//        return 3
//    }
//
//    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
//        return 2
//    }

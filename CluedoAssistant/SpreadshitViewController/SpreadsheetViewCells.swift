//
//  SpreadsheetViewCells.swift
//  SpreadsheetView
//
//  Created by Kishikawa Katsumi on 5/8/17.
//  Copyright © 2017 Kishikawa Katsumi. All rights reserved.
//

import UIKit
import SpreadsheetView

class HeaderCell: Cell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.95, alpha: 1.0)

        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .gray

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class TextCell: Cell {
    let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class TaskCell: Cell {
    let label = UILabel()

    override var frame: CGRect {
        didSet {
            label.frame = bounds.insetBy(dx: 2, dy: 2)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0

        contentView.addSubview(label)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class ChartBarCell: Cell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundColor = .clear
        imageView.image = nil
    }
    
    let colorBarView = UIView()

    let imageView = UIImageView()
    
    var color: UIColor = .clear {
        didSet {
            colorBarView.backgroundColor = color
        }
    }

    override var frame: CGRect {
        didSet {
            colorBarView.frame = bounds.insetBy(dx: 2, dy: 2)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(colorBarView)
        contentView.addSubview(imageView)
        
        imageView.frame = bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

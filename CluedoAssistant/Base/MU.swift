//
//  MU.swift
//  CluedoAssistant
//
//  Created by Михаил Задорожный on 27.11.2020.
//

import Foundation
import UIKit

class MUModel: NSObject {
    
    // MARK: - Public properties
    
    var primaryKey: String { return defaultKey ?? "" }
    
    var defaultKey: String?

    // MARK: Override methods

    override func isEqual(_ object: Any?) -> Bool {

        if let item = object as? MUModel {

            return primaryKey == item.primaryKey
        } else {
            return false
        }
    }

    // MARK: - Public methods

    func updateBeforeEncode() { }

    func updateAfterDecode() { }
}

// MARK: - MUCodable

protocol MUCodable: Codable {
    
    func updateBeforeEncode()
    
    func updateAfterDecode()
    
    static func updateBeforeParsing( rawData: inout [String : Any])
}

// MARK: - MUCodable

extension MUCodable {

    // MARK: - Public methods

    static func updateBeforeParsing( rawData: inout [String : Any]) { }

    func updateBeforeEncode() { }

    func updateAfterDecode() { }
}

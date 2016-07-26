//
//  SearchableRecord.swift
//  Morse Chat
//
//  Created by Mason Earl on 7/26/16.
//  Copyright © 2016 trianglez. All rights reserved.
//

import Foundation

@objc protocol SearchableRecord: class {

    func matchesSearchTerm(searchTerm: String) -> Bool
}

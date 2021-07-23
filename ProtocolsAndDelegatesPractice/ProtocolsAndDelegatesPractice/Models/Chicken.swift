//
//  Chicken.swift
//  ProtocolsAndDelegatesPractice
//
//  Created by Ben Erekson on 7/22/21.
//

import Foundation

class Chicken: Codable {
    
    init(name: String, birthDate: Date, weight: Double, personalityTraits: String) {
        self.name = name
        self.birthDate = birthDate
        self.weight = weight
        self.personalityTraits = personalityTraits

    }
    
    var name: String
    var birthDate: Date
    var weight: Double
    var personalityTraits: String

    
    
}

extension Chicken: Equatable {
    static func == (lhs: Chicken, rhs: Chicken) -> Bool {
        return lhs.name == rhs.name && lhs.birthDate == rhs.birthDate && lhs.personalityTraits == rhs.personalityTraits && lhs.weight == rhs.weight
    }
}

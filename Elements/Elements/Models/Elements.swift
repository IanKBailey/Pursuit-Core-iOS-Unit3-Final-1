//
//  Elements.swift
//  Elements
//
//  Created by Ian Bailey on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation

struct Element: Codable {
    let name: String
    let number: Int
    let atomicMass: Double?
    let boil: Double?
    let discoveredBy: String?
    let melt: Double?
    let symbol: String
    let favoritedBy: String?
        
        private enum CodingKeys: String, CodingKey {
            case name
            case number
            case atomicMass = "atomic_mass"
            case boil
            case discoveredBy = "discovered_by"
            case melt
            case symbol
            case favoritedBy
        }
}

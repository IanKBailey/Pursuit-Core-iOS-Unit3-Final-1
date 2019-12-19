//
//  Elements.swift
//  Elements
//
//  Created by Ian Bailey on 12/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation
struct ElementsData: Decodable {
    let DataOfElements: [ElementData]
}
    struct ElementData: Decodable {
    let name: String
    let appearance: String?
    let atomicMass: Double?
    let boil: Double?
    let category: String
    let color: String?
    let density: Double?
    let discoveredBy: String?
    let melt: Double?
    let molarHeat: Double?
    let namedBy: String?
    let number: Int
    let period: Int
    let phase: String
    let source: String
    let spectralImg: URL?
    let summary: String
    let symbol: String
    let xpos: Int
    let ypos: Int
        
        
}

//
//  Mission.swift
//  t'the Moon
//
//  Created by Parth Antala on 2024-07-09.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct crewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: String?
    let crew: [crewRole]
    let description: String

}

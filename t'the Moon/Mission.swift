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
    let launchDate: Date?
    let crew: [crewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }

}

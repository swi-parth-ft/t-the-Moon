//
//  ContentView.swift
//  t'the Moon
//
//  Created by Parth Antala on 2024-07-09.
//

import SwiftUI



struct ContentView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        VStack {
            List {
                Text(String(astronauts.count))
                Text(String(missions.count))
            }
        }
        .padding ()
    }
}

#Preview {
    ContentView()
}

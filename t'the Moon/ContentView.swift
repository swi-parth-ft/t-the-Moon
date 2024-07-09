//
//  ContentView.swift
//  t'the Moon
//
//  Created by Parth Antala on 2024-07-09.
//

import SwiftUI



struct ContentView: View {
    
    let astronauts = Bundle.main.decode("astronauts.json")
    
    var body: some View {
        VStack {
            List {
                Text(String(astronauts.count))
            }
        }
        .padding ()
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  t'the Moon
//
//  Created by Parth Antala on 2024-07-09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("duke")
                .resizable()
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { size, axis in
                        size * 0.8
                    }
             
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

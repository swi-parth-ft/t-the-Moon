//
//  AstronautView.swift
//  t'the Moon
//
//  Created by Parth Antala on 2024-07-09.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut

        var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .fill(.white)
                            .opacity(0.4)
                            .shadow(radius: 10)
                            .containerRelativeFrame(.horizontal) { width, axis in
                                width * 0.8
                            }
                            
                        
                        Image(astronaut.id)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(23)
                            .shadow(radius: 10)
                            .containerRelativeFrame(.horizontal) { width, axis in
                                width * 0.6
                            }
                            .padding()
                    }
                    .padding()

                    Text(astronaut.description)
                        .padding()
                }
            }
            .background(.darkBackground)
            .navigationTitle(astronaut.name)
            .navigationBarTitleDisplayMode(.inline)
        }
}

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

        return AstronautView(astronaut: astronauts["aldrin"]!)
            .preferredColorScheme(.dark)
}

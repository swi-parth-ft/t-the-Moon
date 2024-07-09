//
//  MissionView.swift
//  t'the Moon
//
//  Created by Parth Antala on 2024-07-09.
//

import SwiftUI

struct MissionView: View {
    
    let mission: Mission
    
    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                
                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Text(mission.description)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

#Preview {
    
    let mission: [Mission] = Bundle.main.decode("missions.json")
    MissionView(mission: mission[0])
        .preferredColorScheme(.dark)
}

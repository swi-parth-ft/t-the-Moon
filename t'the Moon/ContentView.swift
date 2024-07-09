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
    @State private var isListView = false
    
    let columns = [
        GridItem(.adaptive(minimum: 150, maximum: 200))
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            HStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .shadow(radius: 10)
                                    .padding()
                                
                                VStack(alignment: .leading) {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                        
                    }
                }
                .opacity(isListView ? 1 : 0)
                
                ScrollView {
                    
                    LazyVGrid(columns: columns) {
                        ForEach(missions) { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronauts)
                            } label: {
                                VStack {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.white)
                                            .opacity(0.4)
                                            .shadow(radius: 10)
                                        
                                        
                                        VStack {
                                            Image(mission.image)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 100, height: 100)
                                                .shadow(radius: 10)
                                                .padding()
                                            
                                            VStack {
                                                Text(mission.displayName)
                                                    .font(.headline)
                                                    .foregroundStyle(.white)
                                                Text(mission.formattedLaunchDate)
                                                    .font(.caption)
                                                    .foregroundStyle(.white)
                                            }
                                            .padding(.vertical)
                                            .frame(maxWidth: .infinity)
                                            .background(.white.opacity(0.3))
                                        }
                                    }
                                }
                                .clipShape(.rect(cornerRadius: 10))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightBackground)
                                }
                            }
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                .opacity(isListView ? 0 : 1)
                
            }
            .navigationTitle("Missions")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    withAnimation {
                        isListView.toggle()
                    }
                } label: {
                    if isListView {
                        return Image(systemName: "square.grid.2x2")
                    } else {
                        return Image(systemName: "checklist.unchecked")
                    }
                }
                .tint(.white)
            }
        }
    }
}

#Preview {
    ContentView()
}

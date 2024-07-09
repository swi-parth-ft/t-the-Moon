//
//  MissionView.swift
//  t'the Moon
//
//  Created by Parth Antala on 2024-07-09.
//

import SwiftUI
struct AstronautCard: View {
    var crewMember: MissionView.CrewMember
    @State private var dragAmount = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color.black.opacity(1))
                    .shadow(radius: 10)
                    .frame(width: 230, height: 240)
                    .padding()
                
                VStack {
                    ZStack {
                        VStack {
                            
                            ZStack(alignment: .topTrailing) {
                                
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 208, height: 144)
                                    .cornerRadius(12)
                                
                             
                            }
                            
                            
                            
                            VStack(alignment: .center) {
                                NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                                    Text("\(crewMember.astronaut.name) ") +  Text(Image(systemName: "info.circle"))
                                        .foregroundColor(.white)
                                        .font(.headline)
                                }
                                Text(crewMember.role)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                        }
                    }
                }
                
                .shadow(radius: 10)
                .offset(x: isDragging ? dragAmount.width : 0)
                
            }
        
    }
}
struct MissionView: View {
    
    @State private var showCards = false
    @State private var isCardRemoved = false
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    @State private var crew: [CrewMember]
    
    private var cards: [AstronautCard] {
        crew.map { crewMember in
            AstronautCard(crewMember: crewMember)
        }
    }
    
    @State private var dragAmount = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            
            VStack(alignment: .leading) {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .fill(.white)
                            .opacity(0.4)
                            .shadow(radius: 10)
                            .frame(width: 200, height: 200)
                        
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .containerRelativeFrame(.horizontal) { width, axis in
                                width * 0.4
                            }
                            .padding()
                    }
                    .padding()
                    
                    
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        Rectangle()
                            .frame(height: 2)
                            .foregroundStyle(.lightBackground)
                            .padding(.vertical)
                        
                       
                        
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(mission.description)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundStyle(.lightBackground)
                            .padding(.vertical)
                        
                       
                        
                        
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
               
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
            .toolbar {
                Button(showCards ? "Hide" : "Crew") {
                    withAnimation {
                        showCards.toggle()
                    }
                }
                .buttonStyle()
            }
            
            GeometryReader { geometry in
                            VStack {
                                Spacer()
                                VisualEffectBlur(blurStyle: .systemMaterial)
                                    .frame(height: geometry.size.height * 0.5) // Blurs the bottom 30% of the screen
                                    .mask(
                                                                LinearGradient(
                                                                    gradient: Gradient(colors: [Color.white.opacity(0.0), Color.white.opacity(0.9)]),
                                                                    startPoint: .top,
                                                                    endPoint: .center
                                                                )
                                                            )
                            }
                            .opacity(showCards ? 1 : 0)
                            .edgesIgnoringSafeArea(.all) // Ensure the blur covers the entire width of the screen
                        }
            
            VStack(alignment: .leading) {
                
                ZStack {
                    ForEach(crew.indices, id: \.self) { index in
                     //   NavigationLink(destination: AstronautView(astronaut: crew[index])) {
                            cards[index]
                                .offset(x: isDragging && index == cards.count - 1 ? dragAmount.width : CGFloat(index) * 15,
                                        y: isDragging && index == crew.count - 1 ? dragAmount.height : CGFloat(index) * 15)
                                .opacity(isDragging && index == crew.count - 1 ? 1 - Double(abs(dragAmount.width) / 100) : 1)
                            //   .animation(.spring(), value: dragAmount)
                                .gesture(
                                    index == cards.count - 1 ? DragGesture()
                                        .onChanged { value in
                                            dragAmount = value.translation
                                            isDragging = true
                                        }
                                        .onEnded { value in
                                            if abs(value.translation.width) > 100 {
                                                //   withAnimation {
                                                isCardRemoved = true
                                                let firstCard = crew.removeLast()
                                                crew.insert(firstCard, at: 0)
                                                //    fadeOutAndRemoveCard()
                                                //  }
                                            }
                                            dragAmount = .zero
                                            isDragging = false
                                        } : nil // Apply gesture only to the top card
                                )
                     //   }
                    }
                    .animation(.smooth(duration: 1), value: isCardRemoved)
                }
            }
            .opacity(showCards ? 1 : 0)
            
            
    }
    }
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Could not find astronaut with name: \(member.name)")
            }
        }
        
        
    }
    
    private func fadeOutAndRemoveCard() {
            withAnimation {
                var topCardIndex = cards.count - 1
                // Move the card out of view
                dragAmount.width = dragAmount.width > 0 ? UIScreen.main.bounds.width : -UIScreen.main.bounds.width
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    // After animation completes, move the top card to the back
                    let removedCard = crew.remove(at: topCardIndex)
                    crew.append(removedCard)
                    dragAmount = .zero
                    isDragging = false
                    // Increment topCardIndex to keep track of the new top card
                    topCardIndex += 1
                    if topCardIndex >= crew.count {
                        topCardIndex = 0
                    }
                }
            }
        }
    
    
}

struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

struct ButtonViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .buttonStyle(.borderedProminent)
        .tint(.purple.opacity(0.4))
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

extension View {
    func buttonStyle() -> some View {
        modifier(ButtonViewModifier())
    }
}

#Preview {
    
    let mission: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    MissionView(mission: mission[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}

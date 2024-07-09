import SwiftUI

struct CardView: View {
    var color: Color
    var number: Int
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: 300, height: 200)
            .overlay(
                Text("Card \(number)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            )
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}

struct Stack: View {
    @State private var cards = [
        CardView(color: .red, number: 1),
        CardView(color: .green, number: 2),
        CardView(color: .blue, number: 3)
    ]
    
    @State private var dragAmount = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(cards.indices, id: \.self) { index in
                    cards[index]
                        .offset(x: isDragging && index == cards.count - 1 ? dragAmount.width : .zero,
                                y: CGFloat(index) * 10)
                        .animation(.spring(), value: dragAmount)
                        .gesture(
                            index == cards.count - 1 ? DragGesture()
                                .onChanged { value in
                                    dragAmount = value.translation
                                    isDragging = true
                                }
                                .onEnded { value in
                                    if abs(value.translation.width) > 100 {
                                        withAnimation {
                                            let firstCard = cards.removeLast()
                                            cards.insert(firstCard, at: 0)
                                        }
                                    }
                                    dragAmount = .zero
                                    isDragging = false
                                } : nil // Apply gesture only to the top card
                        )
                }
            }
            .frame(height: 300)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Stack()
    }
}

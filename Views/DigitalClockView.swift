import SwiftUI

struct DigitalClockView: View {
    @StateObject private var viewModel = ClockViewModel()
    @State private var use24Hour = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)]),
                startPoint: .topLeadingCenter,
                endPoint: .bottomTrailingCorner
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Text("Digital Clock")
                    .font(.title)
                    .fontWeight(.bold)
                
                VStack(spacing: 20) {
                    Text(viewModel.formattedTime(use24Hour: use24Hour))
                        .font(.system(size: 80, weight: .bold, design: .monospaced))
                        .foregroundColor(.blue)
                    
                    if !use24Hour {
                        Text(viewModel.period())
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }
                .padding(30)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 10)
                
                Toggle("24 Hour Format", isOn: $use24Hour)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                Spacer()
            }
            .padding()
        }
    }
}

extension Gradient {
    static let topLeadingCenter = LinearGradient.init(
        gradient: Gradient(colors: [.blue, .clear, .purple]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}

extension LinearGradient.startPoint {
    static let topLeadingCenter = UnitPoint(x: 0, y: 0)
}

extension LinearGradient.endPoint {
    static let bottomTrailingCorner = UnitPoint(x: 1, y: 1)
}

#Preview {
    DigitalClockView()
}

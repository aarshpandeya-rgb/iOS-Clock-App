import SwiftUI

struct AnalogClockView: View {
    @StateObject private var viewModel = ClockViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.orange.opacity(0.1), Color.red.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Text("Analog Clock")
                    .font(.title)
                    .fontWeight(.bold)
                
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 300, height: 300)
                        .shadow(radius: 10)
                    
                    // Clock numbers
                    ForEach(1...12, id: \.self) { number in
                        VStack {
                            Text("\(number)")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .frame(width: 300, height: 300)
                        .rotationEffect(.degrees(Double(number - 3) * 30))
                    }
                    
                    // Hour hand
                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 8, height: 80)
                        .offset(y: -40)
                        .rotationEffect(.degrees(hourHandAngle()))
                    
                    // Minute hand
                    Rectangle()
                        .fill(Color.gray)
                        .frame(width: 6, height: 100)
                        .offset(y: -50)
                        .rotationEffect(.degrees(minuteHandAngle()))
                    
                    // Second hand
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 3, height: 110)
                        .offset(y: -55)
                        .rotationEffect(.degrees(secondHandAngle()))
                    
                    // Center circle
                    Circle()
                        .fill(Color.black)
                        .frame(width: 15, height: 15)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func hourHandAngle() -> Double {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: viewModel.currentTime)
        let hour = Double(components.hour ?? 0)
        let minute = Double(components.minute ?? 0)
        return (hour.truncatingRemainder(dividingBy: 12) + minute / 60) * 30
    }
    
    private func minuteHandAngle() -> Double {
        let calendar = Calendar.current
        let minute = Double(calendar.component(.minute, from: viewModel.currentTime))
        return minute * 6
    }
    
    private func secondHandAngle() -> Double {
        let calendar = Calendar.current
        let second = Double(calendar.component(.second, from: viewModel.currentTime))
        return second * 6
    }
}

#Preview {
    AnalogClockView()
}

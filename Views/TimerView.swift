import SwiftUI

struct TimerView: View {
    @StateObject private var viewModel = TimerModel()
    @State private var inputMinutes = "5"
    @State private var inputSeconds = "0"
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.yellow.opacity(0.1), Color.orange.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Text("Timer")
                    .font(.title)
                    .fontWeight(.bold)
                
                if viewModel.isRunning || viewModel.timeRemaining > 0 {
                    ZStack {
                        Circle()
                            .stroke(Color.gray.opacity(0.2), lineWidth: 20)
                        
                        Circle()
                            .trim(from: 0, to: viewModel.progress)
                            .stroke(Color.orange, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .animation(.linear(duration: 0.1), value: viewModel.timeRemaining)
                        
                        Text(viewModel.formattedTime)
                            .font(.system(size: 70, weight: .bold, design: .monospaced))
                    }
                    .frame(height: 300)
                    
                    HStack(spacing: 20) {
                        Button(action: viewModel.reset) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                        }
                        
                        if viewModel.isRunning {
                            Button(action: viewModel.pause) {
                                Image(systemName: "pause.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.blue)
                            }
                        } else {
                            Button(action: viewModel.resume) {
                                Image(systemName: "play.circle.fill")
                                    .font(.title)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                } else {
                    VStack(spacing: 20) {
                        HStack {
                            VStack {
                                TextField("0", text: $inputMinutes)
                                    .font(.title2)
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.numberPad)
                                Text("Minutes")
                                    .font(.caption)
                            }
                            
                            Text(":")
                                .font(.title2)
                            
                            VStack {
                                TextField("0", text: $inputSeconds)
                                    .font(.title2)
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.numberPad)
                                Text("Seconds")
                                    .font(.caption)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        
                        Button(action: startTimer) {
                            Text("Start")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    private func startTimer() {
        let minutes = Double(inputMinutes) ?? 0
        let seconds = Double(inputSeconds) ?? 0
        let totalSeconds = minutes * 60 + seconds
        viewModel.start(duration: totalSeconds)
    }
}

#Preview {
    TimerView()
}

import SwiftUI

struct StopwatchView: View {
    @StateObject private var viewModel = StopwatchViewModel()
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.cyan.opacity(0.1), Color.blue.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                Text("Stopwatch")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text(viewModel.formattedTime)
                    .font(.system(size: 80, weight: .bold, design: .monospaced))
                    .foregroundColor(.blue)
                    .padding(30)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                
                HStack(spacing: 20) {
                    Button(action: viewModel.reset) {
                        Text("Reset")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                    
                    if viewModel.isRunning {
                        Button(action: viewModel.stop) {
                            Text("Stop")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .cornerRadius(10)
                        }
                    } else {
                        Button(action: viewModel.start) {
                            Text("Start")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(10)
                        }
                    }
                    
                    Button(action: viewModel.recordLap) {
                        Text("Lap")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                if !viewModel.lapTimes.isEmpty {
                    VStack(alignment: .leading) {
                        Text("Laps")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        List {
                            ForEach(viewModel.lapTimes.indices, id: \.self) { index in
                                HStack {
                                    Text("Lap \(index + 1)")
                                    Spacer()
                                    Text(viewModel.formattedLapTime(viewModel.lapTimes[index]))
                                        .fontWeight(.semibold)
                                }
                            }
                        }
                        .listStyle(.inset)
                    }
                } else {
                    Spacer()
                }
            }
            .padding()
        }
    }
}

#Preview {
    StopwatchView()
}

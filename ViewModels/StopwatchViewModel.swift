import SwiftUI

class StopwatchViewModel: ObservableObject {
    @Published var elapsedTime: TimeInterval = 0
    @Published var isRunning = false
    @Published var lapTimes: [TimeInterval] = []
    
    private var timer: Timer?
    
    func start() {
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            self?.elapsedTime += 0.01
        }
    }
    
    func stop() {
        isRunning = false
        timer?.invalidate()
    }
    
    func reset() {
        stop()
        elapsedTime = 0
        lapTimes = []
    }
    
    func recordLap() {
        lapTimes.append(elapsedTime)
    }
    
    var formattedTime: String {
        let minutes = Int(elapsedTime) / 60
        let seconds = Int(elapsedTime) % 60
        let centiseconds = Int((elapsedTime.truncatingRemainder(dividingBy: 1)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, centiseconds)
    }
    
    func formattedLapTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let centiseconds = Int((time.truncatingRemainder(dividingBy: 1)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, centiseconds)
    }
}

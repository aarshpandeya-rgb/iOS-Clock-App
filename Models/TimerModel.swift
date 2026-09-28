import Foundation

class TimerModel: ObservableObject {
    @Published var timeRemaining: TimeInterval = 0
    @Published var isRunning = false
    @Published var totalDuration: TimeInterval = 0
    
    private var timer: Timer?
    
    func start(duration: TimeInterval) {
        totalDuration = duration
        timeRemaining = duration
        isRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.timeRemaining -= 0.1
            
            if self?.timeRemaining ?? 0 <= 0 {
                self?.stop()
                SoundManager.shared.playAlertSound()
            }
        }
    }
    
    func pause() {
        isRunning = false
        timer?.invalidate()
    }
    
    func resume() {
        if timeRemaining > 0 {
            isRunning = true
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
                self?.timeRemaining -= 0.1
                
                if self?.timeRemaining ?? 0 <= 0 {
                    self?.stop()
                    SoundManager.shared.playAlertSound()
                }
            }
        }
    }
    
    func stop() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func reset() {
        stop()
        timeRemaining = 0
        totalDuration = 0
    }
    
    var formattedTime: String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        let centiseconds = Int((timeRemaining.truncatingRemainder(dividingBy: 1)) * 100)
        return String(format: "%02d:%02d.%02d", minutes, seconds, centiseconds)
    }
    
    var progress: Double {
        guard totalDuration > 0 else { return 0 }
        return timeRemaining / totalDuration
    }
}

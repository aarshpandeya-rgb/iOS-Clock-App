import SwiftUI
import Combine

class ClockViewModel: ObservableObject {
    @Published var currentTime = Date()
    @Published var use24HourFormat = false
    
    private var timer: Timer?
    
    init() {
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.currentTime = Date()
        }
    }
    
    func formattedTime(use24Hour: Bool = false) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = use24Hour ? "HH:mm:ss" : "hh:mm:ss"
        return formatter.string(from: currentTime)
    }
    
    func period() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        return formatter.string(from: currentTime)
    }
    
    deinit {
        timer?.invalidate()
    }
}

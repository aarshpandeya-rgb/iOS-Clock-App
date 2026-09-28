import Foundation

struct Alarm: Identifiable, Codable {
    var id = UUID()
    var hour: Int
    var minute: Int
    var label: String
    var isEnabled: Bool = true
    var daysOfWeek: [Int] = [] // 0 = Sunday, 6 = Saturday
    
    var displayTime: String {
        String(format: "%02d:%02d", hour, minute)
    }
    
    var displayDays: String {
        let dayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        if daysOfWeek.isEmpty {
            return "Once"
        }
        if daysOfWeek.count == 7 {
            return "Every day"
        }
        return daysOfWeek.map { dayNames[$0] }.joined(separator: ", ")
    }
}

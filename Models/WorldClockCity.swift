import Foundation

struct WorldClockCity: Identifiable, Codable {
    var id = UUID()
    var name: String
    var timeZoneIdentifier: String
    
    var timeZone: TimeZone? {
        TimeZone(identifier: timeZoneIdentifier)
    }
    
    var currentTime: String {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: Date())
    }
    
    var currentDate: String {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "MMM d"
        return formatter.string(from: Date())
    }
}

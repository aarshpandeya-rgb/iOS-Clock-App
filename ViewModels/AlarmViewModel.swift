import SwiftUI
import UserNotifications

class AlarmViewModel: ObservableObject {
    @Published var alarms: [Alarm] = []
    
    private let userDefaults = UserDefaults.standard
    private let alarmsKey = "savedAlarms"
    
    init() {
        loadAlarms()
        requestNotificationPermission()
    }
    
    func loadAlarms() {
        if let data = userDefaults.data(forKey: alarmsKey),
           let decoded = try? JSONDecoder().decode([Alarm].self, from: data) {
            alarms = decoded
        }
    }
    
    func saveAlarms() {
        if let encoded = try? JSONEncoder().encode(alarms) {
            userDefaults.set(encoded, forKey: alarmsKey)
        }
    }
    
    func addAlarm(_ alarm: Alarm) {
        alarms.append(alarm)
        saveAlarms()
        scheduleNotification(for: alarm)
    }
    
    func updateAlarm(_ alarm: Alarm) {
        if let index = alarms.firstIndex(where: { $0.id == alarm.id }) {
            alarms[index] = alarm
            saveAlarms()
        }
    }
    
    func deleteAlarm(_ alarm: Alarm) {
        alarms.removeAll { $0.id == alarm.id }
        saveAlarms()
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.id.uuidString])
    }
    
    func toggleAlarm(_ alarm: Alarm) {
        var updatedAlarm = alarm
        updatedAlarm.isEnabled.toggle()
        updateAlarm(updatedAlarm)
        
        if updatedAlarm.isEnabled {
            scheduleNotification(for: updatedAlarm)
        } else {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.id.uuidString])
        }
    }
    
    private func scheduleNotification(for alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = alarm.label.isEmpty ? "Wake up!" : alarm.label
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = alarm.hour
        dateComponents.minute = alarm.minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: !alarm.daysOfWeek.isEmpty)
        let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
}

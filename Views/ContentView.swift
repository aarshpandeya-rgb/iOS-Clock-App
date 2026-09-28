import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DigitalClockView()
                .tabItem {
                    Label("Digital", systemImage: "clock.fill")
                }
                .tag(0)
            
            AnalogClockView()
                .tabItem {
                    Label("Analog", systemImage: "clock")
                }
                .tag(1)
            
            WorldClockView()
                .tabItem {
                    Label("World", systemImage: "globe")
                }
                .tag(2)
            
            AlarmView()
                .tabItem {
                    Label("Alarm", systemImage: "alarm.fill")
                }
                .tag(3)
            
            TimerView()
                .tabItem {
                    Label("Timer", systemImage: "timer")
                }
                .tag(4)
            
            StopwatchView()
                .tabItem {
                    Label("Stopwatch", systemImage: "stopwatch.fill")
                }
                .tag(5)
        }
    }
}

#Preview {
    ContentView()
}

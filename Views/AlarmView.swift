import SwiftUI

struct AlarmView: View {
    @StateObject private var viewModel = AlarmViewModel()
    @State private var showAddAlarm = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.red.opacity(0.1), Color.pink.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    Text("Alarms")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: { showAddAlarm = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
                .padding()
                
                if viewModel.alarms.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "alarm.off.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("No Alarms")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    List {
                        ForEach(viewModel.alarms) { alarm in
                            HStack {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(alarm.displayTime)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    Text(alarm.label.isEmpty ? "No label" : alarm.label)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(alarm.displayDays)
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                                Toggle("", isOn: Binding(
                                    get: { alarm.isEnabled },
                                    set: { viewModel.toggleAlarm(Alarm(id: alarm.id, hour: alarm.hour, minute: alarm.minute, label: alarm.label, isEnabled: $0, daysOfWeek: alarm.daysOfWeek)) }
                                ))
                            }
                        }
                        .onDelete(perform: deleteAlarms)
                    }
                    .listStyle(.inset)
                }
            }
        }
        .sheet(isPresented: $showAddAlarm) {
            AddAlarmView(viewModel: viewModel, isPresented: $showAddAlarm)
        }
    }
    
    private func deleteAlarms(at offsets: IndexSet) {
        for index in offsets {
            viewModel.deleteAlarm(viewModel.alarms[index])
        }
    }
}

struct AddAlarmView: View {
    @ObservedObject var viewModel: AlarmViewModel
    @Binding var isPresented: Bool
    @State private var hour = 7
    @State private var minute = 0
    @State private var label = ""
    @State private var selectedDays: Set<Int> = []
    
    var body: some View {
        NavigationView {
            List {
                Section("Time") {
                    HStack {
                        Text("Hour")
                        Spacer()
                        Picker("", selection: $hour) {
                            ForEach(0..<24, id: \.self) { h in
                                Text(String(format: "%02d", h)).tag(h)
                            }
                        }
                        .frame(width: 100)
                    }
                    
                    HStack {
                        Text("Minute")
                        Spacer()
                        Picker("", selection: $minute) {
                            ForEach(0..<60, id: \.self) { m in
                                Text(String(format: "%02d", m)).tag(m)
                            }
                        }
                        .frame(width: 100)
                    }
                }
                
                Section("Label") {
                    TextField("Alarm label", text: $label)
                }
            }
            .navigationTitle("Add Alarm")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeadingItemGroups) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .navigationBarTrailingItemGroups) {
                    Button("Save") {
                        let newAlarm = Alarm(hour: hour, minute: minute, label: label)
                        viewModel.addAlarm(newAlarm)
                        isPresented = false
                    }
                }
            }
        }
    }
}

#Preview {
    AlarmView()
}

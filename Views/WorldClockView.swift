import SwiftUI

struct WorldClockView: View {
    @State private var cities: [WorldClockCity] = [
        WorldClockCity(name: "New York", timeZoneIdentifier: "America/New_York"),
        WorldClockCity(name: "London", timeZoneIdentifier: "Europe/London"),
        WorldClockCity(name: "Tokyo", timeZoneIdentifier: "Asia/Tokyo"),
        WorldClockCity(name: "Sydney", timeZoneIdentifier: "Australia/Sydney")
    ]
    @State private var showAddCity = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.green.opacity(0.1), Color.teal.opacity(0.1)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HStack {
                    Text("World Clock")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Button(action: { showAddCity = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
                .padding()
                
                List {
                    ForEach(cities) { city in
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(city.name)
                                    .font(.headline)
                                Text(city.currentDate)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text(city.currentTime)
                                .font(.title3)
                                .fontWeight(.semibold)
                        }
                        .padding(.vertical, 8)
                    }
                    .onDelete(perform: deleteCities)
                }
                .listStyle(.inset)
            }
            .onReceive(timer) { _ in
                // Update UI
            }
        }
        .sheet(isPresented: $showAddCity) {
            AddCityView(cities: $cities, isPresented: $showAddCity)
        }
    }
    
    private func deleteCities(at offsets: IndexSet) {
        cities.remove(atOffsets: offsets)
    }
}

struct AddCityView: View {
    @Binding var cities: [WorldClockCity]
    @Binding var isPresented: Bool
    @State private var selectedCity = "New York"
    
    let availableCities = [
        ("New York", "America/New_York"),
        ("Los Angeles", "America/Los_Angeles"),
        ("London", "Europe/London"),
        ("Paris", "Europe/Paris"),
        ("Tokyo", "Asia/Tokyo"),
        ("Sydney", "Australia/Sydney"),
        ("Dubai", "Asia/Dubai"),
        ("Hong Kong", "Asia/Hong_Kong"),
        ("Singapore", "Asia/Singapore"),
        ("Mumbai", "Asia/Kolkata")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(availableCities, id: \.0) { cityName, timeZone in
                    Button(action: {
                        let newCity = WorldClockCity(name: cityName, timeZoneIdentifier: timeZone)
                        if !cities.contains(where: { $0.name == cityName }) {
                            cities.append(newCity)
                        }
                        isPresented = false
                    }) {
                        Text(cityName)
                    }
                }
            }
            .navigationTitle("Add City")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

#Preview {
    WorldClockView()
}

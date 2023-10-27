//
//  ContentView.swift
//  AirPortSwiftUI
//
//  Created by Juan Jose Mendez Rojas on 26/10/23.
//

import SwiftUI
import CoreLocation
import MapKit

struct ContentView: View {
    @State private var range: Double = 0.0
    @State var isEditing: Bool = false
    @State private var next = false
    @State var locationViewModel = LocationViewModel()
    @StateObject var airport = AirportSearchViewModel()
    @State var airportInfo: AirportSearchModel = []
    @State private var places: [Place] = []
    @State private var showAlert = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Airport")
                    .font(.title)
                    .bold()
                    .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                Text("Finder")
                Spacer()
                Text("\(range, specifier: "%.0f")")
                    .foregroundColor(isEditing ? .black : .gray)
                    .font(.system(size: 50))
                Slider(value: $range,
                       in: 0...1000,
                                   step: 10,
                                   onEditingChanged: { editing in
                                    isEditing = editing
                            },
                            minimumValueLabel: Text("0"),
                            maximumValueLabel: Text("1000")) {
                                Text("Monto maximo")
                            }
                Text("Radius in Km")
                    .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                Spacer()
                Button(action: {
                    places.removeAll()
                    airport.getAirport(lat: locationViewModel.userLocation.center.latitude, lon: locationViewModel.userLocation.center.longitude, radius: Int(range)) { done in
                        if done {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                                next = true
                            }
                        } else {
                            next = false
                            self.showAlert = true
                        }
                    } air: { air in
                        air.forEach { airport in
                            places.append(Place(title: airport.name ?? "", coordinate: CLLocationCoordinate2D(latitude: airport.latitude ?? 0.0, longitude: airport.longitude ?? 0.0)))
                        }
                    }
                }, label: {
                    Text("Buscar")
                        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .padding()
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .bold()
                        .background(.blue)
                        .cornerRadius(12)
                })
                .alert(isPresented: $showAlert, content: {
                    Alert(title: Text("Airport"), message: Text("No se a encontrando ningun aerepouerto cercano a tu ubicación, intenta con un rango mayor."), dismissButton: .default(Text("Ok")))
                })
                NavigationLink(destination: HomeView(radius: Int(range), places: places), isActive: $next) {
                    Text("")
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

//
//  ListView.swift
//  AirPortSwiftUI
//
//  Created by Juan Jose Mendez Rojas on 26/10/23.
//

import SwiftUI

struct PlaceList: Identifiable {
    let id = UUID()
    let title: String
    let lat: Double
    let lon: Double
}

struct ListView: View {
    @State var places: [Place] = []
    var body: some View {
        
        VStack {
            List(places, id: \.id){airport in
                VStack(alignment: .leading) {
                    Text(airport.title ?? "Nombre Desconocido")
                        .font(.headline)
                    HStack{
                        Text("Latitud: \(airport.coordinate.latitude ?? 0.0)")
                            .font(.subheadline)
                        
                        Text("Longitud: \(airport.coordinate.longitude ?? 0.0)")
                            .font(.subheadline)
                    }
                }
            }
        }
        .padding(.top, 1)
    }
}

#Preview {
    ListView()
}

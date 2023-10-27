//
//  MapsView.swift
//  AirPortSwiftUI
//
//  Created by Juan Jose Mendez Rojas on 26/10/23.
//

import SwiftUI
import CoreLocation
import MapKit

struct Place: Identifiable {
    let id = UUID()
    let title: String
    let coordinate: CLLocationCoordinate2D
}

struct MapsView: View {
    @StateObject var locationViewModel = LocationViewModel()
    @StateObject var airport = AirportSearchViewModel()
    @State var places: [Place] = []
    
    var body: some View {
        VStack{
            Map(coordinateRegion: $locationViewModel.userLocation, showsUserLocation: true, annotationItems: places) { place in
                MapMarker(coordinate: place.coordinate, tint: .blue)
            }
        }
    }
}

#Preview {
    MapsView()
}

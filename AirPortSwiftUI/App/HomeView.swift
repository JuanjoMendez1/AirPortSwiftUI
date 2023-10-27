//
//  HomeView.swift
//  AirPortSwiftUI
//
//  Created by Juan Jose Mendez Rojas on 26/10/23.
//

import SwiftUI

struct HomeView: View {
    @State var selectedIndex: Int = 1
    @State var radius: Int = 0
    @State var places: [Place] = []
    var body: some View {
        VStack {
            TabView(selection: $selectedIndex){
                MapsView(places: places)
                    .tabItem {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Mapa")
                    }
                ListView(places: places)
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Lista")
                    }
            }
        }
    }
}

#Preview {
    HomeView()
}

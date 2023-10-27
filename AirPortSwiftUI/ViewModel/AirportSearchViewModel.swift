//
//  AirportSearchViewModel.swift
//  AirPortSwiftUI
//
//  Created by Juan Jose Mendez Rojas on 26/10/23.
//

import Foundation

class AirportSearchViewModel: ObservableObject {
    @Published var airports: AirportSearchModel?
    func getAirport(lat: Double, lon: Double, radius: Int, completion: @escaping(_ done: Bool) -> Void, air: @escaping(_ air: AirportSearchModel) -> Void){
        guard let url = URL(string: "https://aviation-reference-data.p.rapidapi.com/airports/search?lat=\(lat)&lon=\(lon)&radius=\(radius)") else { return }
        var request = URLRequest(url: url)
        
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("32f2c8641amsh1f57d4eb4921cd4p118f73jsn7cb23cf35c58", forHTTPHeaderField: "X-RapidAPI-Key")
        
        URLSession.shared.dataTask(with: request){data, response, error in
            if let response = response {
                print("Este es el response \(response)")
            }
            guard let data = data else { return }
            
            do {
                let datos = try JSONDecoder().decode(AirportSearchModel.self, from: data)
                self.airports = datos
                if datos.count > 0 {
                    completion(true)
                    air(datos)
                } else {
                    DispatchQueue.main.async {
                        completion(false)
                    }
                }
                
            } catch let error as NSError {
                print("Error al Post", error.localizedDescription)
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }.resume()
    }
}

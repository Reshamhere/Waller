//
//  PexelsViewModel.swift
//  Waller
//
//  Created by Resham on 23/10/24.
//

import Foundation

///  fetching api response

class PexelsViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    
    private let apikey = "nohW27EgGrsb1X65efEJ6ynlt2DCCfrnFChDB6HvGnjxTGl6a9JOn8Rj"
    
    func fetchPhotos() {
        guard let url = URL(string: "https://api.pexels.com/v1/search?query=wallpaper&orientation=portrait") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue(apikey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(PexelsResponse.self, from: data)
                    DispatchQueue.main.async {
                        self?.photos = decodedData.photos
                    }
                } catch {
                    print("Failed to decode: \(error)")
                }
            }
        }
        .resume()
    }
}

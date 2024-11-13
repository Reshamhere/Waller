//
//  PexelsViewModel.swift
//  Waller
//
//  Created by Resham on 23/10/24.
//

import Foundation
import SwiftUI

class PexelsViewModel: ObservableObject {
    @Published var photos: [Photo] = []
    @Published var lastQuery: String?
    
    func getAPIKey() -> String? {
        if let path = Bundle.main.path(forResource: "config", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let apiKey = dict["API_KEY"] as? String {
            return apiKey
        }
        return nil // Return nil if the API key is not found
    }

    func fetchPhotos(query: String? = nil) {
        let apiKey = getAPIKey() // Replace with your actual Pexels API key
        var urlString: String

        if let query = query {
            self.lastQuery = query
            urlString = "https://api.pexels.com/v1/search?query=\(query)&orientation=portrait&per_page=15"
        } else if let lastQuery = self.lastQuery {
            urlString = "https://api.pexels.com/v1/search?query=\(lastQuery)&orientation=portrait&per_page=15"
        } else {
            // Default query if no query is provided
            urlString = "https://api.pexels.com/v1/curated?per_page=15&orientation=portrait"
        }

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data returned")
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(PexelsResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.photos = decodedResponse.photos
                }
            } catch {
                print("Failed to decode JSON: \(error)")
            }
        }.resume()
    }
}

//import Foundation
//import SwiftUI
//
/////  fetching api response
//
//class PexelsViewModel: ObservableObject {
//    @Published var photos: [Photo] = []
//    @Published var lastQuery: String?
//    
//    private let apikey = ""
//    
//    func fetchPhotos(query: String = "nature") {
//        let query = query.isEmpty ? "nature" : query
//        guard let url = URL(string: "https://api.pexels.com/v1/search?query=\(query)&orientation=portrait") else {
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.setValue(apikey, forHTTPHeaderField: "Authorization")
//        
//        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
//            if let data = data {
//                do {
//                    let decodedData = try JSONDecoder().decode(PexelsResponse.self, from: data)
//                    DispatchQueue.main.async {
//                        self?.photos = decodedData.photos
//                    }
//                } catch {
//                    print("Failed to decode: \(error)")
//                }
//            }
//        }
//        .resume()
//    }
//}

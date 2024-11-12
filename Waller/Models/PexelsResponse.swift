//
//  PexelsResponse.swift
//  Waller
//
//  Created by Resham on 23/10/24.
//

import Foundation

///  Pexels API Response Model

struct PexelsResponse: Codable {
    let photos: [Photo]
}

struct Photo: Codable, Identifiable {
    let id: Int
    let url: String
    let src: Src
//    var blurHash: String?
    let photographer: String?
    let photographerId: Int?
    let alt: String?
    let photographerUrl: String?
    var liked: Bool?
    
    static var samplePhoto: Photo {
            return Photo(
                id: 1,
                url: "",
                src: Src(medium: "", large: ""),
                photographer: "John doe",
                photographerId: 1,
                alt: "Description of the image",
                photographerUrl: "",
                liked: false
            )
        }
}

struct Src: Codable {
    let medium: String
    let large: String
//    let original: String
}


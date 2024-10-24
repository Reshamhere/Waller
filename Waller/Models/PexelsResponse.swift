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
    let src: src
//    let photographer: String
//    let photographerId: Int
//    let photographerUrl: String
//    var liked: Bool?
}

struct src: Codable {
    let medium: String
//    let large: String
//    let original: String
}


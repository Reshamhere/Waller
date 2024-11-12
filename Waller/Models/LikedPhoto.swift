//
//  LikedPhoto.swift
//  Waller
//
//  Created by Resham on 11/11/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class LikedPhoto: Identifiable {
    @Attribute(.unique) var id: String // Unique identifier to avoid duplicates
    var url: String
    var photographer: String?
    var photographerId: Int?
    var alt: String?

    init(photo: Photo) {
        self.id = UUID().uuidString
        self.url = photo.src.large
        self.photographer = photo.photographer
        self.photographerId = photo.photographerId
        self.alt = photo.alt
    }
}

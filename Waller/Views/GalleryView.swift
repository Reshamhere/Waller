//
//  GalleryView.swift
//  Waller
//
//  Created by Resham on 20/10/24.
//

import SwiftUI

struct GalleryView: View {
    var images = ["1", "2", "3", "4", "5"]
    var body: some View {
        List(images, id: \.self) { image in
                Image(image)
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 450)
                    .scaledToFit()
                    .cornerRadius(40)
                    .padding(.horizontal, 20)
                
        }
        .listStyle(.plain)
        .padding(.top, 54)
    }
}

#Preview {
    GalleryView()
}

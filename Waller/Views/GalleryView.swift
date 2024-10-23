//
//  GalleryView.swift
//  Waller
//
//  Created by Resham on 20/10/24.
//

import SwiftUI

struct GalleryView: View {
    @StateObject var viewModel = PexelsViewModel()
    
    var body: some View {
        List(viewModel.photos) { photo in
            AsyncImage(url: URL(string: photo.src.medium)) { image in
                image
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(width: 300, height: 450)
                    .scaledToFit()
                    .cornerRadius(40)
                    .clipped()
                    .padding(.horizontal, 20)
                
            } placeholder: {
                ProgressView()
            }
        }
        .listStyle(PlainListStyle())
        .padding(.top, 54)
        .onAppear {
            viewModel.fetchPhotos()
        }
    }
}

#Preview {
    GalleryView()
}

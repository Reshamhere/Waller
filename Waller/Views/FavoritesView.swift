//
//  FavoritesView.swift
//  Waller
//
//  Created by Resham on 20/10/24.
//

import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var likedPhotos: [LikedPhoto]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(likedPhotos) { likedPhoto in
//                    NavigationLink(destination: PhotoView(photo: likedPhoto)){}
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: likedPhoto.url)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.2))
                        .cornerRadius(10)
                        .padding(.vertical, 8)

                        Text(likedPhoto.photographer ?? "Unknown Photographer")
                            .font(.headline)
                        Text(likedPhoto.alt ?? "No Description")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    let container = try! ModelContainer(for: LikedPhoto.self)
        
    return FavoritesView()
        .modelContainer(container)
}

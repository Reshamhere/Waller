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
            VStack {
                if likedPhotos.isEmpty {
                    Image("sadcat")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80)
                        .offset(y: -40)
                    
                    Text("Seems like you don't have any favorites yet!")
                        .foregroundStyle(.pink)
                        .font(.system(size: 20))
                        .multilineTextAlignment(.center)
                        .offset(y: -50)
                        .padding(.horizontal, 10)
                } else {
                    List {
                        ForEach(likedPhotos) { likedPhoto in
                            NavigationLink(destination: PhotoView(photo: convertToPhoto(likedPhoto))) {
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
                    }
                    
                }
            }
            .navigationTitle("Favorites")
        }
    } // end of body
    
    // Helper function to convert LikedPhoto to Photo
    private func convertToPhoto(_ likedPhoto: LikedPhoto) -> Photo {
        return Photo(id: Int(likedPhoto.id) ?? 0, url: "", src: Src(medium: "", large: likedPhoto.url), photographer: likedPhoto.photographer ?? "Unknown", photographerId: likedPhoto.photographerId, alt: likedPhoto.alt, photographerUrl: ""
        )
    }
}

#Preview {
    let container = try! ModelContainer(for: LikedPhoto.self)
        
    return FavoritesView()
        .modelContainer(container)
}

//
//  GalleryView.swift
//  Waller
//
//  Created by Resham on 20/10/24.
//

import SwiftUI
import SwiftData

struct GalleryView: View {
    @StateObject var viewModel : PexelsViewModel
    @State private var scrollOffset: CGFloat = 0.0 // Track the offset of the scroll

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    GeometryReader { geometry in
                        Color.clear
                            .preference(key: ScrollOffsetPreferenceKey.self,value: geometry.frame(in: .global).minY)
                    }
                    .frame(height: 0) // A zero-height view that only tracksthe scroll offset
                    
                    VStack {
                        ForEach(viewModel.photos) { photo in
                            NavigationLink(destination: PhotoView(photo:photo)) {
                                AsyncImage(url: URL(string:photo.src.medium)) { image in
                                    image
                                        .resizable()
                                        .frame(maxWidth: .infinity)
                                        .frame(width: 300, height: 450)
                                        .scaledToFit()
                                        .cornerRadius(40)
                                        .clipped()
                                        .padding( 20)
                                } placeholder: {
                                    ProgressView()
                                }
                            }
                        }
                    }
                    .padding(.top, scrollOffset < -20 ? 0 : 54) // Changepadding based on scroll offset
                }
                .onAppear {
                    viewModel.fetchPhotos()
                }
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    scrollOffset = value
                }
                
                SearchView(viewModel: viewModel)
            } // end of ZStack
        } // end of navigation view
    } // end of body
}

// Custom preference key to track scroll offset
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0.0

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

#Preview {
    GalleryView(viewModel: PexelsViewModel())
        .modelContainer(for: LikedPhoto.self, inMemory: true)
}

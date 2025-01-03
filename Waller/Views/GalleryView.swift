//
//  GalleryView.swift
//  Waller
//
//  Created by Resham on 20/10/24.
//

import SwiftUI
import SwiftData
import EasySkeleton

struct GalleryView: View {
    @StateObject var viewModel : PexelsViewModel
    @State private var scrollOffset: CGFloat = 0.0 // Track the offset of the scroll
    @State private var isLoading: Bool = true

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
                                    SkeletonPlaceholder()
                                }
                            }
                        }
                    }
                    .skeletonable() // Make the VStack skeletonable
                    .setSkeleton($isLoading) // Control skeleton state
                    .padding(.top, scrollOffset < -20 ? 0 : 54) // Changepadding based on scroll offset
                }
                .onAppear {
                    /// Only fetch if photos are empty (i.e., initial load)
                    if viewModel.photos.isEmpty {
                        viewModel.fetchPhotos(query: viewModel.lastQuery)
                        isLoading = false
                    } else {
                        isLoading = false
                    }
                }
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                    scrollOffset = value
                }
                
                SearchView(viewModel: viewModel)
            } // end of ZStack
        } // end of navigation view
    } // end of body
}

struct SkeletonPlaceholder: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .fill(Color.gray.opacity(0.3))
            .frame(width: 300, height: 450)
            .skeletonable()
    }
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
        .modelContainer(for: LikedPhoto.self)
}

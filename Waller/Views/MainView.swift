//
//  MainView.swift
//  Waller
//
//  Created by Resham on 23/10/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @StateObject var viewModel = PexelsViewModel()
    @State var selection = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                if selection == 0 {
                    GalleryView(viewModel: viewModel)
                } else if selection == 1 {
                    FavoritesView()
                }
                TabBarView(selection: $selection)
//                SearchView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    MainView()
        .modelContainer(for: LikedPhoto.self)
}

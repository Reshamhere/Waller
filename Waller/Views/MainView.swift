//
//  MainView.swift
//  Waller
//
//  Created by Resham on 23/10/24.
//

import SwiftUI

struct MainView: View {
    @State var selection = 0
    var body: some View {
        ZStack {
            if selection == 0 {
                GalleryView()
            } else if selection == 1 {
                FavoritesView()
            }
            TabBarView(selection: $selection)
            SearchView()
        }
    }
}

#Preview {
    MainView()
}

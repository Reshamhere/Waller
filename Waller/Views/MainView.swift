//
//  MainView.swift
//  Waller
//
//  Created by Resham on 23/10/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        ZStack {
            TabBarView()
            SearchView()
        }
    }
}

#Preview {
    MainView()
}

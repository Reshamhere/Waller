//
//  ContentView.swift
//  Waller
//
//  Created by Resham on 19/10/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @AppStorage("hasLaunchedBefore") var hasLaunchedBefore: Bool = false
    
    var body: some View {
        if hasLaunchedBefore {
            MainView()
        } else {
            GetStartedView(isShown: $hasLaunchedBefore)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: LikedPhoto.self)
}

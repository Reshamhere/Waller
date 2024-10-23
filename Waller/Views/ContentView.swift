//
//  ContentView.swift
//  Waller
//
//  Created by Resham on 19/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                
                TabBarView()
                SearchView()
            }
            .navigationTitle("Waller")
        }
        
        
    }
}




#Preview {
    ContentView()
}

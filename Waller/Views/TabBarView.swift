//
//  TabBarView.swift
//  Waller
//
//  Created by Resham on 19/10/24.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selection: Int
    
    var body: some View {
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Button {
                        selection = 0
                    } label: {
                        Image(systemName: selection == 0 ? "house.fill" : "house")
                            .resizable()
                            .tint(.black)
                            .frame(width: 30, height: 26)
                            .padding()
                    }
                    Spacer()
                    Button {
                        selection = 1
                    } label: {
                        Image(systemName: selection == 1 ? "heart.fill" : "heart")
                            .resizable()
                            .tint(.black)
                            .frame(width: 30, height: 26)
                            .padding()
                    }
                    Spacer()
                }
                .frame(width:300, height: 70)
                .background(.white)
                .cornerRadius(40)
                .shadow(radius: 1)
                .padding(.bottom, 30)
            }
//            .toolbar {
//                Image(systemName: "magnifyingglass")
//            }
            
        
    }
}

#Preview {
    TabBarView(selection: .constant(0))
}


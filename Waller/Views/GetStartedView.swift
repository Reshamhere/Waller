//
//  GetStartedView.swift
//  Waller
//
//  Created by Resham on 22/10/24.
//

import SwiftUI

struct GetStartedView: View {
    @Binding var isShown: Bool
    
    var body: some View {
        ZStack {
            Image("Images")
                .resizable()
                .rotationEffect(.degrees(12))
                .scaleEffect(1.5)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 350)
                    .foregroundColor(.black.opacity(0.8))
            }
            .ignoresSafeArea()
                
            VStack {
                Spacer()
                Text("Browse millions of \ncool wallpapers \ncrafted by top \ndesigners.")
                    .font(.system(size: 36).bold())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    
                
                Button("Get Started") {
                    isShown = true
                }
                .font(.system(size: 25).bold())
                .tint(.black)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(.orange)
                .cornerRadius(40)
                .padding()
                
            }
        }
    }
}

#Preview {
    GetStartedView(isShown: .constant(false))
}

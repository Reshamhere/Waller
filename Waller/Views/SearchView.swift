//
//  SearchView.swift
//  Waller
//
//  Created by Resham on 21/10/24.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: PexelsViewModel
    @State private var isSearching = false
    @State private var searchText = ""
//    @State  var backgroundOpacity : Double
    
    var body: some View {
        ZStack {
            // Fading background overlay
            if isSearching {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .animation(.spring(), value: isSearching)
                    .onTapGesture {
                        withAnimation {
                            isSearching = false
                            searchText = ""
                        }
                    }
            }
            VStack {
                if isSearching {
                    HStack {
                        TextField("Search", text: $searchText)
                            .submitLabel(.search)
                            .onSubmit {
                                if !searchText.isEmpty {
                                    viewModel.fetchPhotos(query: searchText)
                                    withAnimation {
                                        isSearching = false
                                    }
                                }
                            }
                            .padding()
                            .padding(.horizontal, 20)
                            .background(Color(.systemGray6))
                            .background(.white)
                            .cornerRadius(40)
                            .transition(.move(edge: .trailing))
                            .animation(.easeInOut, value: isSearching)
                        
                        Button {
                            withAnimation {
                                isSearching = false
                                searchText = ""
//                            backgroundOpacity = 0
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                            //                            .foregroundColor(.gray)
                                .foregroundColor(.black)
                                .padding(.trailing, 10)
                        }
                        
                    }
                    .padding(.horizontal)
                    //                .padding(.top, 10)
                } else {
                    HStack {
                        Spacer()
                        
                        Button {
                            withAnimation {
                                isSearching = true
                                //                            backgroundOpacity = 0.5
                            }
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .tint(.black)
                                .padding()
                                .padding(.horizontal)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 52)
                    .background(.white)
                    //                .shadow(radius: 10)
                    //                .padding(.horizontal)
                    //                .padding(.top, 10)
                }
                
                Spacer()
            } // end of Vstack
            
        }
    }
}

#Preview {
    SearchView(viewModel: PexelsViewModel())
}

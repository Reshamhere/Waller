//
//  PhotoView.swift
//  Waller
//
//  Created by Resham on 28/10/24.
//

import SwiftUI
import PhotosUI

struct PhotoView: View {
    var photo: Photo
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: photo.src.large)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.8))
            .cornerRadius(20)
            .padding()
            
            VStack {
                Text(photo.photographer ?? "John Doe")
                    .font(.headline)
                
                HStack {
                    Button{
                        // share
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title)
                            .padding()
                    }
                    
                    Button(){
                        // action for download
                        downloadImage(from: photo.src.large)
                    }
                    label : {
                        Text("Download")
                            .font(.title2).bold()
                            .frame(width: 150, height: 50)
                            .background(.red)
                            .cornerRadius(30)
                            .foregroundStyle(.white)
                            .padding()
                    }
                    
                    Button{
                        // like
//                        photo.liked = true
                    } label: {
                        Image(systemName: "heart")
                            .font(.title)
                            .padding()
                    }
                    
                    
                    
                }
            }
            
        } // end of outer VStack
    } // end of body
    
    private func downloadImage(from urlString: String) {
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                if let image = UIImage(data: data) {
                    // Request permission if needed
                    PHPhotoLibrary.requestAuthorization { status in
                        if status == .authorized {
                            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                            print("Image saved to Photos")
                        } else {
                            print("Permission denied to access Photos")
                        }
                    }
                } else {
                    print("Error creating image from data")
                }
            }.resume()
        }
}

#Preview {
    PhotoView(photo: Photo.samplePhoto)
}

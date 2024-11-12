//
//  PhotoView.swift
//  Waller
//
//  Created by Resham on 28/10/24.
//

import SwiftUI
import PhotosUI
import SwiftData

struct PhotoView: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var isLiked = false // Track if photo is liked
    @State private var isDownloading = false // Track download state
    @State private var showAlert = false // For showing success/error alerts
    @State private var alertMessage = "" // Alert message text
    @State private var showSettingsAlert = false // For showing settings alert
    
    var photo: Photo
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: photo.src.large)) { image in
                image
                    .resizable()
//                    .scaledToFit()
                    .imageScale(.large)
            } placeholder: {
                ProgressView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.8))
//            .cornerRadius(20)
            .padding(.bottom, 10)
            .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack{
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 45))
                        .padding(.horizontal,6)
                    
                    VStack(alignment: .leading) {
                        Text(photo.photographer ?? "John Doe")
                            .font(.title.bold())
                        Text("\(photo.photographerId ?? 0)")
                    }
//                    .padding(.horizontal)
                    Spacer()
                }
                .padding()
                
                Text(photo.alt ?? "desc")
                    .font(.system(size: 23).bold())
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                
                HStack {
                    Button{
                        // share
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title)
                            .tint(.black)
                            .frame(width: 55, height: 55)
                            .background(.gray.opacity(0.15))
                            .cornerRadius(50)
                            .padding()
                    }
                    
                    Button(){
                        // action for download
//                        downloadImage()
                        requestPhotoLibraryAccess()
                    }
                    label : {
                        HStack {
                            Text(isDownloading ? "Downloading " : "Download")
                                .font(.title2)
                            if isDownloading {
                                ProgressView()
                                    .tint(.white)
                            }
                        }
                        .frame(width: 190, height: 60)
                        .background(isDownloading ? .gray : .red)
                        .cornerRadius(30)
                        .foregroundStyle(.white)
                        .padding()
                    }
                    .disabled(isDownloading)
                    
                    Button{
                        // like
                        toggleLike()
                    } label: {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .font(.title)
                            .tint(.black)
                            .frame(width: 55, height: 55)
                            .background(.gray.opacity(0.15))
                            .cornerRadius(50)
                            .padding()
                    }
                    
                    
                    
                }
            }
            
        } // end of outer VStack
        .alert("Download Status", isPresented: $showAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
        .alert("Photos Access Required", isPresented: $showSettingsAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Open Settings") {
                if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsUrl)
                }
            }
        } message: {
            Text("Please allow access to Photos in Settings to save images")
        }
        .onAppear {
            checkIfLiked()
        }
    } // end of body
    
    private func requestPhotoLibraryAccess() {
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
            switch status {
            case .authorized, .limited:
                downloadImage()
            case .denied, .restricted:
                DispatchQueue.main.async {
//                    alertMessage = "Please allow access to Photos in Settings to save images"
//                    showAlert = true
                    showSettingsAlert = true
                }
            case .notDetermined:
                // This case should not occur since we just requested authorization
                break
            @unknown default:
                break
            }
        }
    }
    
    private func downloadImage() {
        guard let imageUrl = URL(string: photo.src.large) else {
            DispatchQueue.main.async {
                alertMessage = "Invalid image URL"
                showAlert = true
            }
            return
        }
        
        DispatchQueue.main.async {
            isDownloading = true
        }
        
        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    alertMessage = "Download failed: \(error.localizedDescription)"
                    showAlert = true
                    isDownloading = false
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    alertMessage = "Failed to create image from downloaded data"
                    showAlert = true
                    isDownloading = false
                    return
                }
                
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                alertMessage = "Image saved successfully!"
                showAlert = true
                isDownloading = false
            }
        }.resume()
    }
    
    private func checkIfLiked() {
            // Check if the photo is already liked
        if (try?  modelContext.fetch(FetchDescriptor<LikedPhoto>()).first(where: { $0.url == photo.src.large })) != nil {
                isLiked = true
            }

        }

        private func toggleLike() {
            if isLiked {
                // Remove the photo from liked photos
                if let likedPhoto = try?  modelContext.fetch(FetchDescriptor<LikedPhoto>()).first(where: { $0.url == photo.src.large }) {
                    modelContext.delete(likedPhoto)
                    isLiked = false
                }
            } else {
                // Add the photo to liked photos
                let newLikedPhoto = LikedPhoto(photo: photo)
                modelContext.insert(newLikedPhoto)
                isLiked = true
            }
        }
    
}

#Preview {
    PhotoView(photo: Photo.samplePhoto)
        .modelContainer(for: LikedPhoto.self)
}

//
//  PhotoView.swift
//  Waller
//
//  Created by Resham on 28/10/24.
//

import SwiftUI
import PhotosUI
import SwiftData
import AlertToast

struct PhotoView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var isLiked = false // Track if photo is liked
    @State private var isDownloading = false // Track download state
    @State private var showAlert = false // For showing success/error alerts
    @State private var alertMessage = "" // Alert message text
    @State private var showSettingsAlert = false // For showing settings alert
    @State private var showBackButton = false
    
    @State private var showToast = false
    
    var photo: Photo
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: photo.src.large)) { image in
                image
                    .resizable()
//                    .scaledToFit()
                    .imageScale(.large)
            } placeholder: {
//                ProgressView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.6))
//            .cornerRadius(20)
            .padding(.bottom, 10)
            .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack{
                    AsyncImage(url: URL(string: photo.src.medium)) { image in
                        image
                            .resizable()
//                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .cornerRadius(100)
                    } placeholder: {
                        Image(systemName: "person.fill")
                            .font(.system(size: 45))
                            .padding(.horizontal,6)
                    }
                    
                    Text(photo.photographer ?? "John Doe")
                        .font(.title.bold())
                    
                    Spacer()
                }
                .padding()
                
                Text(photo.alt ?? "desc")
                    .font(.system(size: 20))
                    .opacity(0.7)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                
                HStack {
                    ShareLink(item: photo.url) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title)
                            .tint(.black)
                            .frame(width: 55, height: 55)
                            .background(.gray.opacity(0.15))
                            .cornerRadius(50)
                            .padding(.leading, 20)
                    }
 
                    Button(){
                        // action for download
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
                            .padding(.trailing, 20)
                    }
                } // end of Hstack
            }
            
        } // end of outer VStack
        .toast(isPresenting: $showToast) {
            AlertToast(displayMode: .hud, type: .regular, title: alertMessage)
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
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                showBackButton = true
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if showBackButton {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 15).bold())
                            .foregroundColor(.black)
                            .frame(width: 40, height: 40)
                            .background(.white)
                            .cornerRadius(100)
                    }
                }
            }
        }
        
    } // end of body
    
    private func requestPhotoLibraryAccess() {
        PHPhotoLibrary.requestAuthorization(for: .addOnly) { status in
            switch status {
            case .authorized, .limited:
                downloadImage()
            case .denied, .restricted:
                DispatchQueue.main.async {
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
//                showAlert = true
                showToast = true
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
//                    showAlert = true
                    showToast = true
                    isDownloading = false
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    alertMessage = "Failed to create image from downloaded data"
//                    showAlert = true
                    showToast = true
                    isDownloading = false
                    return
                }
                
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                alertMessage = "Image saved successfully!"
//                showAlert = true
                showToast = true
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

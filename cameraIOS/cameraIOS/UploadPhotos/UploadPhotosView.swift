//
//  UploadPhotosView.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 05.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import PhotosUI

struct UploadPhotosView: View {
    
    @StateObject private var proxy: UploadViewProxy
    @State private var showSheet: Bool = false
    
    init(styleId: String) {
        _proxy = StateObject(wrappedValue: UploadViewProxy(styleId: styleId))
    }
    
    var body: some View {
        VStack {
            ScrollView {
                HStack(alignment: .top) {
                    Image("ic_check")
                        .frame(width: 24, height: 24)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Good photo examples")
                            .foregroundColor(Color.white)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text("Close-up selfies, same person, adults, variety of backgrounds, facial epressions, head tilts and angles")
                            .foregroundColor(Color.gray)
                            .font(.headline)
                            .fontWeight(.regular)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 24)
                .padding(.leading, 16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(1..<10) { index in
                            ZStack(alignment: .bottomTrailing) {
                                Image("good_photo_\(index)")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 110)
                                    .cornerRadius(16)
                                
                                Image("ic_circle_ok")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .offset(x: -4, y: -4)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 16)
                }
                .padding(.top, 12)
                
                HStack(alignment: .top) {
                    Image("ic_cancel")
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Bad photo examples")
                            .foregroundColor(Color.white)
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text("Group shots, full body, kids, with pets, head accessories, covered faces, monotonous pics, nudes")
                            .foregroundColor(Color.gray)
                            .font(.headline)
                            .fontWeight(.regular)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 64)
                .padding(.leading, 16)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(1..<8) { index in
                            ZStack(alignment: .bottomTrailing) {
                                Image("bad_photo_\(index)")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 90, height: 110)
                                    .cornerRadius(16)
                                
                                Image("ic_circle_close")
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                    .offset(x: -3, y: -3)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.leading, 16)
                }
                .padding(.top, 12)
            }
            
            if let image = proxy.image {
                Image(uiImage: image)
                    .frame(width: 640, height: 960)
            }
            
            Spacer()
            
            Button(
                action: {
                    showSheet = true
                },
                label: {
                    Text("Select 15-20 Selfies")
                        .foregroundColor(Color.white)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, minHeight: 56)
                }
            )
            .frame(maxWidth: .infinity, minHeight: 56)
            .background(Color.blue)
            .cornerRadius(8)
            .padding(.horizontal, 16)
            
            Text("Ignoring these tips may provide weird and bad results")
                .foregroundColor(Color.gray)
                .font(.subheadline)
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 12)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.black.ignoresSafeArea(.all))
        .sheet(isPresented: $showSheet) {
            ImagePicker(proxy: proxy)
        }
        .alert(isPresented: $proxy.showUploadingAlert) {
            Alert(
                title: Text("Importing photos"),
                message: Text("\(proxy.uploadedPhotos)/\(proxy.totalUploadingPhotos)"),
                dismissButton: .cancel()
            )
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Upload your photos")
                    .foregroundColor(Color.white)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.black, for: .navigationBar)
    }
}

struct UploadPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPhotosView(styleId: "")
    }
}

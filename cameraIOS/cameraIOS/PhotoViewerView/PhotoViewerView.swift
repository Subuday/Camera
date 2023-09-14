//
//  PhotoViewerView.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 13.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import Foundation

struct PhotoViewerView: View {
    
    let photo: String
    let currentPhoto: Int
    let totalPhotos: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(
                url: URL(string: photo),
                content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            },
            placeholder: {
                SwiftUI.ProgressView()
                    .controlSize(.large)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .tint(.white)
            })
        
            
            Button(
                action: {
                    URLSession.shared.dataTask(with: URL(string: photo)!) { data, response, error in
                        if let data = data, let image = UIImage(data: data) {
                            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                        }
                    }.resume()
                },
                label: {
                    Text("Save to photos")
                        .foregroundColor(Color.white)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, minHeight: 56)
                }
            )
            .frame(maxWidth: .infinity, minHeight: 56)
            .background(Color(red: 28 / 255.0, green: 28 / 255.0, blue: 30 / 255.0))
            .cornerRadius(8)
            .padding(.horizontal, 16)
        }
        .padding(.top, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.black.ignoresSafeArea(.all))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("\(currentPhoto) of \(totalPhotos)")
                    .foregroundColor(Color.white)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.black, for: .navigationBar)
    }
}

struct PhotoViewerView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoViewerView(photo: "", currentPhoto: 13, totalPhotos: 50)
    }
}

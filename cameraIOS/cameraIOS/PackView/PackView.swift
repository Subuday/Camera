//
//  PackView.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 13.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct PackView: View {
    
    let photos: [String]
    
    var body: some View {
        ScrollView {
            let columns = [GridItem(.flexible(), spacing: 22), GridItem(.flexible())]
            LazyVGrid(columns: columns, alignment: .leading, spacing: 12) {
                ForEach(photos, id: \.self) { photo in
                    AsyncImage(
                        url: URL(string: photo), content: { image in
                        image
                            .resizable()
                            .aspectRatio(2 / 3, contentMode: .fill)
                            .cornerRadius(16)
                            .onTapGesture {
                                Router.shared.showPhotoViewer(
                                    photo: photo,
                                    currentPhoto: photos.firstIndex(of: photo)!,
                                    totalPhotos: photos.count
                                )
                            }
                    }, placeholder: {
                        SwiftUI.ProgressView()
                            .controlSize(.large)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(2 / 3, contentMode: .fill)
                            .tint(.white)
                    })
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.ignoresSafeArea(.all))
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Photos")
                    .foregroundColor(Color.white)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.black, for: .navigationBar)
    }
}

struct PackView_Previews: PreviewProvider {
    static var previews: some View {
        PackView(photos: [])
    }
}

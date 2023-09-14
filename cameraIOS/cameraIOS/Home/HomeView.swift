//
//  HomeView.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 02.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct Restaurant: Identifiable {
    let id = UUID()
    let name: String
}

// A view that shows the data for one Restaurant.
struct RestaurantRow: View {
    var restaurant: Restaurant
    
    var body: some View {
        Text("Come and eat at \(restaurant.name)")
    }
}


struct HomeView: View {
    
    @StateObject private var proxy = HomeViewProxy()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Potion AI")
                    .foregroundColor(Color.white)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("PRO") {
                    
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 4)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .cornerRadius(24)
                
                Image("ic_settings")
                    .frame(width: 44, height: 44, alignment: .trailing)
            }
            .frame(maxWidth: .infinity, minHeight: 52, alignment: .leading)
            .padding(.horizontal, 16)
            .background(Color.black.edgesIgnoringSafeArea(.top))
            
            ScrollView {
                if !proxy.photos.isEmpty {
                    ZStack(alignment: .topLeading) {
                        HStack(alignment: .center, spacing: 0) {
                            ForEach(0..<min(proxy.photos.count, 4), id: \.self) { index in
                                let uiImage = UIImage(data: proxy.photos[index])!
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            }
                        }
                        .overlay(Color.black.opacity(0.35))
                        VStack(alignment: .leading, spacing: 0) {
                            Text("Photos")
                                .foregroundColor(Color.white)
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Text("\(proxy.photoUrls.count) photos")
                                .foregroundColor(Color.white)
                                .font(.caption)
                                .fontWeight(.medium)
                        }
                        .padding(.top, 12)
                        .padding(.horizontal, 8)
                    }
                    .frame(maxWidth: .infinity, minHeight: 128)
                    .background(Color.pink)
                    .cornerRadius(16)
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                    .onTapGesture {
                        Router.shared.showPack(photos: proxy.photoUrls)
                    }
                }
                else {
                    SwiftUI.ProgressView()
                        .controlSize(.large)
                        .frame(maxWidth: .infinity, minHeight: 128)
                        .tint(.white)
                }
                StylesView { style in
                    Router.shared.showCheckout(styleId: style.id)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.black.edgesIgnoringSafeArea(.bottom))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

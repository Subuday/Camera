//
//  StylesView.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 06.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

struct StylesView: View {
    
    let action: (StyleViewModel) -> Void
    private let styles: [StyleViewModel]
    
    init(action: @escaping (StyleViewModel) -> Void) {
        self.action = action
        if IOSStorage().readGender() {
            self.styles = [
                StyleViewModel(id: "black_suit", name: "Black Suit"),
                StyleViewModel(id: "white_t_shirt", name: "White T-shirt"),
                StyleViewModel(id: "hotel", name: "Luxury Hotel"),
                StyleViewModel(id: "ocean", name: "Ocean"),
                StyleViewModel(id: "sunset", name: "Sunset"),
                StyleViewModel(id: "avenue", name: "Street"),
                StyleViewModel(id: "office", name: "Office"),
                StyleViewModel(id: "appartment", name: "Luxury Apartment"),
                StyleViewModel(id: "library", name: "Library"),
                StyleViewModel(id: "house", name: "House")
            ]
        }
        else {
            self.styles = [
                StyleViewModel(id: "club", name: "Club"),
                StyleViewModel(id: "city", name: "City"),
                StyleViewModel(id: "sport", name: "Sport"),
                StyleViewModel(id: "street", name: "Street"),
                StyleViewModel(id: "studio", name: "Studio"),
                StyleViewModel(id: "restaurant", name: "Restaurant"),
                StyleViewModel(id: "beach", name: "Beach"),
                StyleViewModel(id: "vacation", name: "Vacation"),
                StyleViewModel(id: "glass", name: "Glass"),
                StyleViewModel(id: "bridge", name: "Bridge"),
                StyleViewModel(id: "winter", name: "Winter"),
                StyleViewModel(id: "cloudy", name: "Cloudy"),
                StyleViewModel(id: "palace", name: "Palace"),
                StyleViewModel(id: "cafe", name: "Cafe")
            ]
        }
    }
    
    
    var body: some View {
        ScrollView {
            let columns = [GridItem(.flexible(), spacing: 22), GridItem(.flexible())]
            LazyVGrid(columns: columns, alignment: .leading, spacing: 12) {
                ForEach(styles) { style in
                    Image(style.id)
                        .resizable()
                        .aspectRatio(2 / 3, contentMode: .fill)
                        .cornerRadius(16)
                        .overlay(alignment: .bottomLeading) {
                            let backgroundColors = [Color.black.opacity(0.35), Color.clear]
                            let background = LinearGradient(gradient: Gradient(colors: backgroundColors),
                                                            startPoint: .bottom,
                                                            endPoint: .top)
                                .blur(radius: 8)
                            Text(style.name)
                                .foregroundColor(.white)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.vertical, 4)
                                .padding(.horizontal, 8)
                                .background(background)
                        }
                        .onTapGesture {
                            action(style)
                        }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
        }
    }
}

struct StylesView_Previews: PreviewProvider {
    static var previews: some View {
        StylesView { _ in }
            .background(Color.black)
    }
}

struct StyleViewModel: Identifiable {
    let id: String
    let name: String
}

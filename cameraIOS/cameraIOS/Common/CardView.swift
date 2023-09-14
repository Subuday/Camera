//
//  CardView.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 17.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct CardView<Content> : View where Content : View {
    
    private let alignment: Alignment
    private let content: Content
    
    init(alignment: Alignment = .center,
         @ViewBuilder content: () -> Content) {
        self.alignment = alignment
        self.content = content()
    }
    
    var body: some View {
        Rectangle()
            .aspectRatio(2 / 3, contentMode: .fill)
            .overlay(content, alignment: alignment)
            .cornerRadius(16)
            .clipped()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(alignment: .bottom) {
            
        }
    }
}

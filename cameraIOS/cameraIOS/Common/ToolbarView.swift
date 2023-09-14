//
//  ToolbarView.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 06.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct ToolbarView: View {
    
    let title: String
    
    var body: some View {
        HStack {
            Image("ic_back")
                .frame(width: 44, height: 44, alignment: .leading)
            Spacer()
            Text(title)
                .foregroundColor(Color.white)
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 52, alignment: .leading)
        .padding(.horizontal, 16)
    }
}

struct ToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarView(title: "Upload your photos")
            .background(Color.black)
    }
}

//
//  SelectStyleView.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 06.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct SelectStyleView: View {
    
    @StateObject var proxy = HomeViewProxy()
    
    var body: some View {
        StylesView { style in
            Router.shared.showUploadPhotos(styleId: style.id)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.black.ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Select your style")
                    .foregroundColor(Color.white)
                    .font(.title3)
                    .fontWeight(.semibold)
            }
        }
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarBackground(Color.black, for: .navigationBar)
    }
}

struct SelectStyleView_Previews: PreviewProvider {
    static var previews: some View {
        SelectStyleView()
    }
}

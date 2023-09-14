//
//  EnumeratedForEach.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 12.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI

struct EnumeratedForEach<ItemType, ContentView: View>: View {
    let data: [ItemType]
    let content: (Int, ItemType) -> ContentView

    init(_ data: [ItemType], @ViewBuilder content: @escaping (Int, ItemType) -> ContentView) {
        self.data = data
        self.content = content
    }

    var body: some View {
        ForEach(Array(zip(data.indices, data)), id: \.0) { idx, item in
            content(idx, item)
        }
    }
}

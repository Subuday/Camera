//
//  CheckoutViewProxy.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 12.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

class CheckoutViewProxy: ObservableObject {
    
    private let styleId: String
    
    init(styleId: String) {
        self.styleId = styleId
    }
    
    @Published var packages = [
        PackageViewModel(
            title: "50 unique photos",
            subtitle: "50 variations of 1 style",
            price: "4,99 US$",
            isPopular: false,
            isSelected: false
        ),
        PackageViewModel(
            title: "100 unique photos",
            subtitle: "100 variations of 1 style",
            price: "6,99 US$",
            isPopular: true,
            isSelected: false
        ),
        PackageViewModel(
            title: "200 unique photos",
            subtitle: "200 variations of 1 style",
            price: "9,99 US$",
            isPopular: false,
            isSelected: false
        ),
    ]
    
    func selectPackage(index: Int) {
        for i in packages.indices {
            packages[i].isSelected = i == index
        }
    }
    
    func purchase() {
        if IOSStorage().readModelStatus() == .trained {
            NetworkClient.companion.shared.generatePhotos(
                id: IOSStorage().readId(),
                styleName: styleId,
                count: 2
            ) { response, error in
                guard let response, error == nil else {
                    return
                }
                IOSStorage().writeGenerationId(id: response.generationId)
                IOSStorage().writeModelStatus(status: .training)
            }
        } else {
            NetworkClient.companion.shared.generatePhotos(
                id: IOSStorage().readId(),
                styleName: styleId,
                count: 2
            ) { response, error in
                guard let response, error == nil else {
                    return
                }
                IOSStorage().writeGenerationId(id: response.generationId)
                IOSStorage().writeModelStatus(status: .training)
            }
//            NetworkClient.companion.shared.train(id: IOSStorage().readId(), gender: IOSStorage().readGender()) { error in
//                if error == nil {
//                    IOSStorage().writeModelStatus(status: .training)
//                }
//            }
        }
    }
}

struct PackageViewModel {
    let title: String
    let subtitle: String
    let price: String
    let isPopular: Bool
    var isSelected: Bool
}

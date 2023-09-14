//
//  Router.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 06.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

class Router: ObservableObject {
    static let shared = Router()
    
    @Published var root: Route
    @Published var route = [Route]()
    
    init() {
        switch IOSStorage().readModelStatus() {
        case .trained:
            root = .home
        case .training:
            root = .progress
        default:
            root = .selectGender
        }
        IOSStorage().setOnModelStatusChangeListener { modelStatus in
            self.route.removeAll()
            switch IOSStorage().readModelStatus() {
            case .trained:
                self.root = .home
            case .training:
                self.root = .progress
            default:
                self.root = .selectGender
            }
        }
    }
    
    func showSelectStyle() {
        route.append(.selectStyle)
    }
    
    func showUploadPhotos(styleId: String) {
        route.append(.uploadPhotos(styleId: styleId))
    }
    
    func showCheckout(styleId: String) {
        route.append(.checkout(styleId: styleId))
    }
    
    func showProgress() {
        route.append(.progress)
    }
    
    func showPack(photos: [String]) {
        route.append(.pack(photos: photos))
    }
    
    func showPhotoViewer(photo: String, currentPhoto: Int, totalPhotos: Int) {
        route.append(.photoViewer(photo: photo, currentPhoto: currentPhoto, totalPhotos: totalPhotos))
    }
}

enum Route: Hashable {
    case selectGender
    case selectStyle
    case checkout(styleId: String)
    case uploadPhotos(styleId: String)
    case progress
    case home
    case pack(photos: [String])
    case photoViewer(photo: String, currentPhoto: Int, totalPhotos: Int)
}

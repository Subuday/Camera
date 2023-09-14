//
//  HomeViewProxy.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 06.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

class HomeViewProxy: ObservableObject {
    
    @Published var photos: [Data] = []
    var photoUrls: [String] = []
    
    private let lock = NSLock()
    
    init() {
        NetworkClient.companion.shared.photos(modelId: IOSStorage().readId()) { photos, error in
            guard let photos, error == nil else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                let group = DispatchGroup()
                var images = [Data]()
                for url in photos.images.prefix(5) {
                    group.enter()
                    let task = URLSession.shared.dataTask(with: URLRequest(url: URL(string: url)!)) { data, response, error in
                        guard let data else {
                            return
                        }
                        guard let response = response as? HTTPURLResponse, 200 ... 299  ~= response.statusCode else {
                            return
                        }
                        images.append(data)
                        group.leave()
                    }
                    task.resume()
                }
                group.notify(queue: .main) {
                    self.photoUrls = photos.images
                    self.photos = images
                }
            }
        }
    }
    
    func selectStyle() {

    }
}

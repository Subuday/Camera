//
//  UploadViewProxy.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 06.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import PhotosUI
import Photos
import shared

class UploadViewProxy: ObservableObject {
    
    private let styleId: String
    
    init(styleId: String) {
        self.styleId = styleId
    }
    
    @Published var showAlert: Bool = false
    @Published var image: UIImage?
    
    @Published var showUploadingAlert: Bool = false
    @Published var totalUploadingPhotos: Int = 0
    @Published var uploadedPhotos: Int = 0
    
    func pickPhotos(_ photos: [PHPickerResult]) {
        let dispatchGroup = DispatchGroup()
        var images = [UIImage]()
        for photo in photos {
            if photo.itemProvider.canLoadObject(ofClass: UIImage.self) {
                dispatchGroup.enter()
                photo.itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                    if let image = image as? UIImage {
                        images.append(image)
                    }
                    dispatchGroup.leave()
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.uploadPhotos(images)
        }
    }
    
    private func uploadPhotos(_ photos: [UIImage]) {
        if photos.count < 15 {
            return
        }
        
        uploadedPhotos = 0
        totalUploadingPhotos = photos.count
        showUploadingAlert = true
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            var compressedPhotos = [KotlinByteArray]()
            for photo in photos {
                let resizedPhoto = photo.size.height > 960 ? self.resizePhoto(photo) : photo
                let croppedPhoto = resizedPhoto.size.width > 640 ? self.cropPhoto(resizedPhoto) : resizedPhoto
                let compressedPhoto = self.compressPhoto(croppedPhoto)
                compressedPhotos.append(KotlinByteArray.from(data: compressedPhoto))
                DispatchQueue.main.async { [weak self] in
                    self?.uploadedPhotos += 1
                }
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.uploadedPhotos = 0
                NetworkClient.companion.shared.uploadPhotos(
                    photos: compressedPhotos,
                    onUpload: { progress in
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            self.uploadedPhotos = progress.toInt()
                        }
                    },
                    completionHandler: { error in
                        DispatchQueue.main.async { [weak self] in
                            self?.showUploadingAlert = false
                            if error == nil {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                                    guard let self = self else { return }
                                    Router.shared.showCheckout(styleId: self.styleId)
                                }
                            }
                        }
                    }
                )
            }
        }
    }
    
    private func resizePhoto(_ photo: UIImage) -> UIImage {
        let ratio = photo.size.width / photo.size.height
        let newSize = CGSize(width: 960 * ratio, height: 960)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        photo.draw(in: CGRect(origin: .zero, size: newSize))
        defer { UIGraphicsEndImageContext() }
        return UIGraphicsGetImageFromCurrentImageContext()!
    }
    
    private func cropPhoto(_ photo: UIImage) -> UIImage {
        let xOffset = (photo.size.width - 640) / 2
        let rect = CGRect(
            x: xOffset,
            y: 0,
            width: 640,
            height: 960
        )
        let croppedCgImage = photo.cgImage!.cropping(to: rect)!
        return UIImage(cgImage: croppedCgImage)
    }
    
    private func compressPhoto(_ photo: UIImage) -> Data {
        let sizeInKb = photo.pngData()!.count / 1024
        let compressionQuality = 500.0 / Double(sizeInKb)
        let jpegData = photo.jpegData(compressionQuality: compressionQuality)!
        let pngData = UIImage(data: jpegData)?.pngData()
        return pngData!
    }
}

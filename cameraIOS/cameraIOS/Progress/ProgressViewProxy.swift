//
//  ProgressViewProxy.swift
//  cameraIOS
//
//  Created by Maksym Sutkovenko on 06.08.2023.
//  Copyright © 2023 orgName. All rights reserved.
//

import SwiftUI
import shared

class ProgressViewProxy: ObservableObject {
    
    private static let upperTrainingTimeBound = 2
    
    @Published var progress: Int = 0
    @Published var time: Int = upperTrainingTimeBound
    
    private var timer: Timer?
    
    func startPollingModelStatus() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
                if let generationId = IOSStorage().readGenerationId() {
                    NetworkClient.companion.shared.generationStatus(id: IOSStorage().readId(), generationId: generationId) { status, error in
                        guard let status, error == nil else { return }
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            var serverProgress = 0
                            if let progress = status.progress, let progressFloat = Float(progress.replacingOccurrences(of: "%", with: "")) {
                                serverProgress = Int(progressFloat.rounded())
                                self.progress = serverProgress > 80 ? 50 : 0
                            }
                            else {
                                self.progress = 0
                            }
                            self.time = serverProgress > 80 ? 1 : ProgressViewProxy.upperTrainingTimeBound
                            IOSStorage().writeModelStatus(status: status.status)
                        }
                    }
                } else {
                    NetworkClient.companion.shared.modelStatus(id: IOSStorage().readId()) { [weak self] status, error in
                        guard let status, error == nil else { return }
                        DispatchQueue.main.async { [weak self] in
                            guard let self = self else { return }
                            self.progress = status.progress != nil ? Int(status.progress!) ?? 0 : 0
                            self.time = (100 - self.progress) * ProgressViewProxy.upperTrainingTimeBound / 100
                            IOSStorage().writeModelStatus(status: status.status)
                        }
                    }
                }
            }
        }
    }
    
    func stopPollingModelStatus() {
        timer?.invalidate()
        timer = nil
    }
}

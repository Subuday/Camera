import SwiftUI
import shared

@main
struct iOSApp: App {
    
    @ObservedObject var router = Router.shared
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.route) {
                switch router.root {
                case .home:
                    HomeView()
                        .navigationDestination(for: Route.self) { route in
                            switch route {
                            case .checkout(let styleId):
                                CheckoutView(styleId: styleId)
                            case .progress:
                                ProgressView()
                            case .pack(let photos):
                                PackView(photos: photos)
                            case .photoViewer(let photo, let currentPhoto, let totalPhotos):
                                PhotoViewerView(photo: photo, currentPhoto: currentPhoto, totalPhotos: totalPhotos)
                            default: fatalError()
                            }
                        }
                case .progress:
                    ProgressView()
                case .selectGender:
                    SelectGenderView()
                        .navigationDestination(for: Route.self) { route in
                            switch route {
                            case .selectStyle:
                                SelectStyleView()
                            case .uploadPhotos(let styleId):
                                UploadPhotosView(styleId: styleId)
                            case .checkout(let styleId):
                                CheckoutView(styleId: styleId)
                            case .progress:
                                ProgressView()
                            default: fatalError()
                            }
                        }
                default: fatalError()
                }
            }
            .accentColor(Color.white) // Makes Back arrow of toolbar to be white
        }
    }
}

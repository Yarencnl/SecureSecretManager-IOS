import SwiftUI

@main
struct SecureSecretManagerApp: App {
    init() {
        ScreenProtectionService.shared.activate()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

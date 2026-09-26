import SwiftUI

struct ContentView: View {
    @State private var isDeviceCompromised: Bool = JailbreakDetectionService.shared.isJailbroken()

    var body: some View {
        if isDeviceCompromised {
            JailbreakBlockedView()
        } else {
            AppLockView()
        }
    }
}

#Preview {
    ContentView()
}

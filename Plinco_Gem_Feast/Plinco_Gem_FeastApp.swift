import SwiftUI

@main
struct Plinco_Gem_FeastApp: App {
    
    @AppStorage("isInitialLounch") var isInitialLounch = true
    
    var body: some Scene {
        WindowGroup {
            if isInitialLounch {
                WelcomeStoryView(onMain: {
                    isInitialLounch = false
                })
                .edgesIgnoringSafeArea(.all)
            } else {
                GameView()
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}


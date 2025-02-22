import SwiftUI
import SpriteKit

struct GameView: View {
    
    var currentLevel: Int
    
    var scene: GameScene {
        let scene = GameScene(size: SizeData.screenSize)
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
        ZStack {
            Image("gameBackgroundImage")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            SpriteView(scene: scene, options: [.allowsTransparency])
                .edgesIgnoringSafeArea(.all)
                .background(.clear)
        }
    }
}

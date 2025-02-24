
import SwiftUI
import SpriteKit

struct GameView: View {
    
    @AppStorage("isFirstdrGammrere") var isFirstGame = true
    var onHome: () -> Void
    
    @State private var isGameWon = false
    @State private var isGameOver = false
    @State private var isPause = false
    @State private var isInfo = false
    @State var goalsInfo: [(color: String, currentCount: Int, targetCount: Int)] = []
    
    @State var currentLevel: Int
    
    @State var scene: GameScene
    
    init(currentLevel: Int, onHome: @escaping () -> Void) {
        self.currentLevel = currentLevel
        self.onHome = onHome
        _scene = State(initialValue: GameScene(size: SizeData.screenSize, currentLevel: currentLevel)) // Передаем currentLevel
    }
    
    var body: some View {
        ZStack {
            ZStack {
                Image("gameBackgroundImage")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                ZStack(alignment: .top) {
                    if !isFirstGame {
                        SpriteView(scene: scene, options: [.allowsTransparency])
                            .edgesIgnoringSafeArea(.all)
                            .background(.clear)
                            .id(scene)
                            
                            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("GameWon"))) { _ in
                                withAnimation {
                                    isGameWon = true
                                }
                            }
                    }
                        
                    
                    // Goal Display
                    ZStack(alignment: .topTrailing) {
                        Image("level\(currentLevel)View")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 310, height: 69)
                        GoalDisplayView(goalsInfo: $goalsInfo)
                            .padding(.top, 3)
                            .padding(.trailing, 55)
                        Button {
                            scene.isPaused = true
                            isPause = true
                        } label: {
                            Image("pauseButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 33, height: 33)
                        }
                        .padding(.top, 5)
                        .padding(.trailing, 15)
                        

                    }
                    .padding(.top, SizeData.isSmallPhone ? 100 : 50)
                }
                .edgesIgnoringSafeArea(.all)
                DiamondsView()
                    .zIndex(2)
                    .position(CGPoint(x: 71, y: SizeData.screenHeight - (SizeData.isSmallPhone ? 0 :80)))
            }
            .edgesIgnoringSafeArea(.all)
            .blur(radius: (isGameOver || isPause || isGameWon ) ? 5 : 0)
            if isPause {
                PauseView(onPlay: {
                    scene.isPaused = false
                    isPause = false
                }, onHome: {
                    onHome()
                }, onInfo: {
                    isInfo = true
                })
                .edgesIgnoringSafeArea(.all)
                .zIndex(3)
            }
            if isInfo {
                InfoGameView(onCancel: {
                    if isFirstGame {
                        isFirstGame = false
                        scene.isPaused = false
                    }
                    isInfo = false
                }, onPlay: {
                    scene.isPaused = false
                    if isFirstGame {
                        isFirstGame = false
                    }
                    isPause = false
                    isInfo = false
                })
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(4)
                    .onAppear {
                        self.scene.isPaused = true
                    }
            }
            if isGameWon {
                YouWinView {
                    onHome()
                } onNext: {
                    setupNextLevel()
                }
                .edgesIgnoringSafeArea(.all)
                .zIndex(3)

            }
            
            
            if isGameOver {
                GameOverView {
                    self.isGameOver = false
                    restartGame()
                } onHome: {
                    onHome()
                }
                .edgesIgnoringSafeArea(.all)
                .zIndex(3)

            }
            
        }
        .onAppear {
            self.scene.scaleMode = .aspectFill
            NotificationCenter.default.addObserver(forName: NSNotification.Name("Goals"), object: nil, queue: .main) { notification in
                if let updatedGoals = notification.object as? [(color: String, currentCount: Int, targetCount: Int)] {
                    self.goalsInfo = updatedGoals
                }
            }
            NotificationCenter.default.addObserver(
                forName: NSNotification.Name("GameOver"),
                object: nil,
                queue: .main
            ) { _ in
                self.isGameOver = true // Показываем GameOverView
            }
            goalsInfo = scene.goalTracker.getAllGoalsInfo()
            if isFirstGame {
                self.scene.isPaused = true
                isInfo = true
//                scene.isPaused = true
            }
        }
    }

    private func restartGame() {
        isGameWon = false
        self.scene = GameScene(size: SizeData.screenSize, currentLevel: currentLevel)
        scene.scaleMode = .aspectFill
        
        goalsInfo = scene.goalTracker.getAllGoalsInfo()
    }
    
    private func setupNextLevel() {
        if currentLevel > 0 && currentLevel < 12 {
            currentLevel += 1
        } else {
            currentLevel = 1
        }
        
        LevelManager.shared.ulockLevel(for: currentLevel)
        
        isGameWon = false
        self.scene = GameScene(size: SizeData.screenSize, currentLevel: currentLevel)
        scene.scaleMode = .aspectFill
        goalsInfo = scene.goalTracker.getAllGoalsInfo()
    }
}

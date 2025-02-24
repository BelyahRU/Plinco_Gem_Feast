
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    public let goalTracker = GoalTracker()
    
    private var rope: SKSpriteNode!
    private var ball: SKSpriteNode!
    private var ropeSpeed: CGFloat = 3.0
    private var attachedBalls: [SKSpriteNode] = []
    private var ballsConnected: [SKSpriteNode] = []
    private var ballFlags: [SKSpriteNode: String] = [:]
    private var ballProbabilities: [String: Int] = [
        "greenBallImage": 15,
        "purpleBallImage": 10,
        "blueBallImage": 2,
        "darkGreenBallImage": 12,
        "orangeBallImage": 2,
        "pinkBallImage": 23,
        "yellowBallImage": 2,
        "rainbowBallImage": 30
    ]
    var gameZone: SKShapeNode!

    
    var currentLevel: Int
        
        // Инициализация с уровнем
        init(size: CGSize, currentLevel: Int) {
            self.currentLevel = currentLevel
            super.init(size: size)
        }
        
        required init?(coder aDecoder: NSCoder) {
            self.currentLevel = 1 // Значение по умолчанию, если используется расшифровка из архива
            super.init(coder: aDecoder)
        }
    
    // Флаг для обозначения победы
        private var isGameWon = false {
            didSet {
                if isGameWon {
                    // Останавливаем игру
                    self.view?.isPaused = true
                    
                    // Отображаем сообщение о победе
                    showWinMessage()
                }
            }
        }

    override func didMove(to view: SKView) {
        backgroundColor = .clear
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -3.0)
        goalTracker.setLevel(level: 0)
        setupRope()
        setupBall()
        spawnBalls()
        setupGameZone()
        
    }
    
    private func setupGameZone() {
        gameZone = SKShapeNode(circleOfRadius: 130) // радиус игровой зоны
        gameZone.position = ball.position
        gameZone.strokeColor = SKColor.gray
        gameZone.lineWidth = 2
        gameZone.fillColor = SKColor.clear
        addChild(gameZone)
    }
    
    private func spawnBalls() {
        let spawnAction = SKAction.run {
            // Генерируем случайное изображение с учетом вероятностей
            let randomImage = self.generateRandomBallImage()
            let newBall = SKSpriteNode(imageNamed: randomImage)
            newBall.size = CGSize(width: 32, height: 32)
            newBall.position = CGPoint(x: self.size.width / 2, y: self.size.height - 50)
            newBall.name = randomImage
            newBall.physicsBody = SKPhysicsBody(circleOfRadius: newBall.size.width / 2 - 2.5)
            newBall.physicsBody?.isDynamic = true
            newBall.physicsBody?.affectedByGravity = true
            newBall.physicsBody?.categoryBitMask = 1
            newBall.physicsBody?.contactTestBitMask = 1
            
            self.addChild(newBall)
        }
        
        let waitAction = SKAction.wait(forDuration: 2.0)
        let sequence = SKAction.sequence([spawnAction, waitAction])
        run(SKAction.repeatForever(sequence))
    }
    
    private func generateRandomBallImage() -> String {
        // Создаем массив всех возможных вариантов с учетом весов
        var weightedImages: [String] = []
        for (image, weight) in ballProbabilities {
            weightedImages += Array(repeating: image, count: weight)
        }
        
        // Генерируем случайный индекс и возвращаем соответствующее изображение
        let randomIndex = Int.random(in: 0..<weightedImages.count)
        return weightedImages[randomIndex]
    }

    private func setupRope() {
        let texture = SKTexture(imageNamed: "canatImage")
        rope = SKSpriteNode(texture: texture)
        rope.size = CGSize(width: 1076, height: 12)
        rope.position = CGPoint(x: size.width / 2, y: 153)
        addChild(rope)
    }

    private func setupBall() {
        let texture = SKTexture(imageNamed: "ballImage")
        ball = SKSpriteNode(texture: texture)
        ball.size = CGSize(width: 66, height: 66)
        ball.position = CGPoint(x: size.width / 2, y: size.height / 2)
        ball.name = "ballImage"
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2 - 2)
        ball.physicsBody?.isDynamic = false
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.allowsRotation = true
        ball.physicsBody?.categoryBitMask = 1
        ball.physicsBody?.collisionBitMask = 1
        ball.physicsBody?.contactTestBitMask = 1

        addChild(ball)
        attachedBalls.append(ball)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        for attachedBall in attachedBalls {
            // Преобразуем позицию мяча в мировую систему координат
            let ballPositionInScene = self.convert(attachedBall.position, from: ball)
            
            // Проверяем, находится ли мяч за пределами игровой зоны
            if !gameZone.contains(ballPositionInScene) && attachedBall != ball{
                print("Game Over: Ball \(attachedBall.name ?? "") is outside the game zone at position \(ballPositionInScene)")
                gameOver()
                break
            }
        }
    }




    private func gameOver() {
        // Останавливаем игру
        self.view?.isPaused = true
        
        // Отправляем уведомление о проигрыше
        NotificationCenter.default.post(name: NSNotification.Name("GameOver"), object: nil)
    }




    func didBegin(_ contact: SKPhysicsContact) {
        if let nodeA = contact.bodyA.node as? SKSpriteNode, let nodeB = contact.bodyB.node as? SKSpriteNode {
            if attachedBalls.contains(nodeA) && !attachedBalls.contains(nodeB) {
                handleCollision(newBall: nodeB, parentBall: nodeA)
            } else if attachedBalls.contains(nodeB) && !attachedBalls.contains(nodeA) {
                handleCollision(newBall: nodeA, parentBall: nodeB)
            }
        }
    }

    private func handleCollision(newBall: SKSpriteNode, parentBall: SKSpriteNode) {
        attachBall(newBall)

        if newBall.name == "rainbowBallImage" || parentBall.name == "rainbowBallImage" {
            handleRainbowCollision(newBall, parentBall)
        } else {
            updateAllFlags()
        }

        checkForRemoval()
    }

    private func handleRainbowCollision(_ newBall: SKSpriteNode, _ parentBall: SKSpriteNode) {
        if newBall.name == "rainbowBallImage" {
            mergeRainbowFlags(newBall, parentBall)
        } else if parentBall.name == "rainbowBallImage" {
            mergeRainbowFlags(parentBall, newBall)
        }
    }

    private func mergeRainbowFlags(_ rainbowBall: SKSpriteNode, _ otherBall: SKSpriteNode) {
        if let existingFlag = ballFlags[otherBall] {
            print("Rainbow ball \(rainbowBall.name ?? "unknown") merges with flag from \(otherBall.name ?? "unknown")")
            ballFlags[rainbowBall] = existingFlag
        } else {
            let newFlag = UUID().uuidString
            print("New flag \(newFlag) assigned to \(rainbowBall.name ?? "unknown") and \(otherBall.name ?? "unknown")")
            ballFlags[rainbowBall] = newFlag
            ballFlags[otherBall] = newFlag
        }
    }



    
    private func updateAllFlags() {
        let allBalls = attachedBalls.filter { $0 != self.ball }  // Исключаем главный шар из обработки

        for ball in allBalls {
            for otherBall in allBalls where ball != otherBall {
                if ball.name == otherBall.name || ball.name == "rainbowBallImage" || otherBall.name == "rainbowBallImage" {
                    mergeFlags(ball, otherBall)
                }
            }
        }
    }





    private func mergeFlags(_ newBall: SKSpriteNode, _ parentBall: SKSpriteNode) {
        let newBallPositionInScene = newBall.parent?.convert(newBall.position, to: self) ?? newBall.position

        let nearbyBalls = attachedBalls.filter { ball in
            guard ball.name == newBall.name || ball.name == "rainbowBallImage" || newBall.name == "rainbowBallImage" else { return false }
            
            let ballPositionInScene = ball.parent?.convert(ball.position, to: self) ?? ball.position
            return ballPositionInScene.distance(to: newBallPositionInScene) < 40
        }
        
        var flagSet: Set<String> = Set(nearbyBalls.compactMap { ballFlags[$0] })
        let newFlag = flagSet.first ?? UUID().uuidString
        flagSet.insert(newFlag)
        
        for ball in nearbyBalls {
            ballFlags[ball] = newFlag
        }
        ballFlags[newBall] = newFlag
    }



//    private func checkForRemoval() {
//        let groups = Dictionary(grouping: ballFlags.keys) { ballFlags[$0]! }
//        for (flag, balls) in groups where balls.count >= 3 {
//            for ball in balls where ball.name == "rainbowBallImage" || ball.name == "rainbowBallImage" {
//                // Удалить только радужные шарики и шарики того же флага
//                removeBallsForFlag(flag)
//            }
//        }
//        // Проверяем, достигнута ли цель
//        if goalTracker.isGoalCompleted() && !isGameWon {
//            print("Вы выполнили все цели!")
//            self.isPaused = true
//            isGameWon = true
//        }
//    }

    private func removeBallsForFlag(_ flag: String) {
        let ballsToRemove = attachedBalls.filter { ballFlags[$0] == flag && $0 != self.ball }
        for ball in ballsToRemove {
            ball.removeFromParent()
            attachedBalls.removeAll { $0 == ball }
            ballFlags.removeValue(forKey: ball)
            goalTracker.updateProgress(for: ball.name!)
        }
        updateGoalInfo()
    }

    
    private func checkForRemoval() {
        let groups = Dictionary(grouping: ballFlags.keys) { ballFlags[$0]! }
        for (flag, balls) in groups where balls.count >= 3 {
            let rainbowBalls = balls.filter { $0.name == "rainbowBallImage" }
            if !rainbowBalls.isEmpty {
                // Удаляем все шары, связанные с радужными шарами
                for ball in balls where ball.name == "rainbowBallImage" || ball.name == "rainbowBallImage" {
                    // Удалить только радужные шарики и шарики того же флага
                    removeBallsForFlag(flag)
                }
            } else {
                // Удаление происходит как обычно
                let firstBallColor = balls.first?.name ?? ""
                for ball in balls {
                    if ball.name == firstBallColor {
                        ball.removeFromParent()
                        attachedBalls.removeAll { $0 == ball }
                        ballFlags.removeValue(forKey: ball)
                        goalTracker.updateProgress(for: ball.name!)
                    }
                }
            }
        }
        updateGoalInfo()

    
        // Проверяем, достигнута ли цель
        if goalTracker.isGoalCompleted() && !isGameWon {
            print("Вы выполнили все цели!")
            self.isPaused = true
            isGameWon = true
        }
    }

    private func updateGoalInfo() {
        // Передаем обновленную информацию о целях в GameView
        NotificationCenter.default.post(name: NSNotification.Name("Goals"), object: goalTracker.getAllGoalsInfo())
    }

    
    private func showWinMessage() {
        // Создаем узел с текстом
        self.isPaused = true
        
        // Отправляем уведомление о победе
        NotificationCenter.default.post(name: NSNotification.Name("GameWon"), object: nil)
    }
    
    func printGoalsInfo() {
        let goalsInfo = goalTracker.getAllGoalsInfo()
        for (color, current, target) in goalsInfo {
            print("\(color): \(current) / \(target)")
        }
    }

    
    private func attachBall(_ newBall: SKSpriteNode) {
        newBall.removeFromParent()
        // Пересчитываем позицию нового шарика относительно главного шара
        newBall.position = ball.convert(newBall.position, from: self)
        newBall.physicsBody?.isDynamic = false
        newBall.physicsBody?.affectedByGravity = false

        // Прикрепляем новый шарик к главному шару
        ball.addChild(newBall)
        attachedBalls.append(newBall)
    }


    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let deltaX = touch.location(in: self).x - touch.previousLocation(in: self).x
        
        moveRope(by: deltaX)
        rotateBall(by: deltaX)
    }

    private func moveRope(by offset: CGFloat) {
        rope.position.x += -offset * ropeSpeed / 10
        
        if rope.position.x > size.width {
            rope.position.x -= size.width
        } else if rope.position.x < 0 {
            rope.position.x += size.width
        }
    }

    private func rotateBall(by offset: CGFloat) {
        let rotationSpeed: CGFloat = 0.008
        let rotationAngle = -offset * rotationSpeed
        let rotateAction = SKAction.rotate(byAngle: rotationAngle, duration: 0.1)
        ball.run(rotateAction)
    }
}

private extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return hypot(x - point.x, y - point.y)
    }
}

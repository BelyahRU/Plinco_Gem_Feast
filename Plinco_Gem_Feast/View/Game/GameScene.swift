
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    public let goalTracker = GoalTracker()
    
    private var rope: SKSpriteNode!
    private var ball: SKSpriteNode!
    private var ropeSpeed: CGFloat = 3.0
    private var attachedBalls: [SKSpriteNode] = []
    private var ballsConnected: [SKSpriteNode] = []
    private var ballFlags: [SKSpriteNode: Set<String>] = [:]

    var ballProbabilities: [String: Int]
    var gameZone: SKShapeNode!

    
    var currentLevel: Int
    
    private var isGameWon = false {
        didSet {
            if isGameWon {
                self.view?.isPaused = true
                showWinMessage()
            }
        }
    }

        
    init(size: CGSize, currentLevel: Int) {
        self.currentLevel = currentLevel
        self.ballProbabilities = goalTracker.getLevelSettings(level: currentLevel)
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.currentLevel = 1
        self.ballProbabilities = goalTracker.getLevelSettings(level: currentLevel)
        super.init(coder: aDecoder)
    }
    

    override func didMove(to view: SKView) {
        backgroundColor = .clear
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -3.0)
        goalTracker.setLevel(level: currentLevel-1)
        setupRope()
        setupBall()
        spawnBalls()
        setupGameZone()
        updateGoalInfo()
        
    }
    
    private func setupGameZone() {
        gameZone = SKShapeNode(circleOfRadius: 170)
        gameZone.position = ball.position
        gameZone.strokeColor = SKColor.clear
        gameZone.fillColor = SKColor.clear
        addChild(gameZone)
    }
    
    private func showScoreEffect(at position: CGPoint) {
        let scoreLabel = SKLabelNode(text: "+1")
        scoreLabel.fontName = "Katibeh-Regular"
        scoreLabel.fontSize = 20
        scoreLabel.fontColor = .white
        scoreLabel.position = position
        scoreLabel.zPosition = 10
        addChild(scoreLabel)
        
        let moveUp = SKAction.moveBy(x: 0, y: 20, duration: 0.5)
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([SKAction.group([moveUp, fadeOut]), remove])
        
        scoreLabel.run(sequence)
    }
    
    private func spawnBalls() {
        guard !isPaused else { return }
        let spawnAction = SKAction.run {
            let randomImage = self.generateRandomBallImage()
            let newBall = SKSpriteNode(imageNamed: randomImage)
            newBall.size = CGSize(width: 32, height: 32)
            newBall.position = CGPoint(x: self.size.width / 2, y: self.size.height - 50)
            newBall.name = randomImage
            newBall.physicsBody = SKPhysicsBody(circleOfRadius: newBall.size.width / 2 - 1)
            newBall.physicsBody?.isDynamic = true
            newBall.physicsBody?.affectedByGravity = true
            newBall.physicsBody?.categoryBitMask = 1
            newBall.physicsBody?.contactTestBitMask = 1
            newBall.physicsBody?.linearDamping = 0
            newBall.physicsBody?.angularDamping = 0
            newBall.physicsBody?.friction = 0
            newBall.zRotation = 0
            self.addChild(newBall)
        }
        
        let waitAction = SKAction.wait(forDuration: 2.0)
        let sequence = SKAction.sequence([spawnAction, waitAction])
        run(SKAction.repeatForever(sequence))
    }
    
    private func generateRandomBallImage() -> String {
        var weightedImages: [String] = []
        for (image, weight) in ballProbabilities {
            weightedImages += Array(repeating: image, count: weight)
        }
        
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
            let ballPositionInScene = self.convert(attachedBall.position, from: ball)
            if !gameZone.contains(ballPositionInScene) && attachedBall != ball{
                print("Game Over: Ball \(attachedBall.name ?? "") is outside the game zone at position \(ballPositionInScene)")
                gameOver()
                break
            }
        }
    }




    private func gameOver() {
        self.view?.isPaused = true
        
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

        updateAllFlags()

        checkForRemoval()

        if newBall.name == "bombBallImage" {
            showBombRadius(for: newBall)
            explodeBomb(after: 1.0, bomb: newBall)
        }
    }
    private func showBombRadius(for bomb: SKSpriteNode) {
        let explosionRadius: CGFloat = 70
        
        let explosionCircle = SKShapeNode(circleOfRadius: explosionRadius)
        explosionCircle.strokeColor = .red
        explosionCircle.lineWidth = 2.5
        explosionCircle.fillColor = .clear
        explosionCircle.name = "explosionCircle"
        
        explosionCircle.position = CGPoint.zero
        bomb.addChild(explosionCircle)
    }

    
    private func explodeBomb(after delay: TimeInterval, bomb: SKSpriteNode) {
        let explosionRadius: CGFloat = 70
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            guard self.attachedBalls.contains(bomb) else { return }
            
            let bombPositionInScene = bomb.parent?.convert(bomb.position, to: self) ?? bomb.position

            let ballsToRemove = self.attachedBalls.filter { ball in
                let ballPositionInScene = ball.parent?.convert(ball.position, to: self) ?? ball.position
                return bombPositionInScene.distance(to: ballPositionInScene) <= explosionRadius
            }
            
            for ball in ballsToRemove {
                if ball != self.ball {
                    ball.removeFromParent()
                    self.attachedBalls.removeAll { $0 == ball }
                    self.ballFlags.removeValue(forKey: ball)
                    self.goalTracker.updateProgress(for: ball.name!)
                }
            }

            bomb.removeFromParent()
            self.attachedBalls.removeAll { $0 == bomb }
            self.ballFlags.removeValue(forKey: bomb)
            self.updateGoalInfo()
            // Проверяем, достигнута ли цель
            if self.goalTracker.isGoalCompleted() && !self.isGameWon {
                print("Вы выполнили все цели!")
                self.isPaused = true
                self.isGameWon = true
            }
            print("Bomb exploded! Removed \(ballsToRemove.count) balls.")
        }
    }

    
    private func updateAllFlags() {
        let allBalls = attachedBalls.filter{$0 != self.ball}
        
        for ball in allBalls {
            for otherBall in allBalls {
                if ball != otherBall && ball.name == otherBall.name {
                    mergeFlags(ball)
                }
            }
        }
    }
    
    private func mergeFlags(_ newBall: SKSpriteNode) {
        let newBallPositionInScene = newBall.parent?.convert(newBall.position, to: self) ?? newBall.position

        let nearbyBalls = attachedBalls.filter { ball in
            guard ball.name == newBall.name || newBall.name == "rainbowBallImage" || ball.name == "rainbowBallImage" else { return false }

            let ballPositionInScene = ball.parent?.convert(ball.position, to: self) ?? ball.position
            return ballPositionInScene.distance(to: newBallPositionInScene) < 40
        }

        var flagSet: Set<String> = nearbyBalls.compactMap { ballFlags[$0] }.reduce(into: Set<String>()) { $0.formUnion($1) }

        if newBall.name == "rainbowBallImage" {
            flagSet.formUnion(nearbyBalls.compactMap { ballFlags[$0] }.reduce(into: Set<String>()) { $0.formUnion($1) })
        }


        if flagSet.isEmpty {
            flagSet.insert(UUID().uuidString)
        }

        for ball in nearbyBalls + [newBall] {
            ballFlags[ball] = (ballFlags[ball] ?? Set()).union(flagSet)
        }
    }



    private func checkForRemoval() {
        var flagGroups: [String: [SKSpriteNode]] = [:]

        for (ball, flags) in ballFlags {
            for flag in flags {
                flagGroups[flag, default: []].append(ball)
            }
        }

        for (flag, balls) in flagGroups where balls.count >= 3 {

            var toRemove: [SKSpriteNode] = []

            for ball in balls {
                if ball.name != "rainbowBallImage" {
                    toRemove.append(ball)
                }
                if ball.name == "rainbowBallImage", let ballFlagsSet = ballFlags[ball], ballFlagsSet.contains(flag) {
                    toRemove.append(ball)
                }
            }
            for ball in toRemove {
                let position = self.ball.convert(ball.position, to: self)
                RubinManager.shared.addRubins(1)
                showScoreEffect(at: position)
                ball.removeFromParent()
                attachedBalls.removeAll { $0 == ball }
                ballFlags.removeValue(forKey: ball)
                goalTracker.updateProgress(for: ball.name!)
                
            }
        }
        updateGoalInfo()
        if goalTracker.isGoalCompleted() && !isGameWon {
            print("Вы выполнили все цели!")
            self.isPaused = true
            isGameWon = true
        }
    }



    private func updateGoalInfo() {
        NotificationCenter.default.post(name: NSNotification.Name("Goals"), object: goalTracker.getAllGoalsInfo())
    }

    
    private func showWinMessage() {
        self.isPaused = true
        if currentLevel != 12 {
            if LevelManager.shared.isLevelUnlocked(currentLevel + 1) {
                RubinManager.shared.addRubins(50)
            } else {
                RubinManager.shared.addRubins(150)
            }
        } else {
            RubinManager.shared.addRubins(50)
        }
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
        newBall.zRotation = 0
        newBall.position = ball.convert(newBall.position, from: self)
        newBall.physicsBody?.isDynamic = false
        newBall.physicsBody?.affectedByGravity = false

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

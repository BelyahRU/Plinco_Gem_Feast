import SwiftUI
import SpriteKit

struct GameView: View {
    
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
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var rope: SKSpriteNode!
    private var ball: SKSpriteNode!
    private var ropeSpeed: CGFloat = 3.0
    private var attachedBalls: [SKSpriteNode] = [] // Храним прикрепленные шары
    private let ballImages = ["greenBallImage", "purpleBallImage", "pinkBallImage", "orangeBallImage", "darkGreenBallImage", "blueBallImage", "yellowBallImage"]

    override func didMove(to view: SKView) {
        backgroundColor = .clear
        physicsWorld.contactDelegate = self
        
        setupRope()
        setupBall()
        spawnBalls()
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

        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.isDynamic = false
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.allowsRotation = true
        ball.physicsBody?.categoryBitMask = 1
        ball.physicsBody?.collisionBitMask = 1
        ball.physicsBody?.contactTestBitMask = 1

        addChild(ball)
        attachedBalls.append(ball) // Добавляем центральный шар в список
    }

    private func spawnBalls() {
        let spawnAction = SKAction.run {
            let randomImage = self.ballImages.randomElement() ?? "greenBallImage"
            let newBall = SKSpriteNode(imageNamed: randomImage)
            newBall.size = CGSize(width: 32, height: 32)
            newBall.position = CGPoint(x: self.size.width / 2, y: self.size.height - 50)

            newBall.physicsBody = SKPhysicsBody(circleOfRadius: newBall.size.width / 2)
            newBall.physicsBody?.isDynamic = true
            newBall.physicsBody?.affectedByGravity = true
            newBall.physicsBody?.allowsRotation = true
            newBall.physicsBody?.categoryBitMask = 1
            newBall.physicsBody?.collisionBitMask = 1
            newBall.physicsBody?.contactTestBitMask = 1

            self.addChild(newBall)
        }

        let waitAction = SKAction.wait(forDuration: 1.0)
        let sequence = SKAction.sequence([spawnAction, waitAction])
        run(SKAction.repeatForever(sequence))
    }

    func didBegin(_ contact: SKPhysicsContact) {
        if let nodeA = contact.bodyA.node as? SKSpriteNode, let nodeB = contact.bodyB.node as? SKSpriteNode {
            if attachedBalls.contains(nodeA) && !attachedBalls.contains(nodeB) {
                attachBall(nodeB, to: nodeA)
            } else if attachedBalls.contains(nodeB) && !attachedBalls.contains(nodeA) {
                attachBall(nodeA, to: nodeB)
            }
        }
    }

    private func attachBall(_ newBall: SKSpriteNode, to parentBall: SKSpriteNode) {
        newBall.removeFromParent()
        newBall.position = parentBall.convert(newBall.position, from: self)
        newBall.physicsBody = SKPhysicsBody(circleOfRadius: newBall.size.width / 2)
        newBall.physicsBody?.isDynamic = false
        newBall.physicsBody?.affectedByGravity = false

        parentBall.addChild(newBall)
        attachedBalls.append(newBall)

        // Соединяем шары физическим соединением
        let joint = SKPhysicsJointPin.joint(withBodyA: parentBall.physicsBody!,
                                            bodyB: newBall.physicsBody!,
                                            anchor: parentBall.position)
        physicsWorld.add(joint)
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

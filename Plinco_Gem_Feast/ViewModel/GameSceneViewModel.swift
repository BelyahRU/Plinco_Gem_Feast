
struct Goal {
    let color: String
    let targetCount: Int
    var currentCount: Int = 0
}

class GoalTracker {
    private var ballProbabilities: [String: Int] = [
        "greenBallImage": 30,
        "purpleBallImage": 10,
        "blueBallImage": 30,
        "darkGreenBallImage": 2,
        "orangeBallImage": 2,
        "pinkBallImage": 10,
        "yellowBallImage": 12,
        "rainbowBallImage": 2,
        "bombBallImage" : 2
    ]
    var goals: [Goal]
    var levelGoals: [[Goal]] = [
        [Goal(color: "greenBallImage", targetCount: 3), Goal(color: "pinkBallImage", targetCount: 3), Goal(color: "darkGreenBallImage", targetCount: 6)], //1
        
        [Goal(color: "blueBallImage", targetCount: 6), Goal(color: "purpleBallImage", targetCount: 6), Goal(color: "yellowBallImage", targetCount: 6)], //2
        
        [Goal(color: "darkGreenBallImage", targetCount: 3), Goal(color: "yellowBallImage", targetCount: 6), Goal(color: "orangeBallImage", targetCount: 3), Goal(color: "greenBallImage", targetCount: 9)], //3
        
        [Goal(color: "greenBallImage", targetCount: 3), Goal(color: "pinkBallImage", targetCount: 3), Goal(color: "blueBallImage", targetCount: 3), Goal(color: "orangeBallImage", targetCount: 9)], //4
        
        [Goal(color: "yellowBallImage", targetCount: 9), Goal(color: "greenBallImage", targetCount: 9), Goal(color: "purpleBallImage", targetCount: 9), Goal(color: "darkGreenBallImage", targetCount: 6)], //5
        
        [Goal(color: "rainbowBallImage", targetCount: 1), Goal(color: "purpleBallImage", targetCount: 3), Goal(color: "orangeBallImage", targetCount: 9), Goal(color: "pinkBallImage", targetCount: 12)], //6
        
        [Goal(color: "bombBallImage", targetCount: 1), Goal(color: "yellowBallImage", targetCount: 6), Goal(color: "rainbowBallImage", targetCount: 1), Goal(color: "greenBallImage", targetCount: 9)], //7
        
        [Goal(color: "purpleBallImage", targetCount: 12), Goal(color: "darkGreenBallImage", targetCount: 12), Goal(color: "pinkBallImage", targetCount: 9), Goal(color: "orangeBallImage", targetCount: 12)], //8
        
        [Goal(color: "darkGreenBallImage", targetCount: 9), Goal(color: "greenBallImage", targetCount: 12), Goal(color: "yellowBallImage", targetCount: 9), Goal(color: "blueBallImage", targetCount: 6)], //9
        
        [Goal(color: "blueBallImage", targetCount: 12), Goal(color: "purpleBallImage", targetCount: 3), Goal(color: "pinkBallImage", targetCount: 3), Goal(color: "greenBallImage", targetCount: 6)], //10
        
        [Goal(color: "rainbowBallImage", targetCount: 2), Goal(color: "purpleBallImage", targetCount: 9), Goal(color: "orangeBallImage", targetCount: 12), Goal(color: "bombBallImage", targetCount: 1)], //11
        
        [Goal(color: "darkGreenBallImage", targetCount: 15), Goal(color: "blueBallImage", targetCount: 12), Goal(color: "greenBallImage", targetCount: 9), Goal(color: "rainbowBallImage", targetCount: 3)], //12
        
    ]
    
    init() {
        self.goals = levelGoals[0]
    }
    
    func setLevel(level: Int) {
        guard level >= 0 && level < levelGoals.count else {
            print("Уровень \(level) не существует")
            return
        }
        self.goals = levelGoals[level]
    }
    
    func updateProgress(for color: String) {
        for i in 0..<goals.count {
            if goals[i].color == color && goals[i].currentCount < goals[i].targetCount {
                goals[i].currentCount += 1
                break
            }
        }
    }
    
    func isGoalCompleted() -> Bool {
        for goal in goals {
            if goal.currentCount < goal.targetCount {
                return false
            }
        }
        return true
    }
    
    func getAllGoalsInfo() -> [(color: String, currentCount: Int, targetCount: Int)] {
        return goals.map { ($0.color, $0.currentCount, $0.targetCount) }
    }
}

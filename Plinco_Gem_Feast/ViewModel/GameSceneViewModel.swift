
struct Goal {
    let color: String
    let targetCount: Int
    var currentCount: Int = 0
}

class GoalTracker {
    var goals: [Goal]
    
    var levelSettings: [[String: Int]] = [
        //1 level
        [
            "greenBallImage": 30,
            "purpleBallImage": 10,
            "blueBallImage": 30,
            "darkGreenBallImage": 20,
            "orangeBallImage": 2,
            "pinkBallImage": 15,
            "yellowBallImage": 12,
            "rainbowBallImage": 5,
            "bombBallImage" : 54
        ],
        //2 level
        [
            "greenBallImage": 10,
            "purpleBallImage": 30,
            "blueBallImage": 30,
            "darkGreenBallImage": 5,
            "orangeBallImage": 20,
            "pinkBallImage": 10,
            "yellowBallImage": 30,
            "rainbowBallImage": 8,
            "bombBallImage" : 4
        ],
        
        //3 level
        [
            "greenBallImage": 50,
            "purpleBallImage": 10,
            "blueBallImage": 5,
            "darkGreenBallImage": 25,
            "orangeBallImage": 20,
            "pinkBallImage": 5,
            "yellowBallImage": 35,
            "rainbowBallImage": 3,
            "bombBallImage" : 6
        ],
        
        //4 level
        [
            "greenBallImage": 20,
            "purpleBallImage": 5,
            "blueBallImage": 20,
            "darkGreenBallImage": 5,
            "orangeBallImage": 40,
            "pinkBallImage": 20,
            "yellowBallImage": 10,
            "rainbowBallImage": 3,
            "bombBallImage" : 6
        ],
        
        //5 level
        [
            "greenBallImage": 30,
            "purpleBallImage": 30,
            "blueBallImage": 5,
            "darkGreenBallImage": 20,
            "orangeBallImage": 10,
            "pinkBallImage": 5,
            "yellowBallImage": 25,
            "rainbowBallImage": 8,
            "bombBallImage" : 12
        ],
        //6 level
        [
            "greenBallImage": 10,
            "purpleBallImage": 15,
            "blueBallImage": 10,
            "darkGreenBallImage": 10,
            "orangeBallImage": 25,
            "pinkBallImage": 35,
            "yellowBallImage": 8,
            "rainbowBallImage": 8,
            "bombBallImage" : 10
        ],
        
        //7 level
        [
            "greenBallImage": 30,
            "purpleBallImage": 10,
            "blueBallImage": 10,
            "darkGreenBallImage": 10,
            "orangeBallImage": 25,
            "pinkBallImage": 15,
            "yellowBallImage": 25,
            "rainbowBallImage": 8,
            "bombBallImage" : 8
        ],
        
        //8 level
        [
            "greenBallImage": 10,
            "purpleBallImage": 25,
            "blueBallImage": 5,
            "darkGreenBallImage": 30,
            "orangeBallImage": 40,
            "pinkBallImage": 25,
            "yellowBallImage": 25,
            "rainbowBallImage": 6,
            "bombBallImage" : 12
        ],
        
        //9 level
        [
            "greenBallImage": 20,
            "purpleBallImage": 10,
            "blueBallImage": 15,
            "darkGreenBallImage": 30,
            "orangeBallImage": 10,
            "pinkBallImage": 15,
            "yellowBallImage": 30,
            "rainbowBallImage": 8,
            "bombBallImage" : 12
        ],
        
        //10 level
        [
            "greenBallImage": 30,
            "purpleBallImage": 20,
            "blueBallImage": 30,
            "darkGreenBallImage": 30,
            "orangeBallImage": 10,
            "pinkBallImage": 15,
            "yellowBallImage": 10,
            "rainbowBallImage": 5,
            "bombBallImage" : 10
        ],
        
        //11 level
        [
            "greenBallImage": 20,
            "purpleBallImage": 20,
            "blueBallImage": 40,
            "darkGreenBallImage": 5,
            "orangeBallImage": 5,
            "pinkBallImage": 30,
            "yellowBallImage": 10,
            "rainbowBallImage": 5,
            "bombBallImage" : 8
        ],
        
        
        //12 level
        [
            "greenBallImage": 25,
            "purpleBallImage": 8,
            "blueBallImage": 30,
            "darkGreenBallImage": 35,
            "orangeBallImage": 10,
            "pinkBallImage": 5,
            "yellowBallImage": 5,
            "rainbowBallImage": 15,
            "bombBallImage" : 10
        ],
    ]
    
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
    
    func getLevelSettings(level: Int) -> [String: Int] {
        var result: [String: Int]
        if levelSettings.count < level || level <= 0{
            result = levelSettings.randomElement()!
        } else {
            
            result = levelSettings[level-1]
        }
        print(result)
        return result
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
        print(goals)
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


struct Goal {
    let color: String
    let targetCount: Int
    var currentCount: Int = 0
}

class GoalTracker {
    
    var goals: [Goal]
    var levelGoals: [[Goal]] = [
        [Goal(color: "blueBallImage", targetCount: 1)], //1
        [Goal(color: "blueBallImage", targetCount: 1), Goal(color: "greenBallImage", targetCount: 1)],//2
        [Goal(color: "blueBallImage", targetCount: 1), Goal(color: "greenBallImage", targetCount: 1)],//3
        [Goal(color: "blueBallImage", targetCount: 1), Goal(color: "greenBallImage", targetCount: 1)],//4
        [Goal(color: "blueBallImage", targetCount: 1), Goal(color: "greenBallImage", targetCount: 1)],//...
        [Goal(color: "blueBallImage", targetCount: 1), Goal(color: "greenBallImage", targetCount: 1)],
        [Goal(color: "blueBallImage", targetCount: 1), Goal(color: "greenBallImage", targetCount: 1)],
        [Goal(color: "blueBallImage", targetCount: 1), Goal(color: "greenBallImage", targetCount: 1)],
        [Goal(color: "blueBallImage", targetCount: 1), Goal(color: "greenBallImage", targetCount: 1)],
        [Goal(color: "blueBallImage", targetCount: 1), Goal(color: "greenBallImage", targetCount: 1)],
        // Добавьте остальные уровни здесь
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

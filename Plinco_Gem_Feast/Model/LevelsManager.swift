
import Foundation

class LevelManager {
    static let shared = LevelManager()
    
    private let totalLevels = 12
    private let userDefaults = UserDefaults.standard
    private let levelsKey = "levels"
    
    private init() {}
    
    // Получаем текущий список разблокированных уровней (словарь)
    var levels: [String: Bool] {
        get {
            if let savedLevels = userDefaults.dictionary(forKey: levelsKey) as? [String: Bool] {
                return savedLevels
            } else {
                // Если данных нет, возвращаем словарь с первым уровнем разблокированным
                var defaultLevels = [String: Bool]()
                for i in 1...totalLevels {
                    if i == 1 {
                        defaultLevels[String(i)] = true
                    } else {
                        defaultLevels[String(i)] = false
                    }
                }
                return defaultLevels
            }
        }
        set {
            userDefaults.set(newValue, forKey: levelsKey)
        }
    }
    
    // Проверяем, разблокирован ли уровень
    func isLevelUnlocked(_ level: Int) -> Bool {
        return levels[String(level)] ?? false
    }
    
    
    
    func ulockLevel(for level: Int) {
        
        levels[String(level)] = true
        print(levels)
    }
}

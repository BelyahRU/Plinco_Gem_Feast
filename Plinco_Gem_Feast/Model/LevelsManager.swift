
import Foundation

class LevelManager {
    static let shared = LevelManager()
    
    private let totalLevels = 12
    private let userDefaults = UserDefaults.standard
    private let levelsKey = "levels"
    
    private init() {}
    
    // Получаем текущий список разблокированных уровней (словарь)
    var levels: [Int: Bool] {
        get {
            if let savedLevels = userDefaults.dictionary(forKey: levelsKey) as? [Int: Bool] {
                return savedLevels
            } else {
                // Если данных нет, возвращаем словарь с первым уровнем разблокированным
                var defaultLevels = [Int: Bool]()
                for i in 1...totalLevels {
                    defaultLevels[i] = i == 1 // Первый уровень всегда разблокирован
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
        return levels[level] ?? false
    }
    
    // Функция для разблокировки следующего уровня
    func unlockNextLevel() {
        for level in 1...totalLevels {
            if let isUnlocked = levels[level], !isUnlocked {
                levels[level] = true
                break
            }
        }
    }
}


import Foundation

class ShopManager: ObservableObject {
    static let shared = ShopManager()
    
    private let charactersKey = "purchasedCharacterssd"
    private let prices = [300, 400, 500, 600, 700]
    
    @Published private var purchasedCharacters: [Bool] {
        didSet {
            UserDefaults.standard.set(purchasedCharacters, forKey: charactersKey)
        }
    }
//    private var purchasedCharacters: [Bool] = [true, true, true, true, true]
    
    private init() {
        if let savedData = UserDefaults.standard.array(forKey: charactersKey) as? [Bool], savedData.count == prices.count {
            self.purchasedCharacters = savedData
        } else {
            self.purchasedCharacters = Array(repeating: false, count: prices.count)
            UserDefaults.standard.set(purchasedCharacters, forKey: charactersKey)
        }
    }
    
    func getPurchasedCharacters() -> [Bool] {
        return purchasedCharacters
    }
    
    func isAllCompleted() -> Bool {
        for i in purchasedCharacters {
            if i == true {
                continue
            } else {
                return false
            }
        }
        return true
    }
    
    func buyCharacter(index: Int) -> Bool {
        guard index >= 0, index < prices.count else { return false }
        
        if purchasedCharacters[index] {
            return true // Уже куплен
        }
        
        if RubinManager.shared.subtractRubins(prices[index]) {
            purchasedCharacters[index] = true
            return true // Покупка успешна
        }
        
        return false // Не хватило валюты
    }
}

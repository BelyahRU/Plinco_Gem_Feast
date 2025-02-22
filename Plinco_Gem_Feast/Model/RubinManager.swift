

import Foundation

class RubinManager: ObservableObject {
    static let shared = RubinManager()

    private let rubinKey = "rubinKey"
    
    public var currentRubins: Int {
        return storedRubins
    }
    
    @Published private var storedRubins: Int {
        didSet {
            UserDefaults.standard.set(storedRubins, forKey: rubinKey)
        }
    }
    
    private init() {
        
        if UserDefaults.standard.object(forKey: rubinKey) == nil {
            self.storedRubins = 0
        } else {
            self.storedRubins = UserDefaults.standard.object(forKey: rubinKey) as! Int
        }
        
    }
    
    func addRubins(_ amount: Int) {
        storedRubins += amount
    }
    
    
    func subtractRubins(_ amount: Int) -> Bool {
        if storedRubins >= amount {
            storedRubins -= amount
            return true
        } else {
            return false
        }
    }
}



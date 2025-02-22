
import Foundation
import UIKit

struct SizeData {
    
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    static let isSmallPhone = UIScreen.main.bounds.height < 700
    
    static let screenSize = CGSize(width: UIScreen.main.bounds.width,
                                   height: UIScreen.main.bounds.height)
    
    static let offsetY: CGFloat = screenHeight < 700 ? 150 : 0 
//    static let offsetX: CGFloat = screenHeight < 700 ? 0 : 15
    
//    static let offsetX:
    static var offsetX: CGFloat {
        if screenHeight > 900 {
            return 30
        } else if screenHeight > 820 {
            return 15
        } else {
            return 0
        }
    }
    
    
}

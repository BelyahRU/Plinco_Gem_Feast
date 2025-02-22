
import Foundation
import UIKit

struct SizeData {
    
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    static let isSmallPhone = UIScreen.main.bounds.height < 700
    
    static let screenSize = CGSize(width: UIScreen.main.bounds.width,
                                   height: UIScreen.main.bounds.height)
}

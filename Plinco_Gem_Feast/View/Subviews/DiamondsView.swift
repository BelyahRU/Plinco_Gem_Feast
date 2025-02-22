
import SwiftUI

struct DiamondsView: View {
    
    @StateObject var rubinManager = RubinManager.shared
    
    var body: some View {
        ZStack(alignment: .center) {
            Image("diamondsBack")
                .resizable()
                .scaledToFit()
                .frame(width: 110)
            CustomText(text: "\(rubinManager.currentRubins)", width: 2.3)
                .font(.custom("Katibeh-Regular", size: 29))
                .foregroundStyle(.white)
                .padding(.leading, 30)
                .padding(.top, 11)
                
        }
    }
}


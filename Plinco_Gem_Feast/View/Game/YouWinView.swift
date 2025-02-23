
import SwiftUI

struct YouWinView: View {
    
    var onHome: () -> Void
    var onNext: () -> Void
    
    
    var body: some View {
        Color(.black.withAlphaComponent(0.5))
            .edgesIgnoringSafeArea(.all)
        Image("youWinBack")
            .resizable()
            .scaledToFill()
            .frame(maxWidth: SizeData.screenWidth)
        HStack {
            Button {
                onHome()
            } label: {
                Image("pauseHomeButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 59, height: 59)
            }
            Spacer()
            Button {
                onNext()
            } label: {
                Image("nextLevelButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 59, height: 59)
            }
        }
        .padding(.horizontal, 60)
        .position(CGPoint(x: SizeData.screenWidth / 2, y: SizeData.screenHeight - 100))
//        .edgesIgnoringSafeArea(.all)
    }
}

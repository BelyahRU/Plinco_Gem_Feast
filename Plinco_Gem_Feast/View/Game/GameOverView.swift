
import SwiftUI

struct GameOverView: View {
    
    var onAgain: () -> Void
    var onHome: () -> Void
    
    var body: some View {
        ZStack {
            Color(.black.withAlphaComponent(0.5))
                .edgesIgnoringSafeArea(.all)
            
            ZStack(alignment: .bottom) {
                Image("gameOverBack")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 346, height: 567)
                
                Button {
                    onAgain()
                } label: {
                    Image("tryAgainButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 231,height: 68)
                }
                .padding(.bottom, 40)

            }
            .frame(width: 346, height: 567)
            .padding(.bottom, 70)
            
            Button {
                onHome()
            } label: {
                Image("goHomeButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 61,height: 61)
            }
            .position(CGPoint(x: SizeData.screenWidth / 2, y:  SizeData.screenHeight - (SizeData.isSmallPhone ? 0 :70)))

        }
        .edgesIgnoringSafeArea(.all)
    }
}

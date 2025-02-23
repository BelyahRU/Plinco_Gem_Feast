
import SwiftUI

struct PauseView: View {
    
    var onPlay: () -> Void
    var onHome: () -> Void
    var onInfo: () -> Void
    
    var body: some View {
        ZStack {
            Color(.black.withAlphaComponent(0.5))
                .edgesIgnoringSafeArea(.all)
            ZStack(alignment: .bottom) {
                
                Image("pauseBackground")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 311, height: 257)
                HStack(alignment: .bottom, spacing: 28) {
                    Button {
                        onHome()
                    } label: {
                        Image("pauseHomeButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 59, height: 59)
                    }
                    Button {
                        onPlay()
                    } label: {
                        Image("pausePlayButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 59, height: 59)
                    }
                    Button {
                        onInfo()
                    } label: {
                        Image("pauseInfoButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 59, height: 59)
                    }
                }
                .padding(.bottom, 50)

            }
            .padding(.bottom, SizeData.isSmallPhone ? 130: 0)
        }
    }
}

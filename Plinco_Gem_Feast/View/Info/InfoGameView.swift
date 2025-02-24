

import SwiftUI

struct InfoGameView: View {
    @State var currentIndex = 1
    
    var onCancel: () -> Void
    var onPlay: () -> Void
    
    var body: some View {
        ZStack {
            Color(.black.withAlphaComponent(0.5))
                .edgesIgnoringSafeArea(.all)
            
            ZStack {
                Image("infoImage\(currentIndex)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 326, height: 576, alignment: .center)
                
                if currentIndex == 1 {
                    Button {
                        currentIndex = 2
                    } label: {
                        Image("infoRightButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                    }
                    .position(CGPoint(x: UIScreen.main.bounds.width - 50, y: UIScreen.main.bounds.height / 2 + (SizeData.isSmallPhone ? 70: 0)))
                } else {
                    Button {
                        currentIndex = 1
                    } label: {
                        Image("infoLeftButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                    }
                    .position(CGPoint(x: 50, y: UIScreen.main.bounds.height / 2 + (SizeData.isSmallPhone ? 70: 0)))
                }
                Button(action: {
                    onCancel()
                }) {
                    Image("cancelInfoButton")
                        .resizable()
                        .frame(width: 45, height: 45)
                        
                }
                .frame(width: 45, height: 45)
                .position(CGPoint(x: 38.5, y: SizeData.isSmallPhone ? 102.5 :  70.5))
                
                if currentIndex == 2 {
                    Button(action: {
                        onPlay()
                    }) {
                        Image("infoPlayButton")
                            .resizable()
                            .frame(width: 198, height: 68)
                        
                    }
                    .frame(width: 45, height: 45)
                    .position(CGPoint(x: SizeData.screenWidth / 2, y: SizeData.screenHeight - (SizeData.isSmallPhone ? 8 : 100)))
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

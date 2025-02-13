
import SwiftUI

struct WelcomeStoryView:View {
    
    var onMain: () -> Void
    
    let textSizes: [CGSize] = [CGSize(width: 290.73, height: 182),
                               CGSize(width: 290.73, height: 164),
                               CGSize(width: 270.73, height: 136),
    ]
    
    let textPositions: [CGPoint] = [CGPoint(x: SizeData.screenWidth / 2 , y: 210),
                                    CGPoint(x: SizeData.screenWidth / 2 , y: SizeData.screenHeight-(SizeData.isSmallPhone ? 115 :250)),
                                    CGPoint(x: SizeData.screenWidth / 2 , y: 230)]
    
    @State var currentScreen = 1
    
    var body: some View {
        ZStack {
            Image("\(currentScreen)WelcomeBack")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .zIndex(1)
            
            //text
            if currentScreen == 1 {
                VStack(alignment: .center,spacing: 0) {
                    Text("Hello!")
                        .font(.custom("Katibeh-Regular", size: 70))
                        .foregroundStyle(Color(red: 1/255, green: 108/255, blue: 161/255))
                    Image("\(currentScreen)WelcomeText")
                        .resizable()
                        .scaledToFit()
                        .frame(width: textSizes[currentScreen-1].width, height: textSizes[currentScreen-1].height)
                        .padding(.top, -30)
                }
                .position(textPositions[0])
                .zIndex(3)
            } else {
                Image("\(currentScreen)WelcomeText")
                    .resizable()
                    .scaledToFit()
                    .frame(width: textSizes[currentScreen-1].width, height: textSizes[currentScreen-1].height)
                    .position(textPositions[currentScreen-1])
                    .zIndex(3)
            }
            
            //right/play button
            Button {
                if currentScreen < 3 {
                    currentScreen += 1
                } else if currentScreen == 3 {
                    onMain()
                }
            } label: {
                if currentScreen == 3 {
                    Image("playWelcomeButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 198, height: 68)
                } else {
                    Image("rightWelcomeButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                }
            }
            .position(CGPoint(x: currentScreen == 3 ? (SizeData.screenWidth - 115) : (SizeData.screenWidth - 46),
                              y: (SizeData.screenHeight - (SizeData.isSmallPhone ? 10 :69))))
            .zIndex(2)
            
            if currentScreen > 1 {
                //left button
                Button {
                    if currentScreen > 1 {
                        currentScreen -= 1
                    }
                } label: {
                    Image("leftWelcomeButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                }
                .position(CGPoint(x: 46, y: SizeData.screenHeight - (SizeData.isSmallPhone ? 10 :69)))
                .zIndex(2)
            }

            
            //left button

        }
    }
}


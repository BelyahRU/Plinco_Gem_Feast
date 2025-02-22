
import SwiftUI

struct LevelsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    let columns = [
        GridItem(.fixed(85), spacing: 15),
        GridItem(.fixed(85), spacing: 15),
        GridItem(.fixed(85), spacing: 15)
    ]
    @State var currentlevel = 0
    @State var isGame = false
    
    var body: some View {
        if isGame {
            GameView(currentLevel: currentlevel)
                .edgesIgnoringSafeArea(.all)
                .navigationBarHidden(true)
        } else {
            ZStack {
                
                Image("levelsBackgroundImage")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image("backHomeButton")
                        .resizable()
                        .frame(width: 45, height: 45)
                        
                }
                .frame(width: 45, height: 45)
                .position(CGPoint(x: 38.5, y: SizeData.isSmallPhone ? 102.5 :  62.5))
                
                VStack(alignment: .center, spacing: 40) {
                    Text("Levels")
                        .font(.custom("Katibeh-Regular", size: 70))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.white)
                    LazyVGrid(columns: columns, spacing: 25) { // Вертикальный отступ 36
                        ForEach(1...12, id: \.self) { index in
                            VStack {
                                Button {
                                    print(index)
                                    if LevelManager.shared.isLevelUnlocked(index) {
                                        currentlevel = index
                                        isGame = true
                                    }
                                } label: {
                                    Image(LevelManager.shared.isLevelUnlocked(index) ? "\(index)LevelImage" : "levelClosedImage")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 85, height: 80)
                                }
                            }
                        }
                    }
                    .padding()
                }
                DiamondsView()
                    .zIndex(2)
                    .position(CGPoint(x: 71, y: SizeData.screenHeight - (SizeData.isSmallPhone ? 0 :80)))
            }
            .navigationBarHidden(true)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LevelsView()
    }
}

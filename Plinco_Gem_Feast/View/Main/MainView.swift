import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Основной фон
                Image("mainBackgroundImage")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(1)
                
                // Кнопка Info с переходом
                NavigationLink(destination: InfoView()) {
                    Image("infoButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 43, height: 43)
                }
                .position(CGPoint(x: SizeData.screenWidth - 40, y: SizeData.isSmallPhone ? 100 :60))
                .zIndex(2)

                // Кнопка Play с переходом
                NavigationLink(destination: GameView()) {
                    Image("playGameButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 118, height: 198)
                }
                .position(CGPoint(x: SizeData.screenWidth - 130, y: SizeData.screenHeight / 2 + (SizeData.isSmallPhone ? 120 :50)))
                .zIndex(2)
                
                // Кнопка Dining Room с переходом
                NavigationLink(destination: DiningRoomView()) {
                    Image("diningRoomButton")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 139, height: 94)
                }
                .position(CGPoint(x: 85, y: SizeData.screenHeight / 2 + (SizeData.isSmallPhone ? 170 :100)))
                .zIndex(2)
                
                DiamondsView()
                    .zIndex(2)
                    .position(CGPoint(x: 71, y: SizeData.screenHeight - (SizeData.isSmallPhone ? 0 :39)))
            }
        }
        .navigationBarHidden(true) // Скрыть навигационный бар
    }
}

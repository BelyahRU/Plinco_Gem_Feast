
import SwiftUI

struct InviteFriendView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var shopManager = ShopManager.shared
    
    var onCancel: () -> Void

    var body: some View {
        ZStack {
            Color(.black.withAlphaComponent(0.5))
                .edgesIgnoringSafeArea(.all)
            Button(action: {
                onCancel()
            }) {
                Image("backButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45, height: 45)
                    
            }
            .frame(width: 45, height: 45)
            .position(CGPoint(x: 38.5, y: SizeData.isSmallPhone ? 102.5 :  62.5))
            Text("My friends")
                .font(.custom("Katibeh-Regular", size: 50))
                .foregroundStyle(.white)
                .position(CGPoint(x: SizeData.screenWidth / 2, y: 112))
            
            Text(shopManager.isAllCompleted() ? "All my friends\nwith me!\n" :"Gather all my friends\nfor dinner\n")
                .font(.custom("Katibeh-Regular", size: 24))
                .foregroundStyle(.white)
                .position(CGPoint(x: SizeData.screenWidth / 2, y: 160))
                .multilineTextAlignment(.center)
            VStack(spacing: 10) {
                ForEach(0..<5, id: \.self) { index in
                    Button(action: {
                        purchaseCharacter(index: index)
                    }) {
                        Image(shopManager.getPurchasedCharacters()[index] ? "\(index)BuySelected" : "\(index)Buy")
                            .resizable()
                            .frame(width: 285, height: 82)
                    }
                }
            }
            
            DiamondsView()
                .zIndex(3)
                .position(CGPoint(x: 71, y: SizeData.screenHeight - (SizeData.isSmallPhone ? 0 :80)))
        }
        .navigationBarHidden(true)
    }
    
    private func purchaseCharacter(index: Int) {
        if shopManager.buyCharacter(index: index) {
            print("Персонаж успешно куплен")
        } else {
            print("Не удалось купить персонажа или он уже куплен")
        }
    }
}


import SwiftUI

struct DiningRoomTableView: View {
    
    @StateObject var shopManager = ShopManager.shared
    
    var body: some View {
        
        ZStack {
            
            Image("diningBackgroundImage")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .zIndex(1)
            
            Image("tableImage")
                .resizable()
                .scaledToFit()
                .frame(width: 331.93, height: 331.93)
                .position(CGPoint(x: SizeData.screenWidth / 2,
                                  y: SizeData.screenHeight - 273.965 + SizeData.offsetY)) // 108 + 165.965
                .zIndex(3)
            
            Image(shopManager.getPurchasedCharacters()[2] ? "BobFriendImageSelected" : "BobFriendImage")
                .resizable()
                .scaledToFit()
                .frame(width: 197.41, height: 197.41)
                .position(CGPoint(x: 98.705, // 197.41 / 2
                                  y: SizeData.screenHeight - 218.705 + SizeData.offsetY)) // 120 + 98.705
                .zIndex(6)
            
            Image(shopManager.getPurchasedCharacters()[1] ? "LidaFriendImageSelected" : "LidaFriendImage")
                .resizable()
                .scaledToFit()
                .frame(width: 190.6, height: 190.6)
                .position(CGPoint(x: SizeData.screenWidth - 107.3, // 12 + 95.3 (190.6 / 2)
                                  y: SizeData.screenHeight - 224.3 + SizeData.offsetY)) // 129 + 95.3
                .zIndex(6)
            
            Image(shopManager.getPurchasedCharacters()[0] ? "FrankFriendImageSelected" : "FrankFriendImage")
                .resizable()
                .scaledToFit()
                .frame(width: 227.23, height: 227.23)
                .position(CGPoint(x: SizeData.screenWidth - 40  ,
                                  y: SizeData.screenHeight - 343.615 + SizeData.offsetY)) // 230 + 113.615
                .zIndex(5)
            
            Image(shopManager.getPurchasedCharacters()[3] ? "KevinFriendImageSelected" : "KevinFriendImage")
                .resizable()
                .scaledToFit()
                .frame(width: 176.66, height: 176.66)
                .position(CGPoint(x: 40 ,
                                  y: SizeData.screenHeight - 329.33 + SizeData.offsetY)) // 241 + 88.33
                .zIndex(5)

            Image(shopManager.getPurchasedCharacters()[4] ? "MikeFriendImageSelected" : "MikeFriendImage")
                .resizable()
                .scaledToFit()
                .frame(width: 167.59, height: 167.59)
                .position(CGPoint(x: 134 ,
                                  y: SizeData.screenHeight - 423 + SizeData.offsetY))
                .zIndex(2)
            
            Image("mainFriendImage")
                .resizable()
                .scaledToFit()
                .frame(width: 145.22, height: 145.22)
                .position(CGPoint(x: SizeData.screenWidth - 113  ,
                                  y: SizeData.screenHeight - 412 + SizeData.offsetY))
                .zIndex(2)
            
            if shopManager.getPurchasedCharacters()[2] {
                Image("friendCristalsImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .position(CGPoint(x: 143.5 + SizeData.offsetX ,
                                      y: SizeData.screenHeight - 317.5 + SizeData.offsetY))
                    .zIndex(4)
            }
            if shopManager.getPurchasedCharacters()[1] {
                Image("friendCristalsImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .position(CGPoint(x: SizeData.screenWidth - 153 - SizeData.offsetX ,
                                      y: SizeData.screenHeight - 317.5 + SizeData.offsetY))
                    .zIndex(4)
            }
            
            if shopManager.getPurchasedCharacters()[3] {
                Image("friendCristalsImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .position(CGPoint(x: 98.5 + SizeData.offsetX ,
                                      y: SizeData.screenHeight - 347.5 + SizeData.offsetY))
                    .zIndex(4)
            }
            
            if shopManager.getPurchasedCharacters()[0] {
                Image("friendCristalsImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .position(CGPoint(x: SizeData.screenWidth - 112 - SizeData.offsetX ,
                                      y: SizeData.screenHeight - 347.5 + SizeData.offsetY))
                    .zIndex(4)
            }
            if shopManager.getPurchasedCharacters()[4] {
                Image("friendCristalsImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 75)
                    .position(CGPoint(x: 143.5 + SizeData.offsetX ,
                                      y: SizeData.screenHeight - 377 + SizeData.offsetY))
                    .zIndex(3.2)
            }
            Image("mainCristalsImage")
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 120)
                .position(CGPoint(x: 180 + SizeData.offsetX,
                                  y: SizeData.screenHeight - 353 + SizeData.offsetY))
                .zIndex(3.5)
            if shopManager.isAllCompleted() {
                Image("mainFriendCristalsImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 98, height: 98)
                    .position(CGPoint(x: SizeData.screenWidth - 142 - SizeData.offsetX,
                                      y: SizeData.screenHeight - 378 + SizeData.offsetY))
                    .zIndex(3.2)
            }
        }
    }
}

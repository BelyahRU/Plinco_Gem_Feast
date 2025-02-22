import SwiftUI

struct DiningRoomView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var isInviteFriend = false
    @State var isStory = false
    @StateObject var shopManager = ShopManager.shared
    @State var storyindex = 0
    
    
    var body: some View {
        ZStack {
            // Основной контент
            ZStack(alignment: .top) {
                DiningRoomTableView()
                    .edgesIgnoringSafeArea(.all)
                if !isInviteFriend {
                    VStack(spacing: 40) {
                        HStack(alignment: .center) {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                Image("backButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                            }
                            .zIndex(2)
                            Spacer()
                            Button(action: {
                                storyindex = 0
                                isStory.toggle()
                            }) {
                                Image("questionButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 45, height: 45)
                            }
                            .zIndex(2)
                        }
                        .padding(.horizontal, 16)
                        
                        if shopManager.isAllCompleted() {
                            Text("All my friends are with me\nfor dinner, thank you!")
                                .font(.custom("Katibeh-Regular", size: 39))
                                .multilineTextAlignment(.center)
                                .foregroundStyle(.white)
                        } else {
                            Button(action: {
                                isInviteFriend.toggle()
                            }) {
                                Image("inviteFriendsButton")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 227, height: 98)
                            }
                            .zIndex(2)
                        }
                        
                    }
                    .padding(.top, SizeData.isSmallPhone ? 80 : 40)
                }
                
                if !isInviteFriend {
                    DiamondsView()
                        .zIndex(2)
                        .position(CGPoint(x: 71, y: SizeData.screenHeight - (SizeData.isSmallPhone ? 0 :80)))
                }
                
            }
            .blur(radius: isInviteFriend ? 5 : 0)
            if isStory {
                if storyindex == 0 {
                    ZStack(alignment: .topTrailing) {
                        Image("story0")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 247.73, height: 84)
                        Button(action: {
                            storyindex = 1
                        }) {
                            Image("nextTextButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 27, height: 27)
                                .padding(.top, -8)
                                .padding(.trailing, 8)
                        }
                    }
                    .position(CGPoint(x: 142 + SizeData.offsetX,
                                      y: SizeData.screenHeight - (502 - SizeData.offsetY)))
                } else if storyindex == 1 {
                    ZStack(alignment: .topTrailing) {
                        Image("story1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 216, height: 84)
                        Button(action: {
                            storyindex = 2
                        }) {
                            Image("nextTextButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 27, height: 27)
                                .padding(.top, -8)
                                .padding(.trailing, 8)
                        }
                    }
                    .position(CGPoint(x: 158 + SizeData.offsetX,
                                      y: SizeData.screenHeight - (502 - SizeData.offsetY)))
                } else if storyindex == 2 {
                    ZStack(alignment: .topTrailing) {
                        Image("story2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 246, height: 84)
                        Button(action: {
                            storyindex = 3
                        }) {
                            Image("nextTextButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 27, height: 27)
                                .padding(.top, -8)
                                .padding(.trailing, 8)
                        }
                        .zIndex(2)
                    }
                    .position(CGPoint(x: 143 + SizeData.offsetX,
                                      y: SizeData.screenHeight - (502 - SizeData.offsetY)))
                } else {
                    ZStack(alignment: .topTrailing) {
                        Image("story3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 246, height: 84)
                        Button(action: {
                            storyindex = 0
                            isStory.toggle()
                        }) {
                            Image("cancelTextButton")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 27, height: 27)
                                .padding(.top, -8)
                                .padding(.trailing, 25)
                        }
                        .zIndex(2)
                    }
                    .position(CGPoint(x: 166 + SizeData.offsetX,
                                      y: SizeData.screenHeight - (502 - SizeData.offsetY)))
                    
                }
            }
            // InviteFriendView с прозрачным фоном
            if isInviteFriend {
                InviteFriendView(onCancel: {
                    isInviteFriend.toggle()
                })
                    .zIndex(3) // Убедимся, что находится поверх других элементов
            }
        }
        .navigationBarHidden(true)
    }
}

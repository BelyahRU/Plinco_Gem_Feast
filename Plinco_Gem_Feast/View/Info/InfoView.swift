

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var currentIndex = 1
    
    var body: some View {
        ZStack {
            Image("infoBack")
                .resizable()
                .scaledToFill()
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
                    .position(CGPoint(x: UIScreen.main.bounds.width - 50, y: UIScreen.main.bounds.height / 2  + (SizeData.isSmallPhone ? 70: 0)))
                } else {
                    Button {
                        currentIndex = 1
                    } label: {
                        Image("infoLeftButton")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45, height: 45)
                    }
                    .position(CGPoint(x: 50, y: UIScreen.main.bounds.height / 2  + (SizeData.isSmallPhone ? 70: 0)))
                }
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image("backHomeButton")
                        .resizable()
                        .frame(width: 45, height: 45)
                        
                }
                .frame(width: 45, height: 45)
                .position(CGPoint(x: 38.5, y: SizeData.isSmallPhone ? 102.5 :  70.5))
                
            }
            .edgesIgnoringSafeArea(.all)
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.all)
    }
}

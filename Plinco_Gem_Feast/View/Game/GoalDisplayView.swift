import SwiftUI

struct GoalDisplayView: View {
    @Binding var goalsInfo: [(color: String, currentCount: Int, targetCount: Int)]
    
    let borderColor = Color(red: 1.0/255.0, green: 108.0/255.0, blue: 161.0/255.0) // HEX #016CA1

    var body: some View {
        ZStack(alignment: .center) {
            // Фоновое изображение
            Image("goalDisplayBackground")
                .resizable()
                .frame(width: 155, height: 34)  // Размеры фона

            HStack(spacing: 7) {
                ForEach(goalsInfo, id: \.color) { goal in
                    ZStack(alignment: .center) {
                        Image("\(goal.color)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                            .overlay(
                                Circle()  // Обводка вокруг изображения
                                    .stroke(borderColor, lineWidth: 1.5)
                            )
                        
                        CustomText2(text: "\(goal.targetCount - goal.currentCount)")
//                        Text("\(goal.targetCount - goal.currentCount)")
                            .font(.custom("Katibeh-Regular", size: 23))
                            .foregroundColor(.white)
                            .padding(.top, 10)
                    }
                    .padding(.top, 2)
                }
            }
        }
        .frame(width: 155, height: 34)
    }
}



import SwiftUI

struct CustomText: View {
    let text: String
    let width: CGFloat
    let shadowColor: Color = .black.opacity(0.67)
    let strokeColor: Color = Color(red: 1/255, green: 82/255, blue: 121/255) // Цвет обводки (#015279)
    
    var body: some View {
        ZStack {
            // Тень для обводки и основного текста
            ZStack {
                ForEach([-1, 1], id: \.self) { xOffset in
                    ForEach([-1, 1], id: \.self) { yOffset in
                        Text(text)
                            .offset(x: CGFloat(xOffset) + 0, y: CGFloat(yOffset) + width)
                    }
                }
                Text(text)
                    .offset(x: 0, y: width)
            }
            .foregroundColor(shadowColor) // Цвет тени

            // Обводка (дублируем текст с небольшими смещениями)
            ZStack {
                ForEach([-1, 1], id: \.self) { xOffset in
                    ForEach([-1, 1], id: \.self) { yOffset in
                        Text(text)
                            .offset(x: CGFloat(xOffset), y: CGFloat(yOffset))
                    }
                }
            }
            .foregroundColor(strokeColor) // Цвет обводки

            // Основной текст (поверх обводки и тени)
            Text(text)
        }
    }
}


struct CustomText2: View {
    let text: String
    let width: CGFloat = 1
    let color = Color(red: 1.0/255.0, green: 108.0/255.0, blue: 161.0/255.0)
    
    var body: some View {
        ZStack{
            ZStack{
                Text(text).offset(x:  width, y:  width)
                Text(text).offset(x: -width, y: -width)
                Text(text).offset(x: -width, y:  width)
                Text(text).offset(x:  width, y: -width)
            }
            .foregroundColor(color)
            Text(text)
        }
    }
}

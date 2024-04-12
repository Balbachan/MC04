//
//  TimePickerWatch .swift
//  DandieWatch Watch App
//
//  Created by Igor Bragança Toledo on 12/04/24.
//

import Foundation
import SwiftUI

struct TimePickerWatch: View {
    
    @State var hours: Int = 0
    @State var minutes: [Int] = [00, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55]
    
    var body: some View {
        GeometryReader { geometry in
            VStack{
                Text("Horários")
                    .font(.system(size: 22))
                    .fontWeight(.black)
                    .foregroundStyle(Color.black)
                
                //Picker de horas
                HStack {
                    Picker("", selection: $hours){
                        ForEach(0..<24, id: \.self) { i in
                            Text("\(i)").tag(i)
                                .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                        }
                    }.pickerStyle(WheelPickerStyle())
                    
                    Text(":")
                        .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                    
                    Picker("", selection: $minutes){
                        ForEach(minutes, id: \.self) { i in
                            Text("\(i)").tag(i)
                                .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                        }
                    }.pickerStyle(WheelPickerStyle())
                }.frame(width: 180, height: 90)
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(.appWhite)
        }
    }
}

#Preview {
    TimePickerWatch()
}

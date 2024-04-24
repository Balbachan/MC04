//
//  TimePickerWatch .swift
//  DandieWatch Watch App
//
//  Created by Igor Bragança Toledo on 12/04/24.
//

import Foundation
import SwiftUI

struct TimePickerWatch: View {
    @State var hours: Int = 09
    @State var minutes: Int = 30
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Text("Horários")
                    .font(.system(size: 22))
                    .fontWeight(.heavy)
                    .foregroundStyle(.appBlack)
                    .padding(.bottom, 4)
                
                VStack {
                    // Picker de horas
                    HStack {
                        Picker("", selection: $hours){
                            ForEach(0..<24, id: \.self) { i in
                                if(i < 10) {
                                    Text("0\(i)").tag(i)
                                        .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                                } else {
                                    Text("\(i)").tag(i)
                                        .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                                }
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        
                        Text(":")
                            .font(.system(size: 22))
                            .fontWeight(.heavy)
                            .foregroundStyle(.appBlack)
                            .padding(.top, 10)
                        
                        Picker("", selection: $minutes){
                            ForEach(0..<60, id: \.self) { i in
                                if(i < 10) {
                                    Text("0\(i)").tag(i)
                                        .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                                } else {
                                    Text("\(i)").tag(i)
                                        .font(.custom(FontType.t3.font, size: FontType.t3.rawValue))
                                }
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                    }
                }
                .padding(.bottom, 9)
                .padding(.horizontal, 10)
                
                
                Button("Adicionar tarefa"){
                    // ???????
                }
                .buttonStyle(DandiButtonWatch(isOrange: false))
                .padding(.top)
                
            }
            .background(.appWhite)
        }
    }
}

#Preview {
    TimePickerWatch()
}

//
//  SuggestionsView.swift
//  MC04
//
//  Created by Beatriz Andreucci on 03/04/24.
//

import SwiftUI
import SwiftData

struct SuggestionWatch: View {
    var viewModel: ViewModel = ViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Text("Hábitos")
                        .font(.custom(FontType.t1.font, size: 28))
                        .fontWeight(.bold)
                        .foregroundStyle(.black)
                    Spacer()
                }
                
                VStack(alignment: .center) {
                    ForEach(viewModel.habits) { habit in
                        NavigationLink(destination: EditTaskWatch(habitTemplate: habit)) {
                            Text("\(habit.name)")
                        }
                        .buttonStyle(SuggestionButtonWatch())
                        .padding(.top, 10)
                    }
                    
                }
                
//                NavigationLink {
//                    Text("aaa")
//                } label: {
//                    Text("Concluir rotina")
//                }
//                .buttonStyle(DandiButtonWatch())
//                .padding(.top, 22)
            } .background(Color("AppWhite"))
            
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habit.self, configurations: config)
        return SuggestionWatch()
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}

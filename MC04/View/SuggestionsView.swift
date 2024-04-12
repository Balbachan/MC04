//
//  SuggestionsView.swift
//  MC04
//
//  Created by Beatriz Andreucci on 03/04/24.
//

import SwiftUI
import SwiftData

struct SuggestionsView: View {
    var viewModel: ViewModel = ViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?
    
    
    var body: some View {
        VStack {
            ScrollView {
                HStack {
                    Text("Hábitos")
                        .font(.custom(FontType.t1.font, size: 28))
                        .fontWeight(.bold)
                    Spacer()
                }
                
                VStack(alignment: .center) {
                    ForEach(viewModel.habits) { habit in
                        NavigationLink(destination: EditTaskView(habitModel: habit)) {
                            Text("\(habit.name)")
                        }
                        .buttonStyle(SuggestionButtonStyle())
                        .padding(.top, 10)
                    }
                    
                }
                
                // MARK: Isso aqui precisa ser por cima dos cards
                NavigationLink {
                    Text("aaa")
                } label: {
                    Text("Concluir rotina")
                }
                .buttonStyle(DandiButtonStyle())
                .padding(.top, 22)
            }
            .padding(.horizontal, 40)
        }
        .background(.appWhite)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Habits.self, configurations: config)
        return SuggestionsView()
            .modelContainer(container)
    } catch {
        fatalError("Alguém me desconfigurou")
    }
}

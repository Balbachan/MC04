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
    
    var body: some View {
        NavigationStack{
            VStack {
                // Título da Seção
                HStack {
                    Text("Hábitos")
                        .font(.custom("Digitalt", size: 28))
                        .fontWeight(.bold)
                    Spacer()
                }
                
                ScrollView {
                    VStack(alignment: .center) {
                        ForEach(viewModel.habits) { habit in
                            NavigationLink(destination: EditTaskView(habitModel: habit)) {
                                Text("\(habit.name)")
                            }
                            .buttonStyle(SuggestionButtonStyle())
                            .padding(.top, 10)
                        }
                    }
                }
            }
            .padding(20)
        }
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
